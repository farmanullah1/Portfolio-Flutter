import 'package:flutter/material.dart';
import '../theme.dart';
import '../widgets/section_header.dart';
import '../widgets/glass_card.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 900;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        const SectionHeader(title: "About Me"),
        if (isMobile) 
          Column(
            children: [
              _buildTextContent(isDark),
              const SizedBox(height: 40),
              _buildHighlightsGrid(true),
            ],
          )
        else 
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 3, child: _buildTextContent(isDark)),
              const SizedBox(width: 60),
              Expanded(flex: 4, child: _buildHighlightsGrid(false)),
            ],
          ),
      ],
    );
  }

  Widget _buildTextContent(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "I'm a passionate Software Engineer based in Pakistan, dedicated to building high-performance applications that deliver exceptional user experiences.",
          style: TextStyle(
            fontSize: 18,
            height: 1.6,
            color: isDark ? AppColors.text : AppColors.textLight,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          "With expertise in the MERN stack and ASP.NET Core, I bridge the gap between complex backend architectures and intuitive frontend designs. My approach focuses on clean code, scalability, and modern design principles.",
          style: TextStyle(
            fontSize: 16,
            height: 1.8,
            color: isDark ? AppColors.textMuted : AppColors.textMutedLight,
          ),
        ),
      ],
    );
  }

  Widget _buildHighlightsGrid(bool isMobile) {
    final highlights = [
      {'title': 'Experience', 'desc': '3+ Years of development', 'icon': Icons.trending_up, 'color': AppColors.c1},
      {'title': 'Projects', 'desc': '10+ Successfully built', 'icon': Icons.code, 'color': AppColors.c3},
      {'title': 'Tech Stack', 'desc': 'Modern & Scalable', 'icon': Icons.layers, 'color': AppColors.c4},
      {'title': 'Availability', 'offset': 'Full-time / Freelance', 'icon': Icons.event_available, 'color': AppColors.c5},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        childAspectRatio: isMobile ? 1.4 : 1.6,
      ),
      itemCount: highlights.length,
      itemBuilder: (context, index) {
        final h = highlights[index];
        return GlassCard(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(h['icon'] as IconData, color: h['color'] as Color, size: 28),
              const SizedBox(height: 12),
              Text(h['title'] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 4),
              Text(
                (h['desc'] ?? h['offset']) as String, 
                style: const TextStyle(fontSize: 12, color: AppColors.textDim)
              ),
            ],
          ),
        );
      },
    );
  }
}
