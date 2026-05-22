import 'package:engineers_syndicate_project/core/di/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../view_model/buildings_cubit.dart';
import '../../view_model/buildings_state.dart';
import '../widgets/building_card.dart';
import '../widgets/building_details_dialog.dart';

class BuildingsScreen extends StatelessWidget {
  const BuildingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<BuildingsCubit>()..fetchBuildings(),
      
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: BlocBuilder<BuildingsCubit, BuildingsState>(
          builder: (context, state) {
            if (state is BuildingsLoading) {
              return const Center(
                child: CircularProgressIndicator(color: Color(0xFF054239)),
              );
            } else if (state is BuildingsError) {
              return Center(
                child: Text(
                  state.error, 
                  style: const TextStyle(color: Colors.red, fontSize: 16),
                ),
              );
            } else if (state is BuildingsSuccess) {
              final buildings = state.buildings;

              if (buildings.isEmpty) {
                return const Center(
                  child: Text('لا يوجد أبنية مضافة حالياً', style: TextStyle(fontSize: 18)),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.only(top: 10, bottom: 100, left: 15, right: 15),
                itemCount: buildings.length,
                itemBuilder: (context, index) {
                  return BuildingCard(
                    building: buildings[index],
                    onDetailsPressed: () {
                      showBuildingDetailsDialog(context, buildings[index]);
                    },
                  );
                },
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}