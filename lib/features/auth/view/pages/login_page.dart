
import 'package:engineers_syndicate_project/features/auth/view/pages/forgot_password_page.dart';
import 'package:engineers_syndicate_project/features/auth/view_model/auth_cubit.dart';
import 'package:engineers_syndicate_project/features/auth/view_model/auth_state.dart';
import 'package:engineers_syndicate_project/features/home/view/pages/Navigations_tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/primary_button.dart';
import '../widgets/auth_text_link.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error), backgroundColor: Colors.red),
            );
          }
          if (state is AuthLoginSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('تم تسجيل الدخول بنجاح'), 
                backgroundColor: Colors.green,
              ),
            );
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const NavigationsTabs(),
              ),
            );
          }
        },
        builder: (context, state) {
          return Stack(
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
                child: Align(
                  alignment: Alignment.topCenter,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 14),
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
                          Directionality(
                            textDirection: TextDirection.rtl,
                            child: CustomTextField(
                              hint: 'رقم الهاتف',
                              icon: Icons.phone,
                              controller: _phoneController,
                            ),
                          ),
                          const SizedBox(height: 40),
                          Directionality(
                            textDirection: TextDirection.rtl,
                            child: CustomTextField(
                              hint: 'كلمة المرور',
                              icon: Icons.lock,
                              isPassword: true,
                              controller: _passwordController,
                            ),
                          ),
                          const SizedBox(height: 15),
                          AuthTextLink(
                            text: '',
                            actionText: 'نسيت كلمة المرور',
                            fontSize: 16,
                            actionColor: const Color(0xFF000000),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ForgotPasswordPage(),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 40),
                          
                          state is AuthLoading
                              ? const CircularProgressIndicator(color: Color(0xFF054239))
                              : PrimaryButton(
                                  text: 'تسجيل الدخول',
                                  buttonColor: const Color(0xFF002623),
                                  onPressed: () {
                                    context.read<AuthCubit>().signIn(
                                          _phoneController.text.trim(),
                                          _passwordController.text,
                                        );
                                  },
                                ),
                          const SizedBox(height: 40),
                          AuthTextLink(
                            text: 'ليس لديك حساب؟ ',
                            actionText: 'سجل الآن',
                            fontSize: 18,
                            textColor: const Color(0xFF000000),
                            actionColor: const Color(0xFF054239),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const RegisterPage(),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}