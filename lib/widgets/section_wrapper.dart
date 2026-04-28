import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Padding(
      padding: EdgeInsets.only(
        top: isMobile ? 60 : widget.topPadding,
        bottom: isMobile ? 60 : widget.bottomPadding,
      ),
      child: widget.child,
    );
  }
}
