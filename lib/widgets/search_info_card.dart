import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../models/place.dart';

class SearchInfoCard extends StatelessWidget {
  final PlaceResult place;

  const SearchInfoCard({Key? key, required this.place}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              localizations.translate(
                'found_by_points_count',
                args: {'count': '${place.foundInSearchPoints ?? 0}'},
              ),
            ),
            const SizedBox(height: 8),
            Text(
              localizations.translate(
                'search_point_ids',
                args: {'ids': place.foundByPointIds?.join(', ') ?? ''},
              ),
            ),
          ],
        ),
      ),
    );
  }
}