import 'package:engineers_syndicate_project/config/theme/color_theme.dart';
import 'package:engineers_syndicate_project/features/halls/data/model/halls_model.dart';
import 'package:engineers_syndicate_project/features/halls/data/services/halls_services.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

void showHallDetailsDialog(BuildContext context, int hallId) {
  showDialog(
    context: context,
    builder: (context) {
      return FutureBuilder<HallsModel>(
        future: GetIt.instance<HallsServices>().getHallDetails(hallId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: ColorTheme.primary));
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
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                    child: Image.asset(
                      'assets/images/test.png',
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Text(
                          "قاعة رقم ${hall.roomNumber}",
                          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: ColorTheme.textPrimary),
                        ),
                        const Divider(height: 30),
                        _buildStyledBoxRow("حالة القاعة:", hall.status),
                        _buildStyledBoxRow("السعة القصوى:", "${hall.capacityLimit}"),
                        _buildStyledBoxRow("السعر:", "${hall.pricePerHour} / سا"),
                        _buildStyledBoxRow("نوع القاعة:", hall.roomType),
                        const SizedBox(height: 20),
                        const Align(
                          alignment: Alignment.centerRight,
                          child: Text("تجهيزات القاعة:", style: TextStyle(fontWeight: FontWeight.bold, color: ColorTheme.textPrimary)),
                        ),
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: ["تكييف", "بروجكتر", "إنترنت"].map((item) => _buildStyledChip(item)).toList(),
                        ),
                        const SizedBox(height: 25),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorTheme.primary,
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                            ),
                            onPressed: () {},
                            child: const Text("حجز", style: TextStyle(color: ColorTheme.textLight, fontSize: 16)),
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

Widget _buildStyledBoxRow(String label, String value) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 6),
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    decoration: BoxDecoration(
      color: ColorTheme.primaryContainer.withOpacity(0.3),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: ColorTheme.primaryContainer),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: ColorTheme.primary, fontWeight: FontWeight.w600)),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, color: ColorTheme.textPrimary)),
      ],
    ),
  );
}

Widget _buildStyledChip(String text) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    decoration: BoxDecoration(
      color: ColorTheme.primaryContainer.withOpacity(0.3),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: ColorTheme.primaryContainer),
    ),
    child: Text(text, style: const TextStyle(color: ColorTheme.primary, fontWeight: FontWeight.bold)),
  );
}