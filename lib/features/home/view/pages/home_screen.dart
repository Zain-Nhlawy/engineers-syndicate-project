import 'package:engineers_syndicate_project/features/events/view/pages/event_slider_screen.dart';
import 'package:engineers_syndicate_project/features/events/view%20model/event_cubit.dart';
import 'package:engineers_syndicate_project/features/halls/view%20model/halls_cubit.dart';
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
                padding: const EdgeInsets.symmetric(vertical: 20),
                children: [
                  Row(
                    children: [
                      const SizedBox(width: 20),
                      Text(
                        'الفعاليات العامة',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  const EventsSliderScreen(),
                  const SizedBox(height: 10),
                  Center(
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'عرض جميع الفعاليات',
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const SizedBox(width: 20),
                      Text(
                        'قاعات مبنى المزة',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'عرض جميع ',
                          style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                    ],
                  ),
                  const SizedBox(height: 15),
                  BlocProvider(
                    create: (context) => HallsCubit()..loadHalls(1),
                    child: const HallsCardView(),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      const SizedBox(width: 20),
                      Text(
                        'قاعات مبنى الصالحية',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'عرض جميع ',
                          style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                    ],
                  ),
                  const SizedBox(height: 15),
                  BlocProvider(
                    create: (context) => HallsCubit()..loadHalls(2),
                    child: const HallsCardView(),
                  ),
                  const SizedBox(height: 150),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}