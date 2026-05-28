import 'package:engineers_syndicate_project/config/theme/color_theme.dart';
import 'package:flutter/material.dart';

class BuildingInfoRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final bool isLink;

  const BuildingInfoRow({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    this.isLink = false,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenWidth = size.width;
    final screenHeight = size.height;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        margin: EdgeInsets.only(bottom: screenHeight * 0.012),
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.03,
          vertical: screenHeight * 0.01,
        ),
        decoration: BoxDecoration(
          color: ColorTheme.primaryContainer.withOpacity(0.3),
          borderRadius: BorderRadius.circular(screenWidth * 0.03),
        ),
        child: Row(
          children: [
            Icon(icon, color: ColorTheme.primary, size: screenWidth * 0.06),
            SizedBox(width: screenWidth * 0.025),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: screenWidth * 0.03,
                      color: ColorTheme.textPrimary.withOpacity(0.6),
                    ),
                  ),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: screenWidth * 0.035,
                      fontWeight: FontWeight.bold,
                      color: isLink
                          ? ColorTheme.textSecondary
                          : ColorTheme.textPrimary,
                      decoration: isLink
                          ? TextDecoration.underline
                          : TextDecoration.none,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
