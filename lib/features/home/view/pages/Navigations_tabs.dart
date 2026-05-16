import 'package:flutter/material.dart';

class NavigationsTabs extends StatefulWidget {
  const NavigationsTabs({super.key});

  @override
  State<NavigationsTabs> createState() => _NavigationsTabsState();
}

class _NavigationsTabsState extends State<NavigationsTabs> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();
  late final List<Widget> _pages;

    @override
  void initState() {
    super.initState();
    _pages = [

    ];
  }

  

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}