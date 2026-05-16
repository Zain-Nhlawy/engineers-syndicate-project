import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          centerTitle: true,
          title: Expanded(
            child: Row(
              children: [
                Image.asset('assets/images/logo.png', height: 50),
                const SizedBox(width: 15),
                const Text(
                  'نقابة المهندسين السوريين',
                  style: TextStyle(
                    color: Color(0xFFB9A779),
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 25),
               Container(
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(12), 
    border: Border.all(
      color: Theme.of(context).colorScheme.secondary, 
      width: 1.5, 
    ),
  ),
  child: IconButton(
    onPressed: () {},
    icon: const Icon(Icons.notifications, size: 28),
    color: Theme.of(context).colorScheme.secondary,
  ),
)
              ],
            ),
          ),

          backgroundColor: Theme.of(context).colorScheme.surface,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.elliptical(250, 10),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(color: const Color(0xFFEDEBE0).withOpacity(0.90)),
          ),
          Positioned.fill(
            child: Image.asset(
              'assets/images/background.png',
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
