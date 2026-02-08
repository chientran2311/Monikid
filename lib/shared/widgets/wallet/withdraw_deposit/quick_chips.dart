import 'package:flutter/material.dart';
import 'package:monikid/core/theme/theme.dart';

class QuickChips extends StatelessWidget {
  const QuickChips({super.key});

  @override
  Widget build(BuildContext context) {
    final amounts = [10, 20, 50, 100, 200];
    
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: amounts.map((amount) {
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: GestureDetector(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration: BoxDecoration(
                  color: AppTheme.surface,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white10),
                ),
                child: const Text(
                  "",
                  style: TextStyle(
                    
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  
  }
}