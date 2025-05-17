import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../l10n/app_localizations.dart';
import '../models/place.dart';
import '../providers/locale_provider.dart';
import '../services/api_service.dart';
import '../widgets/language_switcher.dart';
import '../widgets/place_list_item.dart';
import '../widgets/search_prompt_card.dart';
import 'place_details_screen.dart';

/// The main search screen of the application.
/// 
/// This screen allows users to search for locations and displays the search results.
class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _promptController = TextEditingController();
  bool _isLoading = false;
  String _errorMessage = '';
  List<PlaceResult> _searchResults = [];

  /// Searches for locations based on the user's input.
  /// 
  /// Validates the input and makes an API call to fetch the results.
  Future<void> _searchLocations() async {
    final localizations = AppLocalizations.of(context);
    
    if (_promptController.text.trim().isEmpty) {
      setState(() {
        _errorMessage = localizations.translate('error_empty_query');
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    final results = await ApiService.searchLocations(_promptController.text);

    try {
      setState(() {
        _searchResults = results!;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);
    final localizations = AppLocalizations.of(context);
    final isRtl = localeProvider.isRtl;
    
    // Get screen size for responsive design
    final screenSize = MediaQuery.of(context).size;
    final isLargeScreen = screenSize.width > 600;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          localizations.translate('search_screen_title'),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          // Language switcher in the app bar
          const LanguageSwitcher(),
        ],
      ),
      body: Directionality(
        textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
        child: Padding(
          padding: EdgeInsets.all(isLargeScreen ? 24.0 : 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Search card
              SearchPromptCard(
                controller: _promptController,
                onSearch: _searchLocations,
                isLoading: _isLoading,
              ),

              // Error message
              if (_errorMessage.isNotEmpty) ...[
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.red.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.error_outline, color: Colors.red.shade800),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _errorMessage,
                          style: TextStyle(color: Colors.red.shade800),
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              // Results title
              const SizedBox(height: 20),
              Text(
                localizations.translate('results_count', args: {'count': _searchResults.length.toString()}),
                style: TextStyle(
                  fontSize: isLargeScreen ? 20 : 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),

              // Results display
              Expanded(
                child: _buildResultsContent(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the content to display based on the search state.
  /// 
  /// Shows loading indicator, empty state, or search results.
  Widget _buildResultsContent() {
    final localizations = AppLocalizations.of(context);
    final screenSize = MediaQuery.of(context).size;
    final isLargeScreen = screenSize.width > 600;
    
    if (_isLoading) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 16),
            Text(
              localizations.translate('searching'),
              style: TextStyle(
                fontSize: isLargeScreen ? 18 : 16, 
                color: Colors.grey
              ),
            ),
          ],
        ),
      );
    }

    if (_searchResults.isEmpty && _errorMessage.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.search_off,
              size: isLargeScreen ? 80 : 64,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 16),
            Text(
              localizations.translate('no_results'),
              style: TextStyle(
                fontSize: isLargeScreen ? 20 : 18, 
                color: Colors.grey
              ),
            ),
            const SizedBox(height: 8),
            Text(
              localizations.translate('try_search_suggestion'),
              style: TextStyle(
                fontSize: isLargeScreen ? 16 : 14, 
                color: Colors.grey
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    // For larger screens, use a grid layout instead of a list
    if (isLargeScreen) {
      return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2.5,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: _searchResults.length,
        itemBuilder: (context, index) {
          final place = _searchResults[index];
          return PlaceListItem(
            place: place,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PlaceDetailsScreen(place: place),
                ),
              );
            },
          );
        },
      );
    } else {
      // For smaller screens, use a list layout
      return ListView.builder(
        itemCount: _searchResults.length,
        itemBuilder: (context, index) {
          final place = _searchResults[index];
          return PlaceListItem(
            place: place,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PlaceDetailsScreen(place: place),
                ),
              );
            },
          );
        },
      );
    }
  }
}
