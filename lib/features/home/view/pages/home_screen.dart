import 'package:engineers_syndicate_project/features/events/view/pages/event_slider_screen.dart';
import 'package:engineers_syndicate_project/features/events/view%20model/event_cubit.dart';
import 'package:engineers_syndicate_project/features/halls/view%20model/halls_cubit.dart';
import 'package:engineers_syndicate_project/features/halls/view/pages/Halls_list_page.dart';
import 'package:engineers_syndicate_project/features/halls/view/pages/halls_card_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenWidth = size.width;
    final screenHeight = size.height;

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => EventsCubit()..loadEvents()),
      ],
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Builder(
          builder: (context) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<EventsCubit>().loadEvents();
              },
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(vertical: screenHeight * 0.025),
                children: [
                  Row(
                    children: [
                      SizedBox(width: screenWidth * 0.05),
                      Text(
                        'الفعاليات العامة',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontSize: screenWidth * 0.05,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  const EventsSliderScreen(),
                  SizedBox(height: screenHeight * 0.015),
                  Center(
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'عرض جميع الفعاليات',
                        style: TextStyle(
                          fontSize: screenWidth * 0.04,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Row(
                    children: [
                      SizedBox(width: screenWidth * 0.05),
                      Text(
                        'قاعات مبنى المزة',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontSize: screenWidth * 0.05,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                create: (context) => HallsCubit()..loadHalls(1),
                                child: const HallsListPage(
                                  buildingName: 'مبنى المزة',
                                ),
                              ),
                            ),
                          );
                        },
                        child: Text(
                          'عرض جميع ',
                          style: TextStyle(
                            fontSize: screenWidth * 0.04,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.025),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  BlocProvider(
                    create: (context) => HallsCubit()..loadHalls(1),
                    child: const HallsCardView(),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Row(
                    children: [
                      SizedBox(width: screenWidth * 0.05),
                      Text(
                        'قاعات مبنى الصالحية',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontSize: screenWidth * 0.05,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                create: (context) => HallsCubit()..loadHalls(2),
                                child: const HallsListPage(
                                  buildingName: 'مبنى الصالحية',
                                ),
                              ),
                            ),
                          );
                        },
                        child: Text(
                          'عرض جميع ',
                          style: TextStyle(
                            fontSize: screenWidth * 0.04,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.025),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  BlocProvider(
                    create: (context) => HallsCubit()..loadHalls(2),
                    child: const HallsCardView(),
                  ),
                  SizedBox(height: screenHeight * 0.18),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
