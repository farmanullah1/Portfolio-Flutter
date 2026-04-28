import 'package:flutter/material.dart';
import '../theme.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  
  const SectionHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    
    return Column(
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: isMobile ? 32 : 48,
            fontWeight: FontWeight.w900,
            letterSpacing: -1,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          width: 56,
          height: 4,
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [AppColors.c1, AppColors.c2]),
            borderRadius: BorderRadius.circular(4),
            boxShadow: const [
              BoxShadow(color: AppColors.glow1, blurRadius: 14),
            ],
          ),
        ),
        const SizedBox(height: 48),
      ],
    );
  }
}
