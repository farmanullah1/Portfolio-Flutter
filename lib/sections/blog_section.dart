import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme.dart';
import '../data.dart';
import '../widgets/section_header.dart';
import '../widgets/glass_card.dart';

class BlogSection extends StatelessWidget {
  const BlogSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SectionHeader(title: "Insights & Articles"),
        const SizedBox(height: 20),
        _buildBlogGrid(context),
      ],
    );
  }

  Widget _buildBlogGrid(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    int crossAxisCount = 2;
    if (width < 800) {
      crossAxisCount = 1;
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        double itemWidth = (constraints.maxWidth - (crossAxisCount - 1) * 20) / crossAxisCount;
        return Wrap(
          spacing: 20,
          runSpacing: 20,
          children: BlogData.articles.map((a) => _buildBlogCard(a, itemWidth)).toList(),
        );
      },
    );
  }

  Widget _buildBlogCard(Article a, double width) {
    return GlassCard(
      width: width,
      padding: const EdgeInsets.all(28),
      borderColor: a.color.withOpacity(0.3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: a.color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(a.tag, style: TextStyle(color: a.color, fontSize: 10, fontWeight: FontWeight.w900)),
          ),
          const SizedBox(height: 20),
          Text(a.title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, height: 1.3)),
          const SizedBox(height: 12),
          Text(a.desc, style: const TextStyle(color: AppColors.textDim, height: 1.6)),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(FontAwesomeIcons.clock, size: 12, color: AppColors.textDim),
                  const SizedBox(width: 8),
                  Text(a.readTime, style: const TextStyle(fontSize: 12, color: AppColors.textDim)),
                ],
              ),
              InkWell(
                onTap: () => launchUrl(Uri.parse(a.link)),
                child: Row(
                  children: [
                    Text("Read More", style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: a.color)),
                    const SizedBox(width: 8),
                    Icon(FontAwesomeIcons.arrowRight, size: 12, color: a.color),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
