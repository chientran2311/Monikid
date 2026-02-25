import 'package:flutter/material.dart';

class SocialButton extends StatelessWidget {
  final String text;
  final Widget icon;
  final VoidCallback onPressed;

  const SocialButton({
    Key? key,
    required this.text,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(12), // rounded-xl
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 10,
        ), // px-4 py-2.5
        decoration: BoxDecoration(
          color: isDark
              ? const Color(0xFF1E293B)
              : Colors.white, // bg-slate-800 : bg-white
          border: Border.all(
            color: isDark
                ? const Color(0xFF334155)
                : const Color(
                    0xFFE2E8F0,
                  ), // border-slate-700 : border-slate-200
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            const SizedBox(width: 8), // mr-2 equivalent
            Text(
              text,
              style: TextStyle(
                fontSize: 14, // text-sm
                fontWeight: FontWeight.w500, // font-medium
                color: isDark
                    ? const Color(0xFFCBD5E1)
                    : const Color(
                        0xFF334155,
                      ), // text-slate-300 : text-slate-700
              ),
            ),
          ],
        ),
      ),
    );
  }
}
