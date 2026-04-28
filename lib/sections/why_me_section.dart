import 'package:flutter/material.dart';
import '../theme.dart';
import '../data.dart';
import '../widgets/section_header.dart';
import '../widgets/glass_card.dart';

class WhyMeSection extends StatelessWidget {
  const WhyMeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SectionHeader(title: "Why Work With Me?"),
        Text(
          "I bring more than just code — I bring commitment, craftsmanship, and a genuine passion for building things that matter.",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: Theme.of(context).brightness == Brightness.dark ? AppColors.textMuted : AppColors.textMutedLight,
          ),
        ),
        const SizedBox(height: 50),
        _buildFeaturesGrid(context),
      ],
    );
  }

  Widget _buildFeaturesGrid(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    int crossAxisCount = 4;
    if (width < 600) {
      crossAxisCount = 1;
    } else if (width < 1000) {
      crossAxisCount = 2;
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        double itemWidth = (constraints.maxWidth - (crossAxisCount - 1) * 20) / crossAxisCount;
        return Wrap(
          spacing: 20,
          runSpacing: 20,
          children: WhyMeData.features.map((f) => _buildFeatureCard(f, itemWidth)).toList(),
        );
      },
    );
  }

  Widget _buildFeatureCard(Feature f, double width) {
    return GlassCard(
      width: width,
      padding: const EdgeInsets.all(32),
      borderColor: f.color.withOpacity(0.3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: f.color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: f.color.withOpacity(0.3)),
            ),
            child: Text(f.tag, style: TextStyle(color: f.color, fontSize: 10, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 20),
          Icon(f.icon, color: f.color, size: 32),
          const SizedBox(height: 20),
          Text(f.title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Text(
            f.desc,
            style: const TextStyle(color: AppColors.textDim, height: 1.6),
          ),
        ],
      ),
    );
  }
}
