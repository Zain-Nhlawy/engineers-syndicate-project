import 'package:engineers_syndicate_project/config/theme/color_theme.dart';
import 'package:flutter/material.dart';
import '../../data/models/building_model.dart';
import 'package:engineers_syndicate_project/dependencies.dart';

class BuildingCard extends StatelessWidget {
  final BuildingModel building;
  final VoidCallback onDetailsPressed;

  const BuildingCard({
    super.key,
    required this.building,
    required this.onDetailsPressed,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenWidth = size.width;
    final screenHeight = size.height;

    return Container(
      margin: EdgeInsets.only(bottom: screenHeight * 0.025),
      decoration: BoxDecoration(
        color: ColorTheme.surface,
        borderRadius: BorderRadius.circular(screenWidth * 0.05),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, screenHeight * 0.006),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(screenWidth * 0.05)),
            child: Image.network(
              '$baseUrl/${building.imagePath}',
              height: screenHeight * 0.22,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  'assets/images/logo.png',
                  height: screenHeight * 0.22,
                  width: double.infinity,
                  fit: BoxFit.cover,
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(screenWidth * 0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  building.name,
                  style: TextStyle(
                    fontSize: screenWidth * 0.055,
                    fontWeight: FontWeight.bold,
                    color: ColorTheme.textPrimary,
                  ),
                ),
                SizedBox(height: screenHeight * 0.006),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OutlinedButton(
                      onPressed: onDetailsPressed,
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: ColorTheme.primary, width: 1.2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(screenWidth * 0.03),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.06,
                          vertical: screenHeight * 0.01,
                        ),
                      ),
                      child: Text(
                        'تفاصيل',
                        style: TextStyle(
                          color: ColorTheme.primary,
                          fontSize: screenWidth * 0.04,
                        ),
                      ),
                    ),
                    Text(
                      building.workingHours,
                      style: TextStyle(
                        fontSize: screenWidth * 0.04,
                        color: ColorTheme.textPrimary.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}