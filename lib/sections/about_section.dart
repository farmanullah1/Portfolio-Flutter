import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme.dart';
import '../data.dart';
import '../widgets/glass_card.dart';
import '../widgets/section_header.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 1000;

    return Column(
      children: [
        const SectionHeader(
          title: 'The Architect',
          index: '00',
          subtitle: 'Bridging the gap between ambitious ideas and high-performance digital reality.',
        ),
        const SizedBox(height: 80),
        isMobile ? _buildMobile(context) : _buildDesktop(context),
      ],
    );
  }

  Widget _buildDesktop(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 5, child: _buildImage(context, false)),
        const SizedBox(width: 80),
        Expanded(flex: 6, child: _buildContent(context, false)),
      ],
    );
  }

  Widget _buildMobile(BuildContext context) {
    return Column(
      children: [
        _buildImage(context, true),
        const SizedBox(height: 60),
        _buildContent(context, true),
      ],
    );
  }

  Widget _buildImage(BuildContext context, bool isMobile) {
    final size = isMobile ? 320.0 : 450.0;
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background Decorative Gradients
          Positioned(
            top: 20, right: 20,
            child: Container(
              width: size * 0.9, height: size * 0.9,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: const LinearGradient(colors: [AppColors.c1, AppColors.c2]),
              ),
            ),
          ).animate(onPlay: (c) => c.repeat(reverse: true)).rotate(begin: 0, end: 0.02, duration: 4.seconds),
          
          GlassCard(
            borderRadius: BorderRadius.circular(30),
            opacity: 0.1,
            child: Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.white.withValues(alpha: 0.1), width: 1.5),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.asset(
                  'assets/profile2.webp',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => const Icon(Icons.person, size: 100, color: AppColors.c1),
                ),
              ),
            ),
          ).animate().fadeIn(duration: 1.seconds).scale(begin: const Offset(0.95, 0.95), end: const Offset(1, 1)),
          
          // Floating Badge
          _buildFloatingBadge(isMobile),
        ],
      ),
    );
  }

  Widget _buildFloatingBadge(bool isMobile) {
    return Positioned(
      bottom: isMobile ? 20 : 40,
      right: isMobile ? -10 : -30,
      child: GlassCard(
        opacity: 0.2,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            children: [
              const Text("4+", style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: Colors.white)),
              Text("YEARS OF CODE", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.c1.withValues(alpha: 0.8), letterSpacing: 1.5)),
            ],
          ),
        ),
      ),
    ).animate().slideX(begin: 0.1, end: 0).fadeIn();
  }

  Widget _buildContent(BuildContext context, bool isMobile) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        _buildBadge("Who am I?"),
        const SizedBox(height: 32),
        Text(
          "I build pixel-perfect digital experiences that scale.",
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
          style: TextStyle(
            fontSize: isMobile ? 28 : 48,
            fontWeight: FontWeight.w900,
            height: 1.1,
            letterSpacing: -1.5,
            color: isDark ? Colors.white : AppColors.textLight,
          ),
        ),
        const SizedBox(height: 32),
        Text(
          "My journey as a software engineer is fueled by a relentless drive to solve complex problems through clean, elegant code. Specializing in the MERN stack and ASP.NET Core, I architect solutions that aren't just functional, but future-proof.",
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
          style: TextStyle(
            fontSize: 16,
            color: isDark ? AppColors.textMuted : AppColors.textMutedLight,
            height: 1.8,
          ),
        ),
        const SizedBox(height: 48),
        _buildStats(context, isMobile),
      ],
    );
  }

  Widget _buildBadge(String t) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.c1.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        t.toUpperCase(),
        style: const TextStyle(color: AppColors.c1, fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 2),
      ),
    );
  }

  Widget _buildStats(BuildContext context, bool isMobile) {
    return Wrap(
      spacing: 40,
      runSpacing: 32,
      alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
      children: ContentData.stats.map((s) => Column(
        crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          Text(
            s.num, 
            style: const TextStyle(
              fontSize: 42, 
              fontWeight: FontWeight.w900, 
              color: Colors.white,
              letterSpacing: -1,
            )
          ),
          const SizedBox(height: 4),
          Text(
            s.label.toUpperCase(), 
            style: const TextStyle(
              fontSize: 11, 
              fontWeight: FontWeight.w900, 
              color: AppColors.c1, 
              letterSpacing: 2.0,
              fontFamily: 'Fira Code',
            )
          ),
        ],
      )).toList(),
    );
  }
}
