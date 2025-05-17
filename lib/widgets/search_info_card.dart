import 'package:flutter/material.dart';
import '../models/place.dart';

class SearchInfoCard extends StatelessWidget {
  final PlaceResult place;

  const SearchInfoCard({Key? key, required this.place}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('تم العثور عليه بواسطة عدد النقاط: ${place.foundInSearchPoints}'),
            const SizedBox(height: 8),
            Text('معرفات نقاط البحث: ${place.foundByPointIds!.join(', ')}'),
          ],
        ),
      ),
    );
  }
}