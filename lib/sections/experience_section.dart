import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../theme.dart';
import '../data.dart';
import '../models.dart';
import '../widgets/glass_card.dart';
import '../widgets/section_header.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 800;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 100),
      child: Column(
        children: [
          const SectionHeader(
            title: 'Experience & Education',
            index: '02',
          ),
          const SizedBox(height: 80),
          Stack(
            children: [
              Positioned(
                left: isMobile ? 16 : 32, 
                top: 0, bottom: 0, 
                child: Container(
                  width: 2, 
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter, 
                      end: Alignment.bottomCenter, 
                      colors: [
                        AppColors.c1, 
                        AppColors.c2, 
                        AppColors.c3.withValues(alpha: 0.1)
                      ]
                    ), 
                  ),
                ),
              ),
              Column(
                children: ContentData.experiences.asMap().entries.map((e) => _buildTimelineItem(context, e.value, e.key, isMobile)).toList()
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineItem(BuildContext context, Experience exp, int i, bool isMobile) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: EdgeInsets.only(bottom: 60, left: isMobile ? 32 : 64),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: isMobile ? -28 : -44,
            top: 0,
            child: Container(
              width: isMobile ? 24 : 32,
              height: isMobile ? 24 : 32,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.bg,
                border: Border.all(color: AppColors.c1, width: 2),
                boxShadow: [
                  BoxShadow(color: AppColors.c1.withValues(alpha: 0.5), blurRadius: 10)
                ],
              ),
              child: Center(
                child: Container(
                  width: 8, height: 8,
                  decoration: const BoxDecoration(color: AppColors.c1, shape: BoxShape.circle),
                ).animate(onPlay: (c) => c.repeat(reverse: true)).scale(begin: const Offset(1, 1), end: const Offset(1.5, 1.5), duration: 1.seconds),
              ),
            ),
          ),
          GlassCard(
            opacity: 0.05,
            child: Padding(
              padding: EdgeInsets.all(isMobile ? 24 : 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColors.c1.withValues(alpha: 0.1), 
                          borderRadius: BorderRadius.circular(30), 
                        ),
                        child: Text(
                          exp.date, 
                          style: const TextStyle(color: AppColors.c1, fontSize: 10, fontWeight: FontWeight.w900, fontFamily: 'Fira Code')
                        ),
                      ),
                      Icon(
                        exp.type == 'work' ? FontAwesomeIcons.briefcase : FontAwesomeIcons.graduationCap,
                        size: 16,
                        color: AppColors.c1.withValues(alpha: 0.5),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text(
                    exp.title, 
                    style: TextStyle(fontSize: isMobile ? 20 : 26, fontWeight: FontWeight.w900, height: 1.1, color: isDark ? Colors.white : AppColors.textLight)
                  ),
                  const SizedBox(height: 8),
                  Text(
                    exp.company, 
                    style: TextStyle(fontSize: isMobile ? 15 : 18, color: AppColors.c3, fontWeight: FontWeight.w800, letterSpacing: 0.2)
                  ),
                  const SizedBox(height: 24),
                  const Divider(color: AppColors.border, thickness: 1),
                  const SizedBox(height: 20),
                  ...exp.bullets.map((b) => Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 4),
                          child: Icon(FontAwesomeIcons.circleDot, size: 8, color: AppColors.c2),
                        ),
                        const SizedBox(width: 16),
                        Expanded(child: Text(b, style: TextStyle(color: isDark ? AppColors.textMuted : AppColors.textMutedLight, height: 1.6, fontSize: isMobile ? 14 : 16))),
                      ],
                    ),
                  )),
                ],
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: (i * 200).ms, duration: 800.ms).slideY(begin: 0.1, end: 0);
  }
}
