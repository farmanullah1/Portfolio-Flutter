import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme.dart';

class PremiumButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback? onPressed;
  final bool isPrimary;

  const PremiumButton({
    super.key,
    required this.label,
    required this.icon,
    this.onPressed,
    this.isPrimary = true,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        HapticFeedback.lightImpact();
        onPressed?.call();
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: isPrimary 
            ? const LinearGradient(colors: [AppColors.c1, AppColors.c2])
            : null,
          color: isPrimary ? null : AppColors.c1.withValues(alpha: 0.08),
          border: isPrimary ? null : Border.all(color: AppColors.c1.withValues(alpha: 0.45), width: 1.5),
          boxShadow: isPrimary ? [
            BoxShadow(
              color: AppColors.c1.withValues(alpha: 0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
            )
          ] : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon, 
              size: 18, 
              color: isPrimary ? Colors.white : AppColors.c1,
            ),
            const SizedBox(width: 10),
            Text(
              label,
              style: TextStyle(
                color: isPrimary ? Colors.white : AppColors.c1,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
