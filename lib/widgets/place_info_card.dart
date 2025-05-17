import 'package:flutter/material.dart';
import '../models/place.dart';

class PlaceInfoCard extends StatelessWidget {
  final PlaceResult place;

  const PlaceInfoCard({Key? key, required this.place}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // اسم المكان والتقييم
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    place.name!,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (place.rating != null)
                  _buildRatingBadge(place.rating!),
              ],
            ),
            const SizedBox(height: 12),
            const Divider(),
            const SizedBox(height: 8),

            // العنوان
            _buildDetailRow(Icons.location_on, 'العنوان:', place.address!),
            const SizedBox(height: 16),

            // الإحداثيات
            _buildDetailRow(
              Icons.pin_drop,
              'الإحداثيات:',
              ""
              // 'خط العرض: ${place.location['lat']}, خط الطول: ${place.location['lng']}',
            ),
            const SizedBox(height: 16),

            // الفئات
            if (place.types!.isNotEmpty) ...[
              _buildDetailRow(
                Icons.category,
                'الفئات:',
                place.types!.join(', '),
              ),
              const SizedBox(height: 16),
            ],

            // حالة العمل
            _buildDetailRow(
              Icons.business,
              'حالة العمل:',
              place.businessStatus == 'OPERATIONAL' ? 'مفتوح' : place.businessStatus!,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRatingBadge(double rating) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Text(
            '$rating',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 4),
          const Icon(Icons.star, color: Colors.white, size: 16),
        ],
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.blue, size: 20),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}
