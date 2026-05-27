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
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: ColorTheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            child: Image.network(
              '$baseUrl/${building.imagePath}',
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  'assets/images/logo.png',
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  building.name,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: ColorTheme.textPrimary,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OutlinedButton(
                      onPressed: onDetailsPressed,
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: ColorTheme.primary, width: 1.2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
                      ),
                      child: const Text(
                        'تفاصيل',
                        style: TextStyle(color: ColorTheme.primary, fontSize: 16),
                      ),
                    ),
                    Text(
                      building.workingHours,
                      style: TextStyle(fontSize: 16, color: ColorTheme.textPrimary.withOpacity(0.7)),
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