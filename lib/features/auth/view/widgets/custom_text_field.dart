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
        height: 50,
        child: Container(
            decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
                BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 10,
                offset: const Offset(0, 4),
                ),
            ],
            border: Border.all(
                color: Colors.black.withOpacity(0.1),
            ),
            borderRadius: BorderRadius.circular(12),
            ),
            child: TextField(
            controller: widget.controller,
            obscureText: _obscureText,
            style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
                fontWeight: FontWeight.normal,
            ),
            decoration: InputDecoration(
                hintText: widget.hint,
                hintStyle: const TextStyle(
                color: Colors.black54,
                fontSize: 18,
                ),
                prefixIcon: Icon(
                widget.icon,
                color: Colors.black.withOpacity(0.6),
                ),
                suffixIcon: widget.isPassword
                    ? IconButton(
                        onPressed: _toggleVisibility,
                        icon: Icon(
                        _obscureText
                            ? Icons.visibility_off  
                            : Icons.visibility,      
                        color: Colors.black.withOpacity(0.6),
                        ),
                    )
                    : (widget.suffixIcon != null
                        ? Icon(
                            widget.suffixIcon,
                            color: Colors.black.withOpacity(0.6),
                        )
                        : null),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 12,
                ),
            ),
            ),
        ),
        ),
    );
    }
}