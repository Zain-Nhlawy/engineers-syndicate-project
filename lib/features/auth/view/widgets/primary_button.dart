import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
    final String text;
    final VoidCallback onPressed;
    final Color buttonColor;

    const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.buttonColor = const Color(0xFF0B3D2E),
    });

    @override
    Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: SizedBox(
        width: screenWidth * 0.55, 
        height: 50,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor,
            elevation: 6,
            shadowColor: Colors.black.withOpacity(0.2),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
            ),
            ),
            onPressed: onPressed,
            child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 28,
                color: Colors.white,
            ),
            ),
        ),
        ),
    );
    }
}