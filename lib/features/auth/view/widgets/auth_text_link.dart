import 'package:engineers_syndicate_project/config/theme/color_theme.dart';
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
            color: textColor ?? ColorTheme.textSecondary,
            fontSize: fontSize ?? 14,
          ),
        ),
        const SizedBox(width: 5), 
        GestureDetector(
          onTap: onTap,
          child: Text(
            actionText,
            style: TextStyle(
              color: actionColor ?? ColorTheme.accent,
              fontWeight: FontWeight.bold, 
              fontSize: fontSize ?? 14,
            ),
          ),
        ),
      ],
    );
  }
}