import 'package:engineers_syndicate_project/config/theme/color_theme.dart';
import 'package:engineers_syndicate_project/features/auth/view/pages/reset_password_page.dart';
import 'package:engineers_syndicate_project/features/auth/view_model/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../view_model/auth_state.dart' show ForgotPasswordLoading, ForgotPasswordEmailSentSuccess, ForgotPasswordError, AuthState;
import '../widgets/custom_text_field.dart';
import '../widgets/primary_button.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is ForgotPasswordError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error), backgroundColor: ColorTheme.onError),
            );
          }
          if (state is ForgotPasswordEmailSentSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message), backgroundColor: Colors.green),
            );
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ResetPasswordPage(
                  phoneNumber: _phoneController.text.trim(),
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              Positioned.fill(
                child: Container(color: ColorTheme.surface.withOpacity(0.90)),
              ),
              Positioned.fill(
                child: Image.asset('assets/images/background.png', fit: BoxFit.cover),
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
                          const SizedBox(height: 40),
                          Image.asset('assets/images/logo.png', height: 160),
                          const SizedBox(height: 20),
                          const Text(
                            'إعادة تعيين كلمة المرور',
                            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: ColorTheme.accent),
                          ),
                          const SizedBox(height: 15),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              'أدخل رقم هاتفك المسجل لإرسال رمز التحقق الخاص بإعادة تعيين كلمة المرور.',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 16, color: ColorTheme.textPrimary.withOpacity(0.7)),
                            ),
                          ),
                          const SizedBox(height: 40),
                          Directionality(
                            textDirection: TextDirection.rtl,
                            child: CustomTextField(
                              hint: 'رقم الهاتف',
                              icon: Icons.phone,
                              controller: _phoneController,
                            ),
                          ),
                          const SizedBox(height: 40),
                          state is ForgotPasswordLoading
                              ? const CircularProgressIndicator(color: ColorTheme.primary)
                              : PrimaryButton(
                                  text: 'إرسال الرمز',
                                  buttonColor: ColorTheme.primary,
                                  onPressed: () {
                                    context.read<AuthCubit>().forgotPassword(_phoneController.text.trim());
                                  },
                                ),
                          const SizedBox(height: 20),
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('العودة لتسجيل الدخول', style: TextStyle(color: ColorTheme.textPrimary)),
                          )
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