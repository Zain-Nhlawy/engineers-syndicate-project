import 'package:engineers_syndicate_project/config/theme/app_theme.dart';
import 'package:engineers_syndicate_project/features/home/view/pages/home_screen.dart';
import 'package:engineers_syndicate_project/features/home/view/pages/navigations_tabs.dart';
import 'package:flutter/material.dart';
import 'features/auth/view/pages/login_page.dart';
import 'features/auth/view/pages/register_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Engineers Syndicate',
      theme: AppTheme.lightTheme,
      themeMode: ThemeMode.light,
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: child!,
        );
      },

      home: const NavigationsTabs(),
    );
  }
}