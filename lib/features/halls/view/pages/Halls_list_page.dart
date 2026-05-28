import 'package:engineers_syndicate_project/config/theme/color_theme.dart';
import 'package:engineers_syndicate_project/features/halls/view/widgets/halls_card2_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:engineers_syndicate_project/features/halls/view%20model/halls_cubit.dart';
import 'package:engineers_syndicate_project/features/halls/view%20model/halls_state.dart';

class HallsListPage extends StatelessWidget {
  final String buildingName;

  const HallsListPage({super.key, required this.buildingName});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenWidth = size.width;
    final screenHeight = size.height;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text(
              buildingName,
              style: TextStyle(
                color: ColorTheme.textPrimary,
                fontWeight: FontWeight.bold,
                fontSize: screenWidth * 0.05,
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            iconTheme: IconThemeData(
              color: ColorTheme.textPrimary,
              size: screenWidth * 0.06,
            ),
          ),
          body: BlocBuilder<HallsCubit, HallsState>(
            builder: (context, state) {
              if (state is HallsLoading) {
                return const Center(child: CircularProgressIndicator(color: ColorTheme.primary));
              } else if (state is HallsLoaded) {
                if (state.halls.isEmpty) {
                  return Center(
                    child: Text(
                      "لا توجد قاعات لهذا المبنى",
                      style: TextStyle(
                        color: ColorTheme.textPrimary,
                        fontSize: screenWidth * 0.045,
                      ),
                    ),
                  );
                }

                return ListView.separated(
                  padding: EdgeInsets.all(screenWidth * 0.04),
                  itemCount: state.halls.length,
                  separatorBuilder: (context, index) => SizedBox(height: screenHeight * 0.02),
                  itemBuilder: (context, index) {
                    return HallsCard2(halls: state.halls[index]);
                  },
                );
              } else if (state is HallsError) {
                return Center(
                  child: Text(
                    state.message,
                    style: TextStyle(
                      color: ColorTheme.onError,
                      fontSize: screenWidth * 0.04,
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}