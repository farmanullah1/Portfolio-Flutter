import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme.dart';

class GlassCard extends StatefulWidget {
  final Widget child;
  final double? blur;
  final double opacity;
  final Color? color;
  final BorderRadius? borderRadius;
  final bool hasGlow;
  final Color? glowColor;
  final Border? border;

  const GlassCard({
    super.key,
    required this.child,
    this.blur,
    this.opacity = 0.04,
    this.color,
    this.borderRadius,
    this.hasGlow = false,
    this.glowColor,
    this.border,
  });

  @override
  State<GlassCard> createState() => _GlassCardState();
}

class _GlassCardState extends State<GlassCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isMobile = MediaQuery.of(context).size.width < 768;
    final effectiveBlur = widget.blur ?? (isMobile ? 8.0 : 16.0);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        decoration: BoxDecoration(
          borderRadius: widget.borderRadius ?? BorderRadius.circular(24),
          boxShadow: [
            if (_isHovered || widget.hasGlow)
              BoxShadow(
                color: (widget.glowColor ?? AppColors.c1).withValues(alpha: _isHovered ? 0.15 : 0.05),
                blurRadius: 30,
                spreadRadius: _isHovered ? 5 : 0,
              ),
          ],
        ),
        child: ClipRRect(
          borderRadius: widget.borderRadius ?? BorderRadius.circular(24),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: effectiveBlur, sigmaY: effectiveBlur),
            child: Container(
              decoration: BoxDecoration(
                color: widget.color ?? (isDark 
                    ? Colors.white.withValues(alpha: _isHovered ? widget.opacity * 2 : widget.opacity) 
                    : Colors.white.withValues(alpha: isMobile ? 0.8 : 0.6)),
                borderRadius: widget.borderRadius ?? BorderRadius.circular(24),
                border: widget.border ?? Border.all(
                  color: isDark 
                      ? (_isHovered 
                          ? (widget.glowColor ?? AppColors.c1).withValues(alpha: 0.3)
                          : Colors.white.withValues(alpha: 0.08))
                      : AppColors.borderLight.withValues(alpha: 0.5),
                  width: _isHovered ? 1.5 : 1.0,
                ),
              ),
              child: widget.child,
            ),
          ),
        ),
      ),
    );
  }
}
