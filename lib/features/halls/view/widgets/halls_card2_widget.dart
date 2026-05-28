import 'package:engineers_syndicate_project/config/theme/color_theme.dart';
import 'package:flutter/material.dart';
import 'package:engineers_syndicate_project/features/halls/data/model/halls_model.dart';
import 'package:engineers_syndicate_project/features/halls/view/widgets/hall_details_dialog.dart';

class HallsCard2 extends StatelessWidget {
  final HallsModel halls;

  const HallsCard2({super.key, required this.halls});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenWidth = size.width;
    final screenHeight = size.height;

    return Card(
      elevation: 4,
      shadowColor: Colors.black.withOpacity(0.2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(screenWidth * 0.05)),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Stack(
            children: [
              SizedBox(
                height: screenHeight * 0.18,
                width: double.infinity,
                child: Image.asset(
                  'assets/images/test.png',
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: screenHeight * 0.012,
                left: screenWidth * 0.025,
                child: _buildInfoIcon(Icons.person, '${halls.capacityLimit ?? 0}', screenWidth, screenHeight),
              ),
              Positioned(
                top: screenHeight * 0.012,
                right: screenWidth * 0.025,
                child: _buildInfoIcon(Icons.attach_money, '${halls.pricePerHour ?? 0}', screenWidth, screenHeight),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(screenWidth * 0.03),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'القاعة رقم ${halls.roomNumber}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth * 0.04,
                        color: ColorTheme.textPrimary,
                      ),
                    ),
                  ],
                ),
                OutlinedButton(
                  onPressed: () {
                    showHallDetailsDialog(context, halls.id ?? 0);
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: ColorTheme.primary),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(screenWidth * 0.025),
                    ),
                  ),
                  child: Text(
                    'تفاصيل',
                    style: TextStyle(
                      color: ColorTheme.primary,
                      fontSize: screenWidth * 0.035,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoIcon(IconData icon, String text, double screenWidth, double screenHeight) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.02,
        vertical: screenHeight * 0.005,
      ),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.5),
        borderRadius: BorderRadius.circular(screenWidth * 0.03),
      ),
      child: Row(
        children: [
          Icon(icon, size: screenWidth * 0.04, color: Colors.white),
          SizedBox(width: screenWidth * 0.01),
          Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: screenWidth * 0.035,
            ),
          ),
        ],
      ),
    );
  }
}