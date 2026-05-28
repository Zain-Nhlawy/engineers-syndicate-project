import 'package:engineers_syndicate_project/config/theme/color_theme.dart';
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
    final size = MediaQuery.of(context).size;
    final screenWidth = size.width;
    final screenHeight = size.height;

    return BlocProvider(
      create: (context) => getIt<BuildingsCubit>()..fetchBuildings(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: BlocBuilder<BuildingsCubit, BuildingsState>(
          builder: (context, state) {
            if (state is BuildingsLoading) {
              return const Center(
                child: CircularProgressIndicator(color: ColorTheme.primary),
              );
            } else if (state is BuildingsError) {
              return Center(
                child: Text(
                  state.error,
                  style: TextStyle(
                    color: ColorTheme.onError,
                    fontSize: screenWidth * 0.04,
                  ),
                ),
              );
            } else if (state is BuildingsSuccess) {
              final buildings = state.buildings;

              if (buildings.isEmpty) {
                return Center(
                  child: Text(
                    'لا يوجد أبنية مضافة حالياً',
                    style: TextStyle(
                      fontSize: screenWidth * 0.045,
                      color: ColorTheme.textPrimary,
                    ),
                  ),
                );
              }

              return ListView.builder(
                padding: EdgeInsets.only(
                  top: screenHeight * 0.012,
                  bottom: screenHeight * 0.12,
                  left: screenWidth * 0.04,
                  right: screenWidth * 0.04,
                ),
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
