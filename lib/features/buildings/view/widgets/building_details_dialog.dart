import 'package:flutter/material.dart';
import '../../data/models/building_model.dart';
import 'building_info_row.dart';

void showBuildingDetailsDialog(BuildContext context, BuildingModel building) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        backgroundColor: const Color(0xFFEDEBE0), 
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                width: double.infinity,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Color(0xFFDCD9CD),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
                ),
                child: Text(
                  building.name,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        'assets/images/logo.png', 
                        height: 130, 
                        width: double.infinity, 
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 15),
                    BuildingInfoRow(
                      icon: Icons.access_time, 
                      title: 'أوقات الدوام', 
                      value: building.workingHours,
                    ),
                    BuildingInfoRow(
                      icon: Icons.phone, 
                      title: 'رقم التواصل', 
                      value: building.contactNumber.isEmpty ? '09xx xxx xxx' : building.contactNumber,
                    ),
                    BuildingInfoRow(
                      icon: Icons.location_on, 
                      title: 'تفاصيل المكان', 
                      value: building.locationDetails,
                    ),
                    BuildingInfoRow(
                      icon: Icons.map, 
                      title: 'رابط الموقع على خرائط google', 
                      value: 'موقع مبنى النقابة في ${building.name}', 
                      isLink: true,
                    ),
                    BuildingInfoRow(
                      icon: Icons.business, 
                      title: 'عدد القاعات الكلي', 
                      value: building.totalRooms.toString(),
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF002623),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        ),
                        onPressed: () {
                        },
                        child: const Text(
                          'عرض قاعات المبنى', 
                          style: TextStyle(color: Colors.white, fontSize: 18),
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