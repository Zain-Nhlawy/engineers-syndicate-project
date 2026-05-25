import 'package:engineers_syndicate_project/features/events/view/pages/event_slider_screen.dart';
import 'package:engineers_syndicate_project/features/events/view%20model/event_cubit.dart';
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
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Row(
              children: [
                const SizedBox(width: 20),
                Text(
                  'الفعاليات العامة',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 26,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            BlocProvider(
              create: (context) => EventsCubit()..loadEvents(),
              child: const EventsSliderScreen(),
            ),
            const SizedBox(height: 15),
            TextButton(
              onPressed: () {},
              child: Text(
                'عرض جميع الفعاليات',
                style: TextStyle(
                  fontSize: 20,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                const SizedBox(width: 20),
                Text(
                  'قاعات مبنى المزة',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 26,
                  ),
                ),
                Spacer(),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'عرض جميع ',
                    style: TextStyle(
                      fontSize: 18,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
