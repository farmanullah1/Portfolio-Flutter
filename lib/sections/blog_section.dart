import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme.dart';
import '../data.dart';
import '../models.dart';
import '../widgets/glass_card.dart';
import '../widgets/section_header.dart';

class BlogSection extends StatelessWidget {
  const BlogSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isMobile = MediaQuery.of(context).size.width < 800;

    return Column(
      children: [
        const SectionHeader(title: 'Insights & Articles', index: '06'),
        const SizedBox(height: 64),
        isMobile ? Column(
          children: ContentData.articles.map((a) => Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: SizedBox(
              height: 320,
              child: _buildBlogCard(context, isDark, a, isMobile),
            ),
          )).toList(),
        ) : GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: ContentData.articles.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 24,
            mainAxisSpacing: 24,
            childAspectRatio: 1.6,
          ),
          itemBuilder: (context, i) => _buildBlogCard(context, isDark, ContentData.articles[i], isMobile),
        ),
      ],
    );
  }

  Widget _buildBlogCard(BuildContext context, bool isDark, BlogArticle a, bool isMobile) {
    return GlassCard(
      opacity: 0.08,
      child: Stack(
        children: [
          Positioned(top: 0, left: 0, right: 0, child: Container(height: 4, color: a.color)),
          Padding(
            padding: EdgeInsets.all(isMobile ? 20 : 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), 
                  decoration: BoxDecoration(color: a.color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)), 
                  child: Text(a.tag, style: TextStyle(color: a.color, fontSize: 10, fontWeight: FontWeight.bold))
                ),
                const SizedBox(height: 20),
                Text(a.title, style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: isDark ? Colors.white : AppColors.textLight)),
                const SizedBox(height: 12),
                Text(a.desc, style: TextStyle(color: isDark ? AppColors.textMuted : AppColors.textMutedLight, fontSize: 14, height: 1.5), maxLines: 3, overflow: TextOverflow.ellipsis),
                const Spacer(),
                Row(
                  children: [
                    const Icon(Icons.access_time, size: 14, color: AppColors.textDim),
                    const SizedBox(width: 6),
                    Text(a.readTime, style: const TextStyle(color: AppColors.textDim, fontSize: 12, fontWeight: FontWeight.bold)),
                    const Spacer(),
                    TextButton.icon(
                      onPressed: () {
                        HapticFeedback.lightImpact();
                        launchUrl(Uri.parse(a.link));
                      },
                      icon: Text("Read More", style: TextStyle(fontWeight: FontWeight.w900, color: a.color)),
                      label: Icon(FontAwesomeIcons.arrowRight, size: 14, color: a.color),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
