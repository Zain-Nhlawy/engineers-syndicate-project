import 'package:flutter/material.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/primary_button.dart';
import '../widgets/top_curve_clipper.dart';

class RegisterPart2Page extends StatefulWidget {
    const RegisterPart2Page({super.key});

    @override
    State<RegisterPart2Page> createState() => _RegisterPart2PageState();
}

class _RegisterPart2PageState extends State<RegisterPart2Page>
    with SingleTickerProviderStateMixin {

    late AnimationController _animationController;
    late Animation<Offset> _slideAnimation;

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
    super.dispose();
    }

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
                child: Transform.translate(
                offset: Offset(0, -h * 0.34),
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                    Image.asset(
                        'assets/images/logo.png',
                        height: 200,
                    ),
                    ],
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
                    decoration: const BoxDecoration(
                    color: Color(0xFF002623),
                    ),
                    child: Column(
                    children: [
                        const Padding(
                        padding: EdgeInsets.only(top: 40, bottom: 10),
                        child: Center(
                            child: Text(
                            'معلومات الحساب',
                            style: TextStyle(
                                fontSize: 28,
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                            ),
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
                                const CustomTextField(
                                    hint: '',
                                    icon: Icons.phone,
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
                                const CustomTextField(
                                    hint: '',
                                    icon: Icons.lock,
                                    isPassword: true,
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
                                const CustomTextField(
                                    hint: '',
                                    icon: Icons.lock,
                                    isPassword: true,
                                ),
                                const SizedBox(height: 40),
                                Row(
                                    children: [
                                    Expanded(
                                        child: PrimaryButton(
                                        text: 'السابق',
                                        buttonColor: const Color(0xFF054239),
                                        onPressed: () {
                                            Navigator.pop(context);
                                        },
                                        ),
                                    ),
                                    Expanded(
                                        child: PrimaryButton(
                                        text: 'إنشاء الحساب',
                                        fontSize:22,
                                        buttonColor: const Color(0xFF054239),
                                        onPressed: () {
                                        },
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
        ),
    );
    }
}