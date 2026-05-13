import 'package:flutter/material.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/primary_button.dart';
import '../widgets/auth_text_link.dart';

class LoginPage extends StatelessWidget {
    const LoginPage({super.key});

    @override
    Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Stack(
        children: [
            Positioned.fill(
            child: Container(
                color: const Color(0xFFEDEBE0).withOpacity(0.90),
            ),
            ),
            Positioned.fill(
            child: Image.asset(
                'assets/images/background.png',
                fit: BoxFit.cover,
            ),
            ),
            SafeArea(
            child: Center(
                child: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Transform.translate(
                    offset: Offset(0, -h * 0.08),
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                        Image.asset(
                            'assets/images/logo.png',
                            height: 200,
                        ),
                        const SizedBox(height: 10),
                        const Text(
                            'نقابة المهندسين السوريين',
                            style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFB9A779),
                            ),
                        ),
                        const SizedBox(height: 30),
                        const Text(
                            'تسجيل الدخول',
                            style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.normal,
                            ),
                        ),
                        const SizedBox(height: 10),
                        const Directionality(
                            textDirection: TextDirection.rtl,
                            child: CustomTextField(
                            hint: 'الرقم الوطني',
                            icon: Icons.badge_outlined,
                            ),
                        ),
                        const SizedBox(height: 40),
                        const Directionality(
                            textDirection: TextDirection.rtl,
                            child: CustomTextField(
                            hint: 'كلمة المرور',
                            icon: Icons.lock_outline,
                            isPassword: true,
                            ),
                        ),
                        const SizedBox(height: 15),
                        AuthTextLink(
                            text: '',
                            actionText: 'نسيت كلمة المرور',
                            fontSize: 16,
                            actionColor: const Color(0xFF000000), 
                            onTap: () {},
                            ),
                        const SizedBox(height: 40),
                        PrimaryButton(
                            text: 'تسجيل الدخول',
                            buttonColor: Color(0xFF002623),
                            onPressed: () {},
                        ),
                        const SizedBox(height: 40),
                        AuthTextLink(
                            text: 'ليس لديك حساب؟ ',
                            actionText: 'سجل الآن',
                            fontSize: 18,
                            textColor: const Color(0xFF000000),
                            actionColor: Colors.blue,
                            onTap: () {},
                            ),
                        ],
                    ),
                    ),
                ),
                ),
            ),
            ),
        ],
        ),
    );
    }
}