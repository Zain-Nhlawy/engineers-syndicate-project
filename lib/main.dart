import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:engineers_syndicate_project/config/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/auth/view/pages/login_page.dart';
import 'features/auth/view_model/auth_cubit.dart';
import 'core/di/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AuthCubit>(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,        
        supportedLocales: const [
          Locale('ar'),
          Locale('en'), 
        ],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        title: 'Engineers Syndicate',
        theme: AppTheme.lightTheme,
        themeMode: ThemeMode.light,
        builder: (context, child) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: child!,
          );
        },
        home: const LoginPage(), 
      ),
    );
  }
}