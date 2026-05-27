import 'package:engineers_syndicate_project/config/theme/color_theme.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String hint;
  final IconData icon;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixTap;
  final bool isPassword;
  final TextEditingController? controller;
  final double? width;
  final double? height;
  final TextInputType keyboardType;

  const CustomTextField({
    super.key,
    required this.hint,
    required this.icon,
    this.suffixIcon,
    this.onSuffixTap,
    this.isPassword = false,
    this.controller,
    this.width,
    this.height,
    this.keyboardType = TextInputType.text,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: SizedBox(
        width: widget.width ?? double.infinity,
        height: widget.height ?? 50,
        child: Container(
          decoration: BoxDecoration(
            color: ColorTheme.surface,
            boxShadow: [
              BoxShadow(
                color: ColorTheme.textPrimary,
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
            border: Border.all(),
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextField(
            controller: widget.controller,
            obscureText: _obscureText,
            keyboardType: widget.keyboardType,
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.right,
            style: const TextStyle(fontSize: 16, color: ColorTheme.textPrimary),
            decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle: const TextStyle(color: ColorTheme.textSecondary, fontSize: 18),
              prefixIcon: Icon(widget.icon, color: ColorTheme.primary),
              suffixIcon: widget.isPassword
                  ? IconButton(
                      onPressed: _toggleVisibility,
                      icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                        color: ColorTheme.primary,
                      ),
                    )
                  : (widget.suffixIcon != null
                      ? GestureDetector(
                          onTap: widget.onSuffixTap,
                          child: Icon(widget.suffixIcon, color: ColorTheme.primary),
                        )
                      : null),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
            ),
          ),
        ),
      ),
    );
  }
}