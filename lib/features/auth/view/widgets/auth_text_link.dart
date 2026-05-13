import 'package:flutter/material.dart';

class AuthTextLink extends StatelessWidget {
    final String text;
    final String actionText;
    final VoidCallback? onTap;
    final Color? textColor;
    final Color? actionColor;
    final double? fontSize;

    const AuthTextLink({
    super.key,
    required this.text,
    required this.actionText,
    this.onTap,
    this.textColor,
    this.actionColor,
    this.fontSize,
    });

    @override
    Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Text(
            text,
            style: TextStyle(
            color: textColor ?? Colors.black,
            fontSize: fontSize ?? 14, 
            ),
        ),
        GestureDetector(
            onTap: onTap,
            child: Text(
            actionText,
            style: TextStyle(
                color: actionColor ?? Colors.teal,
                fontWeight: FontWeight.normal,
                fontSize: fontSize ?? 14,
            ),
            ),
        ),
        ],
    );
    }
}