import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme.dart';
import '../data.dart';
import '../widgets/section_header.dart';
import '../widgets/glass_card.dart';
import '../widgets/premium_button.dart';

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  String _selectedFilter = 'All';
  int _visibleCount = 6;

  @override
  Widget build(BuildContext context) {
    final filtered = ProjectsData.projects.where((p) {
      if (_selectedFilter == 'All') return true;
      if (_selectedFilter == 'Featured') return p.featured;
      return p.tech.any((t) => t.contains(_selectedFilter));
    }).toList();

    final displayed = filtered.take(_visibleCount).toList();

    return Column(
      children: [
        const SectionHeader(title: "Featured Projects"),
        _buildFilters(),
        const SizedBox(height: 40),
        _buildProjectGrid(displayed),
        if (_visibleCount < filtered.length) ...[
          const SizedBox(height: 40),
          _buildLoadMoreButton(),
        ],
      ],
    );
  }

  Widget _buildFilters() {
    final filters = ['All', 'Featured', 'React.js', 'ASP.NET Core', 'MERN', 'TypeScript'];
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      alignment: WrapAlignment.center,
      children: filters.map((f) => _buildFilterBtn(f)).toList(),
    );
  }

  Widget _buildFilterBtn(String name) {
    final isActive = _selectedFilter == name;
    return InkWell(
      onTap: () => setState(() {
        _selectedFilter = name;
        _visibleCount = 6;
      }),
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          gradient: isActive ? const LinearGradient(colors: [AppColors.c1, AppColors.c2]) : null,
          color: isActive ? null : AppColors.bgCard,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: isActive ? Colors.transparent : AppColors.border),
        ),
        child: Text(
          name,
          style: TextStyle(
            color: isActive ? Colors.white : AppColors.textDim,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildProjectGrid(List<Project> projects) {
    final width = MediaQuery.of(context).size.width;
    int crossAxisCount = 3;
    if (width < 700) {
      crossAxisCount = 1;
    } else if (width < 1100) {
      crossAxisCount = 2;
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        double itemWidth = (constraints.maxWidth - (crossAxisCount - 1) * 20) / crossAxisCount;
        return Wrap(
          spacing: 20,
          runSpacing: 20,
          children: projects.map((p) => _buildProjectCard(p, itemWidth)).toList(),
        );
      },
    );
  }

  Widget _buildProjectCard(Project p, double width) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GlassCard(
      width: width,
      padding: const EdgeInsets.all(28),
      borderColor: p.featured ? AppColors.c1.withValues(alpha: 0.3) : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (p.featured)
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.c1.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.star, size: 12, color: AppColors.c1),
                  SizedBox(width: 6),
                  Text("FEATURED", style: TextStyle(color: AppColors.c1, fontSize: 10, fontWeight: FontWeight.w900)),
                ],
              ),
            ),
          Icon(p.icon, color: AppColors.c1, size: 32),
          const SizedBox(height: 20),
          Text(
            p.title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Text(
            p.desc,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: isDark ? AppColors.textMuted : AppColors.textMutedLight, height: 1.5),
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: p.tech.map((t) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.bg.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(t, style: const TextStyle(fontSize: 10, color: AppColors.textDim)),
            )).toList(),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              if (p.live.isNotEmpty)
                _buildLinkBtn("Live", FontAwesomeIcons.arrowUpRightFromSquare, p.live),
              const SizedBox(width: 16),
              _buildLinkBtn("Code", FontAwesomeIcons.github, p.code),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLinkBtn(String label, IconData icon, String url) {
    return InkWell(
      onTap: () => launchUrl(Uri.parse(url)),
      child: Row(
        children: [
          Icon(icon, size: 14, color: AppColors.c3),
          const SizedBox(width: 8),
          Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.c3)),
        ],
      ),
    );
  }

  Widget _buildLoadMoreButton() {
    return PremiumButton(
      label: "More Projects",
      icon: Icons.add,
      onPressed: () => setState(() => _visibleCount += 6),
    );
  }
}
