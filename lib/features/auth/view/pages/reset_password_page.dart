import 'package:engineers_syndicate_project/features/auth/view_model/auth_cubit.dart';
import 'package:engineers_syndicate_project/features/auth/view_model/auth_state.dart' show ResetPasswordLoading, ResetPasswordSuccess, ResetPasswordError, AuthState;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/primary_button.dart';

class ResetPasswordPage extends StatefulWidget {
  final String phoneNumber; 

  const ResetPasswordPage({super.key, required this.phoneNumber});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final TextEditingController _otpController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _otpController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is ResetPasswordError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error), backgroundColor: Colors.red),
            );
          }
          if (state is ResetPasswordSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message), backgroundColor: Colors.green),
            );
            Navigator.of(context).popUntil((route) => route.isFirst);
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              Positioned.fill(
                child: Container(color: const Color(0xFFEDEBE0).withOpacity(0.90)),
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
                            'تأكيد الهوية والتعيين',
                            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Color(0xFFB9A779)),
                          ),
                          const SizedBox(height: 30),
                          
                          Directionality(
                            textDirection: TextDirection.rtl,
                            child: CustomTextField(
                              hint: 'رمز التحقق (OTP)',
                              icon: Icons.domain_verification,
                              controller: _otpController,
                            ),
                          ),
                          const SizedBox(height: 25),
                          
                          Directionality(
                            textDirection: TextDirection.rtl,
                            child: CustomTextField(
                              hint: 'كلمة المرور الجديدة',
                              icon: Icons.lock_reset,
                              isPassword: true,
                              controller: _passwordController,
                            ),
                          ),
                          const SizedBox(height: 40),
                          
                          state is ResetPasswordLoading
                              ? const CircularProgressIndicator(color: Color(0xFF054239))
                              : PrimaryButton(
                                  text: 'تحديث',
                                  buttonColor: const Color(0xFF002623),
                                  onPressed: () {
                                    if (_otpController.text.trim().isEmpty || _passwordController.text.isEmpty) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('الرجاء إدخال رمز التحقق وكلمة المرور الجديدة'), backgroundColor: Colors.orange),
                                      );
                                      return;
                                    }
                                    context.read<AuthCubit>().resetPassword(
                                          phoneNumber: widget.phoneNumber,
                                          token: _otpController.text.trim(),
                                          newPassword: _passwordController.text,
                                        );
                                  },
                                ),
                          const SizedBox(height: 20),
                          TextButton(
                            onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
                            child: const Text('إلغاء والعودة للرئيسية', style: TextStyle(color: Colors.black54)),
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