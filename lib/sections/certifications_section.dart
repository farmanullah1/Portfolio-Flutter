import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme.dart';
import '../data.dart';
import '../widgets/section_header.dart';
import '../widgets/glass_card.dart';

class CertificationsSection extends StatefulWidget {
  const CertificationsSection({super.key});

  @override
  State<CertificationsSection> createState() => _CertificationsSectionState();
}

class _CertificationsSectionState extends State<CertificationsSection> {
  String _selectedFilter = 'All';

  @override
  Widget build(BuildContext context) {
    final filtered = CertificationsData.items.where((c) {
      if (_selectedFilter == 'All') return true;
      return c.category == _selectedFilter;
    }).toList();

    return Column(
      children: [
        const SectionHeader(title: "Licenses & Certifications"),
        _buildFilters(),
        const SizedBox(height: 40),
        _buildGrid(filtered),
      ],
    );
  }

  Widget _buildFilters() {
    final filters = ['All', '.NET', 'React', 'DevOps', 'AI', 'Other'];
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
      onTap: () => setState(() => _selectedFilter = name),
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? AppColors.c2 : AppColors.bgCard,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: isActive ? Colors.transparent : AppColors.border),
        ),
        child: Text(
          name,
          style: TextStyle(
            color: isActive ? Colors.white : AppColors.textDim,
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  Widget _buildGrid(List<Certification> items) {
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
          children: items.map((c) => _buildCertCard(c, itemWidth)).toList(),
        );
      },
    );
  }

  Widget _buildCertCard(Certification c, double width) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GlassCard(
      width: width,
      padding: const EdgeInsets.all(24),
      borderColor: c.color.withOpacity(0.3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: c.color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: c.color.withOpacity(0.3)),
                ),
                child: Text(c.category, style: TextStyle(color: c.color, fontSize: 10, fontWeight: FontWeight.bold)),
              ),
              Text(c.date, style: const TextStyle(fontSize: 12, color: AppColors.textDim)),
            ],
          ),
          const SizedBox(height: 20),
          Text(c.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, height: 1.3)),
          const SizedBox(height: 8),
          Text(c.issuer, style: const TextStyle(fontSize: 15, color: AppColors.c3, fontWeight: FontWeight.w600)),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: c.skills.map((s) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: c.color.withOpacity(0.08),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: c.color.withOpacity(0.2)),
              ),
              child: Text(s, style: TextStyle(fontSize: 11, color: isDark ? Colors.white70 : AppColors.textLight)),
            )).toList(),
          ),
          const SizedBox(height: 24),
          InkWell(
            onTap: () => launchUrl(Uri.parse(c.link)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.open_in_new, size: 14, color: c.color),
                const SizedBox(width: 8),
                Text("Show Credential", style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: c.color)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
