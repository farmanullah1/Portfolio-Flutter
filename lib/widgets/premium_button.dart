import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme.dart';

class PremiumButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final bool isPrimary;
  final VoidCallback? onPressed;

  const PremiumButton({
    super.key,
    required this.label,
    required this.icon,
    this.isPrimary = true,
    this.onPressed,
  });

  @override
  State<PremiumButton> createState() => _PremiumButtonState();
}

class _PremiumButtonState extends State<PremiumButton> {
  bool _isPressed = false;
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) => setState(() => _isPressed = false),
        onTapCancel: () => setState(() => _isPressed = false),
        onTap: () {
          HapticFeedback.mediumImpact();
          if (widget.onPressed != null) widget.onPressed!();
        },
        child: AnimatedScale(
          scale: _isPressed ? 0.96 : (_isHovered ? 1.02 : 1.0),
          duration: 150.ms,
          curve: Curves.easeOutBack,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
            decoration: widget.isPrimary ? BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: const LinearGradient(
                colors: AppColors.primaryGradient,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.c1.withValues(alpha: 0.3), 
                  blurRadius: _isPressed ? 8 : 20, 
                  spreadRadius: _isHovered ? 2 : 0,
                  offset: Offset(0, _isPressed ? 2 : 8)
                )
              ],
            ) : BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: _isHovered ? AppColors.c1 : AppColors.c1.withValues(alpha: 0.5), 
                width: 1.5
              ),
              color: _isHovered ? AppColors.c1.withValues(alpha: 0.05) : Colors.transparent,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  widget.icon, 
                  size: 18, 
                  color: widget.isPrimary ? Colors.white : AppColors.c1
                ).animate(target: _isHovered ? 1 : 0).shake(hz: 4, curve: Curves.easeInOut),
                const SizedBox(width: 12),
                Text(
                  widget.label, 
                  style: TextStyle(
                    color: widget.isPrimary ? Colors.white : AppColors.c1, 
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.8,
                    fontSize: 15,
                  )
                ),
              ],
            ),
          ).animate(onPlay: (c) => c.repeat(reverse: true))
           .shimmer(
             duration: 3.seconds, 
             color: Colors.white.withValues(alpha: widget.isPrimary ? 0.2 : 0),
             blendMode: BlendMode.srcOver,
           ),
        ),
      ),
    );
  }
}
