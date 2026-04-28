import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../theme.dart';
import '../data.dart';
import '../models.dart';
import '../widgets/glass_card.dart';
import '../widgets/section_header.dart';

class WhyMeSection extends StatelessWidget {
  const WhyMeSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    final isTablet = screenWidth < 1200;

    return Column(
      children: [
        const SectionHeader(
          title: 'Strategic Value',
          index: '01',
          subtitle: 'Why collaborate with me? I bring a unique blend of architectural precision, business logic expertise, and a commitment to delivery.',
        ),
        const SizedBox(height: 80),
        isMobile ? Column(
          children: ContentData.whyMeFeatures.asMap().entries.map((e) => Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: _buildFeatureCard(context, isDark, e.value, e.key),
          )).toList(),
        ) : GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: ContentData.whyMeFeatures.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: isTablet ? 2 : 3,
            mainAxisSpacing: 32,
            crossAxisSpacing: 32,
            childAspectRatio: isTablet ? 1.4 : 1.15,
          ),
          itemBuilder: (context, index) => _buildFeatureCard(context, isDark, ContentData.whyMeFeatures[index], index),
        ),
      ],
    );
  }

  Widget _buildFeatureCard(BuildContext context, bool isDark, WhyMeFeature f, int index) {
    return GlassCard(
      hasGlow: true,
      glowColor: f.color,
      child: Stack(
        children: [
          Positioned(
            top: -40,
            right: -40,
            child: Icon(f.icon, size: 160, color: f.color.withValues(alpha: 0.03)),
          ),
          Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: f.color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: f.color.withValues(alpha: 0.2)),
                  ),
                  child: Icon(f.icon, color: f.color, size: 28),
                ),
                const SizedBox(height: 32),
                Text(
                  f.title, 
                  style: TextStyle(
                    fontSize: 22, 
                    fontWeight: FontWeight.w900, 
                    color: isDark ? Colors.white : AppColors.textLight,
                    letterSpacing: -0.5,
                  )
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: Text(
                    f.desc, 
                    style: TextStyle(
                      color: isDark ? AppColors.textMuted : AppColors.textMutedLight, 
                      height: 1.7, 
                      fontSize: 15,
                      letterSpacing: 0.1,
                    ),
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: f.color.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        f.tag.toUpperCase(),
                        style: TextStyle(color: f.color, fontSize: 9, fontWeight: FontWeight.w900, letterSpacing: 1),
                      ),
                    ),
                    const Spacer(),
                    Icon(FontAwesomeIcons.circleArrowRight, color: f.color.withValues(alpha: 0.3), size: 20),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: (index * 150).ms, duration: 800.ms).slideY(begin: 0.1, end: 0);
  }
}
