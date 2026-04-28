import 'package:flutter/material.dart';
import '../theme.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? index;

  const SectionHeader({
    super.key, 
    required this.title, 
    this.subtitle,
    this.index,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (index != null) ...[
              Text(
                index!,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  color: AppColors.c1.withValues(alpha: 0.5),
                  fontFamily: 'Fira Code',
                ),
              ),
              const SizedBox(width: 12),
              Container(width: 1, height: 20, color: AppColors.border),
              const SizedBox(width: 12),
            ],
            ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [AppColors.c1, AppColors.c2],
              ).createShader(bounds),
              child: Text(
                title.toUpperCase(),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 6,
                  color: Colors.white,
                  fontFamily: 'Fira Code',
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          width: 80,
          height: 3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: const LinearGradient(
              colors: [AppColors.c1, AppColors.c2, AppColors.c3],
            ),
          ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 24),
          SizedBox(
            width: 700,
            child: Text(
              subtitle!,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 17,
                color: isDark ? AppColors.textMuted : AppColors.textMutedLight,
                height: 1.7,
                letterSpacing: 0.2,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
