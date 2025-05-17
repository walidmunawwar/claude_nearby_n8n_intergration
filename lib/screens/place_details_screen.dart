import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../models/place.dart';
import '../providers/locale_provider.dart';
import '../widgets/search_info_card.dart';
import '../widgets/place_info_card.dart';
import 'package:provider/provider.dart';

class PlaceDetailsScreen extends StatelessWidget {
  final PlaceResult place;

  const PlaceDetailsScreen({Key? key, required this.place}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);
    final localizations = AppLocalizations.of(context);
    final isRtl = localeProvider.isRtl;

    return Scaffold(
      appBar: AppBar(
        title: Text(place.name ?? localizations.translate('place_details')),
        centerTitle: true,
      ),
      body: Directionality(
        textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // بطاقة معلومات المكان
              PlaceInfoCard(place: place),

              const SizedBox(height: 24),

              // عنوان معلومات البحث
              Text(
                localizations.translate('search_info_title'),
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),

              // بطاقة معلومات البحث
              SearchInfoCard(place: place),

              const SizedBox(height: 32),

              // زر العودة
              Center(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(isRtl ? Icons.arrow_forward : Icons.arrow_back),
                  label: Text(localizations.translate('back_to_results')),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}