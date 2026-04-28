import 'package:flutter/material.dart';
import '../theme.dart';
import '../data.dart';
import '../widgets/section_header.dart';
import '../widgets/glass_card.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SectionHeader(title: "Technical Skills"),
        const SizedBox(height: 20),
        _buildCategoriesGrid(context),
      ],
    );
  }

  Widget _buildCategoriesGrid(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    // Calculate cross axis count based on screen width
    int crossAxisCount = 4;
    if (width < 600) {
      crossAxisCount = 1;
    } else if (width < 1000) {
      crossAxisCount = 2;
    }

    return Column(
      children: [
        // Responsive grid using Wrap or LayoutBuilder
        LayoutBuilder(
          builder: (context, constraints) {
            return Wrap(
              spacing: 20,
              runSpacing: 20,
              children: SkillsData.categories.map((cat) {
                double itemWidth = (constraints.maxWidth - (crossAxisCount - 1) * 20) / crossAxisCount;
                return _buildCategoryCard(cat, itemWidth, isDark);
              }).toList(),
            );
          },
        ),
      ],
    );
  }

  Widget _buildCategoryCard(SkillCategory cat, double width, bool isDark) {
    return GlassCard(
      width: width,
      padding: const EdgeInsets.all(24),
      borderColor: cat.color.withOpacity(0.3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: cat.color,
                  shape: BoxShape.circle,
                  boxShadow: [BoxShadow(color: cat.color.withOpacity(0.5), blurRadius: 8)],
                ),
              ),
              const SizedBox(width: 12),
              Text(
                cat.title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: cat.color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: cat.skills.map((skill) => _buildSkillPill(skill, cat.color, isDark)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillPill(String name, Color color, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        name,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: isDark ? Colors.white : AppColors.textLight,
        ),
      ),
    );
  }
}
