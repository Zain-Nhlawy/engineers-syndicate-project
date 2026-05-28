import 'package:engineers_syndicate_project/config/theme/color_theme.dart';
import 'package:engineers_syndicate_project/features/halls/view%20model/halls_cubit.dart';
import 'package:engineers_syndicate_project/features/halls/view/pages/Halls_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/building_model.dart';
import 'building_info_row.dart';
import 'package:engineers_syndicate_project/dependencies.dart';

void showBuildingDetailsDialog(BuildContext context, BuildingModel building) {
  showDialog(
    context: context,
    builder: (context) {
      final size = MediaQuery.of(context).size;
      final screenWidth = size.width;
      final screenHeight = size.height;

      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(screenWidth * 0.06),
        ),
        backgroundColor: ColorTheme.surface,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: screenHeight * 0.02,
                  horizontal: screenWidth * 0.025,
                ),
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: ColorTheme.background,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(screenWidth * 0.06),
                  ),
                ),
                child: Text(
                  building.name,
                  style: TextStyle(
                    fontSize: screenWidth * 0.05,
                    fontWeight: FontWeight.bold,
                    color: ColorTheme.textPrimary,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(screenWidth * 0.04),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(screenWidth * 0.04),
                      child: Image.network(
                        '$baseUrl/${building.imagePath}',
                        height: screenHeight * 0.22,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            'assets/images/logo.png',
                            height: screenHeight * 0.22,
                          );
                        },
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.025),
                    BuildingInfoRow(
                      icon: Icons.access_time,
                      title: 'أوقات الدوام',
                      value: building.workingHours,
                    ),
                    BuildingInfoRow(
                      icon: Icons.phone,
                      title: 'رقم التواصل',
                      value: building.contactNumber.isEmpty
                          ? 'غير متوفر'
                          : building.contactNumber,
                    ),
                    BuildingInfoRow(
                      icon: Icons.location_on,
                      title: 'عنوان المبنى',
                      value: building.address,
                    ),
                    BuildingInfoRow(
                      icon: Icons.business,
                      title: 'عدد القاعات',
                      value: building.totalRooms.toString(),
                    ),
                    SizedBox(height: screenHeight * 0.025),
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

                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                create: (context) =>
                                    HallsCubit()..loadHalls(building.id),
                                child: HallsListPage(
                                  buildingName: building.name,
                                ),
                              ),
                            ),
                          );
                        },
                        child: Text(
                          'عرض قاعات المبنى',
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
}
