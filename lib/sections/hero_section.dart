import 'dart:async';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../theme.dart';
import '../data.dart';
import '../widgets/premium_button.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({super.key});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> with SingleTickerProviderStateMixin {
  int _roleIndex = 0;
  String _displayedRole = "";
  bool _isTyping = true;
  Timer? _typingTimer;
  late AnimationController _gridController;

  @override
  void initState() {
    super.initState();
    _startTyping();
    _gridController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 24),
    )..repeat();
  }

  void _startTyping() {
    if (!mounted) return;
    String target = HeroData.roles[_roleIndex];
    if (_isTyping) {
      if (_displayedRole.length < target.length) {
        _typingTimer = Timer(const Duration(milliseconds: 58), () {
          if (mounted) {
            setState(() => _displayedRole = target.substring(0, _displayedRole.length + 1));
          }
          _startTyping();
        });
      } else {
        _typingTimer = Timer(const Duration(milliseconds: 1900), () {
          if (mounted) setState(() => _isTyping = false);
          _startTyping();
        });
      }
    } else {
      if (_displayedRole.isNotEmpty) {
        _typingTimer = Timer(const Duration(milliseconds: 32), () {
          if (mounted) {
            setState(() => _displayedRole = _displayedRole.substring(0, _displayedRole.length - 1));
          }
          _startTyping();
        });
      } else {
        if (mounted) {
          setState(() {
            _roleIndex = (_roleIndex + 1) % HeroData.roles.length;
            _isTyping = true;
          });
          _startTyping();
        }
      }
    }
  }

  @override
  void dispose() {
    _typingTimer?.cancel();
    _gridController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 1024;

    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 800),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background components
          Positioned.fill(child: _buildBackgroundOrbs(width)),
          
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 24 : 100,
              vertical: isMobile ? 100 : 160,
            ),
            child: isMobile 
              ? _buildMobileLayout(width)
              : _buildDesktopLayout(width),
          ),
        ],
      ),
    );
  }

  Widget _buildBackgroundOrbs(double width) {
    return Stack(
      children: [
        _buildOrb(
          top: -100, 
          right: -100, 
          size: width > 768 ? 700 : 400, 
          color: AppColors.c2.withValues(alpha: 0.15),
        ),
        _buildOrb(
          bottom: -50, 
          left: -50, 
          size: width > 768 ? 600 : 300, 
          color: AppColors.c1.withValues(alpha: 0.12),
        ),
      ],
    );
  }

  Widget _buildOrb({double? top, double? bottom, double? left, double? right, required double size, required Color color}) {
    return Positioned(
      top: top, bottom: bottom, left: left, right: right,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [color, Colors.transparent],
            stops: const [0.0, 0.7],
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(double width) {
    return Row(
      children: [
        Expanded(child: _buildTextContent(false)),
        const SizedBox(width: 40),
        _buildHeroImage(460),
      ],
    );
  }

  Widget _buildMobileLayout(double width) {
    return Column(
      children: [
        _buildHeroImage(width * 0.7),
        const SizedBox(height: 60),
        _buildTextContent(true),
      ],
    );
  }

  Widget _buildTextContent(bool isMobile) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final alignment = isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start;
    final textAlign = isMobile ? TextAlign.center : TextAlign.left;

    return Column(
      crossAxisAlignment: alignment,
      children: [
        // Available badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.c1.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: AppColors.c1.withValues(alpha: 0.3)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.circle, size: 8, color: AppColors.c3),
              const SizedBox(width: 10),
              const Text(
                "Available for new opportunities",
                style: TextStyle(color: AppColors.c1, fontWeight: FontWeight.bold, fontSize: 13),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Text(
          "Hi, I'm",
          style: TextStyle(
            fontSize: isMobile ? 20 : 28,
            color: isDark ? AppColors.textMuted : AppColors.textMutedLight,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          "Farmanullah Ansari",
          textAlign: textAlign,
          style: TextStyle(
            fontSize: isMobile ? 48 : 80,
            fontWeight: FontWeight.w900,
            height: 1.1,
            color: isDark ? Colors.white : AppColors.textLight,
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: isMobile ? MainAxisAlignment.center : MainAxisAlignment.start,
          children: [
            const Text("I'm a ", style: TextStyle(fontSize: 20)),
            Text(
              _displayedRole,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: AppColors.c3),
            ),
            const Text("|", style: TextStyle(fontSize: 20, color: AppColors.c3)),
          ],
        ),
        const SizedBox(height: 24),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Text(
            "I engineer dynamic, user-friendly, and scalable web applications. Passionate about the MERN stack, ASP.NET Core, cloud computing, and building seamless digital experiences.",
            textAlign: textAlign,
            style: TextStyle(
              fontSize: 16,
              height: 1.8,
              color: isDark ? AppColors.textMuted : AppColors.textMutedLight,
            ),
          ),
        ),
        const SizedBox(height: 40),
        // Stats
        Wrap(
          spacing: 32,
          runSpacing: 20,
          alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
          children: HeroData.stats.map((s) => Column(
            crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
            children: [
              Text(s['num']!, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: AppColors.c1)),
              Text(s['label']!.toUpperCase(), style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1, color: AppColors.textDim)),
            ],
          )).toList(),
        ),
        const SizedBox(height: 40),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
          children: const [
            PremiumButton(label: "Hire Me", icon: FontAwesomeIcons.envelope),
            PremiumButton(label: "Download CV", icon: FontAwesomeIcons.download, isPrimary: false),
          ],
        ),
      ],
    );
  }

  Widget _buildHeroImage(double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.c2.withValues(alpha: 0.5), width: 2),
        boxShadow: [
          BoxShadow(color: AppColors.c2.withValues(alpha: 0.2), blurRadius: 40),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(size / 2),
        child: Image.asset('assets/profile2.webp', fit: BoxFit.cover),
      ),
    );
  }
}
