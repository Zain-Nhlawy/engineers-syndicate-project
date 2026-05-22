import 'dart:async';
import 'package:engineers_syndicate_project/features/auth/view/widgets/otp_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../view_model/auth_cubit.dart';
import '../../view_model/auth_state.dart';
import '../widgets/primary_button.dart';
import '../widgets/top_curve_clipper.dart';

class VerifyOtpPage extends StatefulWidget {
  final String phoneNumber;

  const VerifyOtpPage({super.key, required this.phoneNumber});

  @override
  State<VerifyOtpPage> createState() => _VerifyOtpPageState();
}

class _VerifyOtpPageState extends State<VerifyOtpPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  final List<TextEditingController> _controllers =
      List.generate(6, (index) => TextEditingController());
  final List<FocusNode> _focusNodes =
      List.generate(6, (index) => FocusNode());

  Timer? _timer;
  int _secondsRemaining = 60;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _startTimer();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
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

    Future.delayed(
      const Duration(milliseconds: 200),
      () => _animationController.forward(),
    );
  }

  void _startTimer() {
    _canResend = false;
    _secondsRemaining = 60;

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          _canResend = true;
          _timer?.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var c in _controllers) {
      c.dispose();
    }
    for (var n in _focusNodes) {
      n.dispose();
    }
    _animationController.dispose();
    super.dispose();
  }

  String _getOtpCode() {
    return _controllers.map((c) => c.text).join();
  }

  void _submitVerify() {
    final code = _getOtpCode();
    if (code.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('يرجى إدخال الكود كاملاً')),
      );
      return;
    }
    context.read<AuthCubit>().verifyAccount(
          phoneNumber: widget.phoneNumber,
          secret: code,
        );
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthOtpSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
            Navigator.of(context).popUntil((route) => route.isFirst);
          }
          if (state is AuthOtpError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error),
              backgroundColor: Colors.red,),
            );
          }
          if (state is AuthResendOtpSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
            _startTimer();
          }
        },
        builder: (context, state) {
          final isLoading = state is AuthOtpLoading;

          return Stack(
            children: [
              Positioned.fill(
                child: Container(color: const Color(0xFFEDEBE0).withOpacity(0.9)),
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
                    offset: Offset(0, -h * 0.32),
                    child: Image.asset(
                      'assets/images/logo.png',
                      height: 180,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: h * 0.35,
                left: 0,
                right: 0,
                bottom: 0,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: ClipPath(
                    clipper: TopCurveClipper(),
                    child: Container(
                      color: const Color(0xFF002623),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: [
                              const SizedBox(height: 50),
                              const Text(
                                'تأكيد الحساب',
                                style: TextStyle(
                                  fontSize: 28,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 15),
                              Text(
                                'تم إرسال رمز التحقق إلى الرقم\n ${widget.phoneNumber}',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.white70,
                                ),
                              ),
                              const SizedBox(height: 40),
                              Directionality(
                                textDirection: TextDirection.ltr,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: List.generate(
                                    6,
                                    (index) => OtpBox(
                                      controller: _controllers[index],
                                      focusNode: _focusNodes[index],
                                      onChanged: (value) {
                                        if (value.isNotEmpty) {
                                          if (index < 5) {
                                            FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
                                          } else {
                                            _focusNodes[index].unfocus();
                                          }
                                        } else {
                                          if (index > 0) {
                                            FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
                                          }
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 35),
                              Text(
                                _canResend
                                    ? "يمكنك الآن إعادة طلب الكود"
                                    : "إعادة إرسال الكود خلال $_secondsRemaining ثانية",
                                style: const TextStyle(
                                  color: Colors.white60,
                                  fontSize: 16,
                                ),
                              ),
                              TextButton(
                                onPressed: _canResend
                                    ? () => context.read<AuthCubit>().resendAccountOtp(widget.phoneNumber)
                                    : null,
                                child: Text(
                                  'إعادة إرسال',
                                  style: TextStyle(
                                    color: _canResend ? Colors.amber : Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 25),
                              PrimaryButton(
                                text: isLoading ? 'جاري التحقق...' : 'تأكيد الحساب',
                                buttonColor: const Color(0xFF054239),
                                onPressed: isLoading ? null : _submitVerify,
                              ),
                              const SizedBox(height: 25),
                            ],
                          ),
                        ),
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