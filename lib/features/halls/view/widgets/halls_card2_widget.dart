import 'package:engineers_syndicate_project/config/theme/color_theme.dart';
import 'package:flutter/material.dart';
import 'package:engineers_syndicate_project/features/halls/data/model/halls_model.dart';
import 'package:engineers_syndicate_project/features/halls/view/widgets/hall_details_dialog.dart';

class HallsCard2 extends StatelessWidget {
  final HallsModel halls;

  const HallsCard2({super.key, required this.halls});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shadowColor: Colors.black.withOpacity(0.2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Stack(
            children: [
              SizedBox(
                height: 150,
                width: double.infinity,
                child: Image.asset(
                  'assets/images/test.png',
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 10,
                left: 10,
                child: _buildInfoIcon(Icons.person, '${halls.capacityLimit ?? 0}'),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: _buildInfoIcon(Icons.attach_money, '${halls.pricePerHour ?? 0}'),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'القاعة رقم ${halls.roomNumber}',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: ColorTheme.textPrimary),
                    ),
                  ],
                ),
                OutlinedButton(
                  onPressed: () {
                    showHallDetailsDialog(context, halls.id ?? 0);
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: ColorTheme.primary),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text('تفاصيل', style: TextStyle(color: ColorTheme.primary)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoIcon(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.white),
          const SizedBox(width: 4),
          Text(text, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}