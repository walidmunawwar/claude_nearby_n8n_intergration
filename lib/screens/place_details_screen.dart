import 'package:flutter/material.dart';
import '../models/place.dart';
import '../widgets/search_info_card.dart';
import '../widgets/place_info_card.dart';

class PlaceDetailsScreen extends StatelessWidget {
  final PlaceResult place;

  const PlaceDetailsScreen({Key? key, required this.place}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(place.name!),
        centerTitle: true,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // بطاقة معلومات المكان
              PlaceInfoCard(place: place),

              const SizedBox(height: 24),

              // عنوان معلومات البحث
              const Text(
                'معلومات البحث:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('العودة إلى نتائج البحث'),
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