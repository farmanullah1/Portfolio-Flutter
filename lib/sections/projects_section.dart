import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme.dart';
import '../data.dart';
import '../models.dart';
import '../widgets/glass_card.dart';
import '../widgets/section_header.dart';
import '../widgets/premium_button.dart';

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  String _filter = 'All';
  int _visibleCount = 8;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    
    final filtered = ContentData.projects.where((p) {
      if (_filter == 'All') return true;
      if (_filter == 'Featured') return p.featured;
      return p.tech.any((t) => t.contains(_filter));
    }).toList();
    final displayed = filtered.take(_visibleCount).toList();

    return Column(
      children: [
        const SectionHeader(
          title: 'Featured Projects',
          index: '03',
          subtitle: 'A selection of my most impactful work across MERN, ASP.NET Core, and mobile development.',
        ),
        const SizedBox(height: 64),
        _buildFilters(isDark),
        const SizedBox(height: 56),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 40),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: displayed.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: screenWidth < 768 ? 1 : (screenWidth < 1200 ? 2 : 3),
              crossAxisSpacing: isMobile ? 24 : 32,
              mainAxisSpacing: isMobile ? 24 : 32,
              childAspectRatio: isMobile ? 0.85 : 0.9,
            ),
            itemBuilder: (context, i) => _buildProjectCard(isDark, displayed[i], i, isMobile),
          ),
        ),
        if (_visibleCount < filtered.length) ...[
          const SizedBox(height: 80),
          PremiumButton(
            label: "Load More Projects", 
            icon: FontAwesomeIcons.plus, 
            isPrimary: false,
            onPressed: () {
              HapticFeedback.mediumImpact();
              setState(() => _visibleCount += 8);
            },
          ),
        ],
      ],
    );
  }

  Widget _buildFilters(bool isDark) {
    final filters = ['All', 'Featured', 'MERN', 'React', '.NET', 'TypeScript'];
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      alignment: WrapAlignment.center,
      children: filters.map((f) => _buildFilterChip(f, isDark)).toList(),
    );
  }

  Widget _buildFilterChip(String f, bool isDark) {
    final isSelected = _filter == f;
    return GestureDetector(
      onTap: () {
        HapticFeedback.selectionClick();
        setState(() {
          _filter = f;
          _visibleCount = 8;
        });
      },
      child: AnimatedContainer(
        duration: 300.ms,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.c1 : (isDark ? AppColors.bgCard : Colors.white),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: isSelected ? AppColors.c1 : (isDark ? AppColors.border : AppColors.borderLight),
            width: 1.5
          ),
          boxShadow: isSelected ? [BoxShadow(color: AppColors.c1.withValues(alpha: 0.3), blurRadius: 15, offset: const Offset(0, 4))] : [],
        ),
        child: Text(
          f, 
          style: TextStyle(
            color: isSelected ? Colors.white : (isDark ? AppColors.textMuted : AppColors.textLight), 
            fontWeight: FontWeight.w900,
            fontSize: 13,
            letterSpacing: 0.5
          )
        ),
      ),
    );
  }

  Widget _buildProjectCard(bool isDark, Project p, int index, bool isMobile) {
    return GlassCard(
      hasGlow: p.featured,
      glowColor: AppColors.c1,
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(isMobile ? 24 : 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.c1.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: AppColors.c1.withValues(alpha: 0.2)),
                      ),
                      child: Icon(p.icon, color: AppColors.c1, size: 24),
                    ),
                    if (p.featured)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.c1.withValues(alpha: 0.15), 
                          borderRadius: BorderRadius.circular(20), 
                          border: Border.all(color: AppColors.c1.withValues(alpha: 0.3))
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.bolt, size: 10, color: AppColors.c1),
                            SizedBox(width: 4),
                            Text("FEATURED", style: TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: AppColors.c1, letterSpacing: 1)),
                          ],
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 28),
                Text(
                  p.title, 
                  style: TextStyle(fontSize: isMobile ? 20 : 22, fontWeight: FontWeight.w900, color: isDark ? Colors.white : AppColors.textLight, height: 1.2)
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: Text(
                    p.desc, 
                    style: TextStyle(color: isDark ? AppColors.textMuted : AppColors.textMutedLight, fontSize: 14, height: 1.6), 
                    maxLines: 5, 
                    overflow: TextOverflow.ellipsis
                  ),
                ),
                const SizedBox(height: 20),
                Wrap(
                  spacing: 12, 
                  runSpacing: 8, 
                  children: p.tech.map((t) => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.c3.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: AppColors.c3.withValues(alpha: 0.1)),
                    ),
                    child: Text(
                      t, 
                      style: const TextStyle(fontSize: 10, color: AppColors.c3, fontWeight: FontWeight.w900, fontFamily: 'Fira Code')
                    ),
                  )).toList()
                ),
                const SizedBox(height: 28),
                Row(
                  children: [
                    if (p.live.isNotEmpty) _buildCardLink(isDark, "LIVE", FontAwesomeIcons.arrowUpRightFromSquare, p.live),
                    const SizedBox(width: 12),
                    _buildCardLink(isDark, "CODE", FontAwesomeIcons.github, p.code),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: 0, left: 0, right: 0, 
            child: Container(
              height: 4, 
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [AppColors.c1, AppColors.c2, AppColors.c3])
              )
            )
          ),
        ],
      ),
    ).animate().fadeIn(delay: (index * 120).ms, duration: 800.ms).slideY(begin: 0.1, end: 0);
  }

  Widget _buildCardLink(bool isDark, String label, IconData icon, String url) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          HapticFeedback.lightImpact();
          launchUrl(Uri.parse(url));
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: (isDark ? Colors.white : Colors.black).withValues(alpha: 0.05), 
            borderRadius: BorderRadius.circular(12), 
            border: Border.all(color: (isDark ? Colors.white : Colors.black).withValues(alpha: 0.1))
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 14, color: isDark ? Colors.white : AppColors.textLight),
              const SizedBox(width: 8),
              Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 1)),
            ],
          ),
        ),
      ),
    );
  }
}
