import 'package:engineers_syndicate_project/config/theme/color_theme.dart';
import 'package:engineers_syndicate_project/features/halls/data/model/halls_model.dart';
import 'package:engineers_syndicate_project/features/halls/data/services/halls_services.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

void showHallDetailsDialog(BuildContext context, int hallId) {
  showDialog(
    context: context,
    builder: (context) {
      final size = MediaQuery.of(context).size;
      final screenWidth = size.width;
      final screenHeight = size.height;

      return FutureBuilder<HallsModel>(
        future: GetIt.instance<HallsServices>().getHallDetails(hallId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: ColorTheme.primary),
            );
          }
          if (snapshot.hasError) {
            return AlertDialog(
              title: const Text("خطأ"),
              content: Text(snapshot.error.toString()),
            );
          }
          if (!snapshot.hasData) return const SizedBox.shrink();

          final hall = snapshot.data!;
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                    child: Image.asset(
                      'assets/images/test.png',
                      height: screenHeight * 0.25,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(screenWidth * 0.05),
                    child: Column(
                      children: [
                        Text(
                          "قاعة رقم ${hall.roomNumber}",
                          style: TextStyle(
                            fontSize: screenWidth * 0.055,
                            fontWeight: FontWeight.bold,
                            color: ColorTheme.textPrimary,
                          ),
                        ),
                        Divider(height: screenHeight * 0.035),
                        _buildStyledBoxRow(
                          "حالة القاعة:",
                          hall.status,
                          screenWidth,
                          screenHeight,
                        ),
                        _buildStyledBoxRow(
                          "السعة القصوى:",
                          "${hall.capacityLimit}",
                          screenWidth,
                          screenHeight,
                        ),
                        _buildStyledBoxRow(
                          "السعر:",
                          "${hall.pricePerHour} / سا",
                          screenWidth,
                          screenHeight,
                        ),
                        _buildStyledBoxRow(
                          "نوع القاعة:",
                          hall.roomType,
                          screenWidth,
                          screenHeight,
                        ),
                        SizedBox(height: screenHeight * 0.025),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "تجهيزات القاعة:",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: ColorTheme.textPrimary,
                              fontSize: screenWidth * 0.04,
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.012),
                        Wrap(
                          spacing: screenWidth * 0.02,
                          runSpacing: screenHeight * 0.01,
                          children: ["تكييف", "بروجكتر", "إنترنت"]
                              .map(
                                (item) => _buildStyledChip(
                                  item,
                                  screenWidth,
                                  screenHeight,
                                ),
                              )
                              .toList(),
                        ),
                        SizedBox(height: screenHeight * 0.03),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorTheme.primary,
                              padding: EdgeInsets.symmetric(
                                vertical: screenHeight * 0.01,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            onPressed: () {},
                            child: Text(
                              "حجز",
                              style: TextStyle(
                                color: ColorTheme.textLight,
                                fontSize: screenWidth * 0.04,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}

Widget _buildStyledBoxRow(
  String label,
  String value,
  double screenWidth,
  double screenHeight,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: screenHeight * 0.008),
    padding: EdgeInsets.symmetric(
      horizontal: screenWidth * 0.03,
      vertical: screenHeight * 0.015,
    ),
    decoration: BoxDecoration(
      color: ColorTheme.primaryContainer.withOpacity(0.3),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: ColorTheme.primaryContainer),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: ColorTheme.primary,
            fontWeight: FontWeight.w600,
            fontSize: screenWidth * 0.035,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: ColorTheme.textPrimary,
            fontSize: screenWidth * 0.035,
          ),
        ),
      ],
    ),
  );
}

Widget _buildStyledChip(String text, double screenWidth, double screenHeight) {
  return Container(
    padding: EdgeInsets.symmetric(
      horizontal: screenWidth * 0.04,
      vertical: screenHeight * 0.01,
    ),
    decoration: BoxDecoration(
      color: ColorTheme.primaryContainer.withOpacity(0.3),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: ColorTheme.primaryContainer),
    ),
    child: Text(
      text,
      style: TextStyle(
        color: ColorTheme.primary,
        fontWeight: FontWeight.bold,
        fontSize: screenWidth * 0.035,
      ),
    ),
  );
}
