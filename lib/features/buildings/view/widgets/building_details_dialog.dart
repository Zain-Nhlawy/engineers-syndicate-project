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
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        backgroundColor: ColorTheme.surface,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: ColorTheme.background,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
                ),
                child: Text(
                  building.name,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: ColorTheme.textPrimary),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        '$baseUrl/${building.imagePath}',
                        height: 180,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset('assets/images/logo.png', height: 180);
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    BuildingInfoRow(icon: Icons.access_time, title: 'أوقات الدوام', value: building.workingHours),
                    BuildingInfoRow(icon: Icons.phone, title: 'رقم التواصل', value: building.contactNumber.isEmpty ? 'غير متوفر' : building.contactNumber),
                    BuildingInfoRow(icon: Icons.location_on, title: 'عنوان المبنى', value: building.address),
                    BuildingInfoRow(icon: Icons.business, title: 'عدد القاعات', value: building.totalRooms.toString()),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorTheme.primary,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                create: (context) => HallsCubit()..loadHalls(building.id),
                                child: HallsListPage(buildingName: building.name),
                              ),
                            ),
                          );
                        },
                        child: const Text('عرض قاعات المبنى', style: TextStyle(color: ColorTheme.textLight, fontSize: 18)),
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