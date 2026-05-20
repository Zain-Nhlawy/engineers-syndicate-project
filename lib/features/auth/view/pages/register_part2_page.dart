import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/user_model.dart';
import '../../view_model/auth_cubit.dart';
import '../../view_model/auth_state.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/primary_button.dart';
import '../widgets/top_curve_clipper.dart';


class RegisterPart2Page extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String nationalId;
  final String engineeringNumber;

  const RegisterPart2Page({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.nationalId,
    required this.engineeringNumber,
  });

  @override
  State<RegisterPart2Page> createState() =>
      _RegisterPart2PageState();
}

class _RegisterPart2PageState extends State<RegisterPart2Page>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );

    Future.delayed(const Duration(milliseconds: 200), () {
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  bool _validateInputs() {
    final phone = phoneController.text.trim();
    final pass = passwordController.text;
    final confirm = confirmPasswordController.text;

    if (phone.isEmpty || pass.isEmpty || confirm.isEmpty) {
      _showMsg('يرجى تعبئة جميع الحقول');
      return false;
    }

    if (phone.length < 10) {
      _showMsg('رقم الهاتف غير صحيح');
      return false;
    }

    if (pass.length < 6) {
      _showMsg('كلمة المرور يجب أن تكون 6 أحرف على الأقل');
      return false;
    }

    if (pass != confirm) {
      _showMsg('كلمتا المرور غير متطابقتين');
      return false;
    }

    return true;
  }

  void _showMsg(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg)),
    );
  }

  void _submit() {
    if (!_validateInputs()) return;

    final user = UserModel(
      firstName: widget.firstName,
      lastName: widget.lastName,
      nationalId: widget.nationalId,
      engineeringNumber: widget.engineeringNumber,
      phoneNumber: phoneController.text.trim(),
      password: passwordController.text.trim(),
    );

    context.read<AuthCubit>().signUp(user);
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            _showMsg(state.message);
          }

          if (state is AuthError) {
            _showMsg(state.error);
          }
        },
        builder: (context, state) {
          final isLoading = state is AuthLoading;

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
                child: Center(
                  child: Transform.translate(
                    offset: Offset(0, -h * 0.34),
                    child: Image.asset(
                      'assets/images/logo.png',
                      height: 200,
                    ),
                  ),
                ),
              ),

              Positioned(
                top: h * 0.32,
                left: 0,
                right: 0,
                bottom: 0,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: ClipPath(
                    clipper: TopCurveClipper(),
                    child: Container(
                      color: const Color(0xFF002623),
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 40, bottom: 10),
                            child: Text(
                              'معلومات الحساب',
                              style: TextStyle(
                                fontSize: 28,
                                color: Colors.white,
                              ),
                            ),
                          ),

                          Expanded(
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    const Text(
                                      'رقم الهاتف',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
                                      ),
                                    ),
                                    const SizedBox(height: 10),

                                    CustomTextField(
                                      hint: '',
                                      icon: Icons.phone,
                                      controller: phoneController,
                                      keyboardType: TextInputType.phone,
                                    ),

                                    const SizedBox(height: 25),

                                    const Text(
                                      'كلمة المرور',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
                                      ),
                                    ),
                                    const SizedBox(height: 10),

                                    CustomTextField(
                                      hint: '',
                                      icon: Icons.lock,
                                      isPassword: true,
                                      controller: passwordController,
                                    ),

                                    const SizedBox(height: 25),

                                    const Text(
                                      'تأكيد كلمة المرور',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
                                      ),
                                    ),
                                    const SizedBox(height: 10),

                                    CustomTextField(
                                      hint: '',
                                      icon: Icons.lock,
                                      isPassword: true,
                                      controller: confirmPasswordController,
                                    ),

                                    const SizedBox(height: 40),

                                    Row(
                                      children: [
                                        Expanded(
                                          child: PrimaryButton(
                                            text: 'السابق',
                                            buttonColor: const Color(0xFF054239),
                                            onPressed: () => Navigator.pop(context),
                                          ),
                                        ),
                                        const SizedBox(width: 10),

                                        Expanded(
                                          child: PrimaryButton(
                                            text: isLoading
                                                ? 'جاري الإنشاء...'
                                                : 'إنشاء الحساب',
                                            fontSize: 22,
                                            buttonColor: const Color(0xFF054239),
                                            onPressed: isLoading ? null : _submit,
                                          ),
                                        ),
                                      ],
                                    ),

                                    const SizedBox(height: 30),
                                  ],
                                ),
                              ),
                            ),
                          ),
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