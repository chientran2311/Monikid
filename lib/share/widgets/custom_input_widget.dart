import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';

class CustomLabelInput extends StatefulWidget {
  final String label;
  final String hintText;
  final bool isPassword;
  final IconData? icon;

  const CustomLabelInput({
    super.key,
    required this.label,
    required this.hintText,
    this.isPassword = false,
    this.icon,
  });
  @override
  _CustomLabelInputState createState() => _CustomLabelInputState();
}

class _CustomLabelInputState extends State<CustomLabelInput> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(
            color: AppColors.textWhite,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: AppColors.inputFill,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white10),
          ),
          child: TextField(
            obscureText: widget.isPassword ? _obscureText : false,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: const TextStyle(color: Colors.white30),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              suffixIcon: widget.isPassword
                  ? IconButton(
                      icon: Icon(
                        _obscureText
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: AppColors.textGrey,
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
        ),
      ],
    );
  }
}
