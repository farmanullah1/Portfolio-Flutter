import 'package:flutter/material.dart';
import '../theme.dart';
import '../data.dart';
import '../widgets/section_header.dart';
import '../widgets/glass_card.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SectionHeader(title: "Experience & Education"),
        const SizedBox(height: 20),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: Column(
            children: ExperienceData.items.map((exp) => _buildTimelineItem(context, exp)).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildTimelineItem(BuildContext context, Experience exp) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isWork = exp.type == 'work';

    return Padding(
      padding: const EdgeInsets.only(bottom: 32),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: isWork ? AppColors.c2 : AppColors.c1,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: (isWork ? AppColors.c2 : AppColors.c1).withOpacity(0.3),
                        blurRadius: 12,
                      )
                    ],
                  ),
                  child: Icon(
                    isWork ? Icons.work_outline : Icons.school_outlined,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                Expanded(
                  child: Container(
                    width: 2,
                    color: AppColors.border,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 24),
            Expanded(
              child: GlassCard(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      exp.date,
                      style: const TextStyle(color: AppColors.c1, fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      exp.title,
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      exp.company,
                      style: const TextStyle(fontSize: 16, color: AppColors.c3, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 16),
                    Column(
                      children: exp.bullets.map((b) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 8),
                              child: Icon(Icons.circle, size: 6, color: AppColors.textDim),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                b,
                                style: TextStyle(
                                  color: isDark ? AppColors.textMuted : AppColors.textMutedLight,
                                  height: 1.6,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )).toList(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
