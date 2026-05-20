import 'package:flutter/material.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/primary_button.dart';
import '../widgets/top_curve_clipper.dart';
import 'register_part2_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() =>
      _RegisterPageState();
}

class _RegisterPageState
    extends State<RegisterPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  late Animation<Offset> _slideAnimation;

  final firstNameController =
      TextEditingController();

  final lastNameController =
      TextEditingController();

  final nationalIdController =
      TextEditingController();

  final engineeringNumberController =
      TextEditingController();

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration:
          const Duration(milliseconds: 500),
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
      () {
        _animationController.forward();
      },
    );
  }

  @override
  void dispose() {
    _animationController.dispose();

    firstNameController.dispose();
    lastNameController.dispose();
    nationalIdController.dispose();
    engineeringNumberController.dispose();

    super.dispose();
  }

  void goToNextPage() {
    if (firstNameController.text.trim().isEmpty ||
        lastNameController.text.trim().isEmpty ||
        nationalIdController.text.trim().isEmpty ||
        engineeringNumberController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('يرجى تعبئة جميع الحقول'),
        ),
      );
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RegisterPart2Page(
          firstName: firstNameController.text.trim(),
          lastName: lastNameController.text.trim(),
          nationalId: nationalIdController.text.trim(),
          engineeringNumber: engineeringNumberController.text.trim(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              color: const Color(0xFFEDEBE0)
                  .withOpacity(0.90),
            ),
          ),

          Positioned.fill(
            child: Image.asset(
              'assets/images/background.png',
              fit: BoxFit.cover,
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 14),

                Image.asset(
                  'assets/images/logo.png',
                  height: 200,
                ),

                const SizedBox(height: 10),

                Expanded(
                  child: SlideTransition(
                    position: _slideAnimation,

                    child: ClipPath(
                      clipper: TopCurveClipper(),

                      child: Container(
                        width: double.infinity,

                        decoration:
                            const BoxDecoration(
                          color: Color(0xFF002623),
                        ),

                        child: Column(
                          children: [
                            const Padding(
                              padding:
                                  EdgeInsets.only(
                                top: 45,
                                bottom: 15,
                              ),

                              child: Center(
                                child: Text(
                                  'المعلومات الشخصية',

                                  style: TextStyle(
                                    fontSize: 28,
                                    color:
                                        Colors.white,
                                  ),
                                ),
                              ),
                            ),

                            Expanded(
                              child:
                                  SingleChildScrollView(
                                child: Padding(
                                  padding:
                                      const EdgeInsets
                                          .all(10),

                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment
                                            .start,

                                    children: [
                                      const SizedBox(
                                        height: 10,
                                      ),

                                      const Text(
                                        'الاسم الأول',

                                        textDirection:
                                            TextDirection
                                                .rtl,

                                        style: TextStyle(
                                          color: Colors
                                              .white,

                                          fontSize: 22,
                                        ),
                                      ),

                                      const SizedBox(
                                        height: 10,
                                      ),

                                      CustomTextField(
                                        hint: '',

                                        icon: Icons
                                            .person,

                                        controller:
                                            firstNameController,

                                        keyboardType:
                                            TextInputType
                                                .name,
                                      ),

                                      const SizedBox(
                                        height: 25,
                                      ),

                                      const Text(
                                        'الاسم الأخير',

                                        textDirection:
                                            TextDirection
                                                .rtl,

                                        style: TextStyle(
                                          color: Colors
                                              .white,

                                          fontSize: 22,
                                        ),
                                      ),

                                      const SizedBox(
                                        height: 10,
                                      ),

                                      CustomTextField(
                                        hint: '',

                                        icon: Icons
                                            .person,

                                        controller:
                                            lastNameController,

                                        keyboardType:
                                            TextInputType
                                                .name,
                                      ),

                                      const SizedBox(
                                        height: 25,
                                      ),

                                      const Text(
                                        'الرقم الوطني',

                                        textDirection:
                                            TextDirection
                                                .rtl,

                                        style: TextStyle(
                                          color: Colors
                                              .white,

                                          fontSize: 22,
                                        ),
                                      ),

                                      const SizedBox(
                                        height: 10,
                                      ),

                                      CustomTextField(
                                        hint: '',

                                        icon:
                                            Icons.badge,

                                        controller:
                                            nationalIdController,

                                        keyboardType:
                                            TextInputType
                                                .number,
                                      ),

                                      const SizedBox(
                                        height: 25,
                                      ),

                                      const Text(
                                        'الرقم الهندسي',

                                        textDirection:
                                            TextDirection
                                                .rtl,

                                        style: TextStyle(
                                          color: Colors
                                              .white,

                                          fontSize: 22,
                                        ),
                                      ),

                                      const SizedBox(
                                        height: 10,
                                      ),

                                      CustomTextField(
                                        hint: '',

                                        icon: Icons
                                            .engineering,

                                        controller:
                                            engineeringNumberController,

                                        keyboardType:
                                            TextInputType
                                                .number,
                                      ),

                                      const SizedBox(
                                        height: 40,
                                      ),

                                      Center(
                                        child:
                                            PrimaryButton(
                                          text:
                                              'التالي',

                                          buttonColor:
                                              const Color(
                                            0xFF054239,
                                          ),

                                          onPressed:
                                              goToNextPage,
                                        ),
                                      ),

                                      const SizedBox(
                                        height: 30,
                                      ),
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
          ),
        ],
      ),
    );
  }
}