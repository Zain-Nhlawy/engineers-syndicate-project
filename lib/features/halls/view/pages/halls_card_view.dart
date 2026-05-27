import 'package:flutter/material.dart';
import 'package:engineers_syndicate_project/features/halls/view%20model/halls_cubit.dart';
import 'package:engineers_syndicate_project/features/halls/view%20model/halls_state.dart';
import 'package:engineers_syndicate_project/features/halls/view/widgets/halls_card_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HallsCardView extends StatelessWidget {
  const HallsCardView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HallsCubit, HallsState>(
      builder: (context, state) {
        if (state is HallsInitial || state is HallsLoading) {
          return const SizedBox(
            height: 160,
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is HallsLoaded) {
          if (state.halls.isEmpty) return const SizedBox.shrink();

          return SizedBox(
            height: 160,
            child: ListView.builder(
              itemCount: state.halls.length,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
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
