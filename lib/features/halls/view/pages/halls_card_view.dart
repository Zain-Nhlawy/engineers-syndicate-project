import 'package:flutter/material.dart';
import 'package:engineers_syndicate_project/features/halls/view%20model/halls_cubit.dart';
import 'package:engineers_syndicate_project/features/halls/view%20model/halls_state.dart';
import 'package:engineers_syndicate_project/features/halls/view/widgets/halls_card_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HallsCardView extends StatelessWidget {
  const HallsCardView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenWidth = size.width;
    final screenHeight = size.height;

    return BlocBuilder<HallsCubit, HallsState>(
      builder: (context, state) {
        if (state is HallsInitial || state is HallsLoading) {
          return SizedBox(
            height: screenHeight * 0.20,
            child: const Center(child: CircularProgressIndicator()),
          );
        }

        if (state is HallsLoaded) {
          if (state.halls.isEmpty) return const SizedBox.shrink();

          return SizedBox(
            height: screenHeight * 0.20,
            child: ListView.builder(
              itemCount: state.halls.length,
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
                  child: HallsCardWidget(halls: state.halls[index]),
                );
              },
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}