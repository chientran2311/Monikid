import 'package:flutter/material.dart';

class CustomInputWidget extends StatefulWidget {
  final String label;
  final String placeholder;
  final IconData prefixIcon;
  final bool isPassword;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;

  const CustomInputWidget({
    Key? key,
    required this.label,
    required this.placeholder,
    required this.prefixIcon,
    this.isPassword = false,
    this.controller,
    this.validator,
    this.keyboardType = TextInputType.text,
  }) : super(key: key);

  @override
  State<CustomInputWidget> createState() => _CustomInputWidgetState();
}

class _CustomInputWidgetState extends State<CustomInputWidget> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        Text(
          widget.label,
          style: TextStyle(
            color: isDark
                ? const Color(0xFFCBD5E1)
                : const Color(0xFF334155), // slate-300 : slate-700
            fontWeight: FontWeight.w500, // font-medium
            fontSize: 14, // text-sm
          ),
        ),
        const SizedBox(height: 6), // space-y-1.5
        // Input Field
        TextFormField(
          controller: widget.controller,
          obscureText: widget.isPassword ? _obscureText : false,
          keyboardType: widget.keyboardType,
          style: TextStyle(
            color: isDark
                ? Colors.white
                : const Color(0xFF0F172A), // white : slate-900
            fontSize: 14,
          ),
          validator: widget.validator,
          decoration: InputDecoration(
            hintText: widget.placeholder,
            hintStyle: const TextStyle(
              color: Color(0xFF94A3B8), // slate-400
              fontSize: 14,
            ),
            prefixIcon: Icon(
              widget.prefixIcon,
              color: const Color(0xFF94A3B8), // slate-400
              size: 20,
            ),
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                      color: const Color(0xFF94A3B8), // slate-400
                      size: 20,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
