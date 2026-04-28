import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../theme.dart';

class SectionWrapper extends StatefulWidget {
  final Widget child;
  final List<Color> glowColors;
  final double topPadding;
  final double bottomPadding;
  final bool hasBorder;

  const SectionWrapper({
    super.key,
    required this.child,
    required this.glowColors,
    this.topPadding = 100,
    this.bottomPadding = 100,
    this.hasBorder = true,
  });

  @override
  State<SectionWrapper> createState() => _SectionWrapperState();
}

class _SectionWrapperState extends State<SectionWrapper> with SingleTickerProviderStateMixin {
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isMobile = MediaQuery.of(context).size.width < 768;

    return VisibilityDetector(
      key: widget.key != null 
          ? ValueKey('section_${widget.key.toString()}') 
          : UniqueKey(),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.1 && !_isVisible) {
          if (mounted) {
            setState(() => _isVisible = true);
          }
        }
      },
      child: Container(
        width: double.infinity,
        decoration: widget.hasBorder ? const BoxDecoration(
          border: Border(bottom: BorderSide(color: AppColors.border, width: 1)),
        ) : null,
        child: Stack(
          children: [
            // Background Glows
            Positioned(
              top: -200,
              left: -100,
              child: Container(
                width: 400,
                height: 400,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      widget.glowColors[0].withValues(alpha: isDark ? 0.08 : 0.05), 
                      widget.glowColors[0].withValues(alpha: 0)
                    ]
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: -200,
              right: -100,
              child: Container(
                width: 400,
                height: 400,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      widget.glowColors[1].withValues(alpha: isDark ? 0.08 : 0.05), 
                      widget.glowColors[1].withValues(alpha: 0)
                    ]
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: isMobile ? 60 : widget.topPadding,
                bottom: isMobile ? 60 : widget.bottomPadding,
              ),
              child: widget.child.animate(
                target: _isVisible ? 1 : 0,
              ).fadeIn(
                duration: 800.ms,
                curve: Curves.easeOutCubic,
              ).scale(
                begin: const Offset(0.95, 0.95),
                end: const Offset(1, 1),
                duration: 800.ms,
                curve: Curves.easeOutCubic,
              ).moveY(
                begin: 40,
                end: 0,
                duration: 800.ms,
                curve: Curves.easeOutCubic,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
