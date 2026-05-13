import 'package:flutter/material.dart';
import 'features/auth/view/pages/login_page.dart';

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

      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: child!,
        );
      },

      theme: ThemeData(
        fontFamily: 'ITFQomraArabic',
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontWeight: FontWeight.w400),
          bodyLarge: TextStyle(fontWeight: FontWeight.w400),
          titleMedium: TextStyle(fontWeight: FontWeight.w700),
          titleLarge: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),

      home: const LoginPage(),
    );
  }
}