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
            title: Text(buildingName),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: BlocBuilder<HallsCubit, HallsState>(
            builder: (context, state) {
              if (state is HallsLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is HallsLoaded) {
                if (state.halls.isEmpty) {
                  return const Center(child: Text("لا توجد قاعات لهذا المبنى"));
                }

                return ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: state.halls.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      return HallsCard2(halls: state.halls[index]);
                    },
                  );
              } else if (state is HallsError) {
                return Center(child: Text(state.message));
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}