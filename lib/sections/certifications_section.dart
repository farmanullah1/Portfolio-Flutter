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

class CertificationsSection extends StatefulWidget {
  const CertificationsSection({super.key});

  @override
  State<CertificationsSection> createState() => _CertificationsSectionState();
}

class _CertificationsSectionState extends State<CertificationsSection> {
  String _filter = 'All';
  String _search = '';

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    final filtered = ContentData.certs.where((c) {
      final mf = _filter == 'All' || c.category == _filter;
      final ms = c.title.toLowerCase().contains(_search.toLowerCase()) || 
                 c.issuer.toLowerCase().contains(_search.toLowerCase()) || 
                 c.skills.any((s) => s.toLowerCase().contains(_search.toLowerCase()));
      return mf && ms;
    }).toList();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 100),
      child: Column(
        children: [
          const SectionHeader(title: 'Licenses & Certifications', index: '05'),
          const SizedBox(height: 56),
          _buildStatsBar(screenWidth, isMobile),
          const SizedBox(height: 48),
          _buildSearchBar(isDark, isMobile),
          const SizedBox(height: 32),
          _buildFilters(isDark, isMobile),
          const SizedBox(height: 56),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: filtered.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: screenWidth < 768 ? 1 : (screenWidth < 1100 ? 2 : 3),
              crossAxisSpacing: isMobile ? 20 : 32,
              mainAxisSpacing: isMobile ? 20 : 32,
              childAspectRatio: screenWidth < 768 ? 0.9 : 0.85,
            ),
            itemBuilder: (context, i) => _buildCertCard(isDark, filtered[i], i, isMobile),
          ),
          if (filtered.isEmpty) 
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 80), 
              child: Column(
                children: [
                  Icon(Icons.search_off, size: 48, color: AppColors.c1.withValues(alpha: 0.5)),
                  const SizedBox(height: 16),
                  Text(
                    "No certifications match your search.", 
                    style: TextStyle(color: isDark ? AppColors.textDim : AppColors.textDimLight, fontWeight: FontWeight.bold)
                  ),
                ],
              )
            ),
        ],
      ),
    );
  }

  Widget _buildStatsBar(double screenWidth, bool isMobile) {
    return GlassCard(
      hasGlow: true,
      glowColor: AppColors.c1,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 40, vertical: 32),
        child: Wrap(
          alignment: WrapAlignment.center,
          spacing: isMobile ? 32 : 80,
          runSpacing: 32,
          children: [
            _buildStat(ContentData.certs.length.toString(), 'Total Certs'),
            _buildStat('10', 'Issuers'),
            _buildStat('5', 'Categories'),
          ],
        ),
      ),
    );
  }

  Widget _buildStat(String n, String l) {
    return Column(
      children: [
        Text(n, style: const TextStyle(fontSize: 36, fontWeight: FontWeight.w900, color: AppColors.c1, letterSpacing: -1)), 
        const SizedBox(height: 4),
        Text(l.toUpperCase(), style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: AppColors.textDim, letterSpacing: 1.5, fontFamily: 'Fira Code'))
      ]
    );
  }

  Widget _buildSearchBar(bool isDark, bool isMobile) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 700),
      child: TextField(
        onChanged: (v) => setState(() => _search = v),
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        decoration: InputDecoration(
          hintText: "Filter by title, issuer, or tech...",
          hintStyle: TextStyle(color: (isDark ? Colors.white : Colors.black).withValues(alpha: 0.2)),
          prefixIcon: const Icon(Icons.search, color: AppColors.c1),
          filled: true, 
          fillColor: (isDark ? Colors.white : Colors.black).withValues(alpha: 0.04),
          contentPadding: const EdgeInsets.all(20),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: (isDark ? Colors.white : Colors.black).withValues(alpha: 0.1))),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: AppColors.c1, width: 2)),
        ),
      ),
    );
  }

  Widget _buildFilters(bool isDark, bool isMobile) {
    final filters = ['All', '.NET', 'React', 'DevOps', 'AI', 'Other'];
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      alignment: WrapAlignment.center,
      children: filters.map((f) {
        final isSelected = _filter == f;
        return GestureDetector(
          onTap: () {
            HapticFeedback.selectionClick();
            setState(() => _filter = f);
          },
          child: AnimatedContainer(
            duration: 300.ms,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.c1 : (isDark ? AppColors.bgCard : Colors.white),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: isSelected ? AppColors.c1 : (isDark ? AppColors.border : AppColors.borderLight)),
            ),
            child: Text(
              f, 
              style: TextStyle(color: isSelected ? Colors.white : (isDark ? AppColors.textDim : AppColors.textDimLight), fontWeight: FontWeight.bold, fontSize: 13)
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildCertCard(bool isDark, Certification c, int i, bool isMobile) {
    return GlassCard(
      opacity: 0.05,
      child: Stack(
        children: [
          Positioned(top: 0, left: 0, right: 0, child: Container(height: 4, decoration: BoxDecoration(gradient: LinearGradient(colors: [c.color, c.color.withValues(alpha: 0.5)])))),
          Padding(
            padding: EdgeInsets.all(isMobile ? 20 : 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(color: c.color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(10)),
                      child: Icon(FontAwesomeIcons.award, color: c.color, size: 24),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), 
                      decoration: BoxDecoration(
                        color: c.color.withValues(alpha: 0.1), 
                        borderRadius: BorderRadius.circular(30), 
                        border: Border.all(color: c.color.withValues(alpha: 0.2))
                      ), 
                      child: Text(c.category, style: TextStyle(color: c.color, fontSize: 9, fontWeight: FontWeight.w900, letterSpacing: 1))
                    ),
                  ],
                ),
                const SizedBox(height: 28),
                Text(
                  c.title, 
                  style: TextStyle(fontSize: isMobile ? 18 : 20, fontWeight: FontWeight.w900, color: isDark ? Colors.white : AppColors.textLight, height: 1.2), 
                  maxLines: 2, 
                  overflow: TextOverflow.ellipsis
                ),
                const SizedBox(height: 8),
                Text(
                  c.issuer, 
                  style: TextStyle(color: isDark ? AppColors.textDim : AppColors.textDimLight, fontWeight: FontWeight.w800, fontSize: 14)
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: Wrap(
                    spacing: 8, 
                    runSpacing: 8, 
                    children: c.skills.map((s) => Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5), 
                      decoration: BoxDecoration(
                        color: (isDark ? Colors.white : Colors.black).withValues(alpha: 0.04), 
                        borderRadius: BorderRadius.circular(8), 
                        border: Border.all(color: (isDark ? Colors.white : Colors.black).withValues(alpha: 0.08))
                      ), 
                      child: Text(s, style: TextStyle(color: isDark ? AppColors.textMuted : AppColors.textMutedLight, fontSize: 10, fontWeight: FontWeight.w900))
                    )).toList()
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(c.date, style: const TextStyle(color: AppColors.textDim, fontSize: 11, fontFamily: 'Fira Code', fontWeight: FontWeight.bold)),
                    GestureDetector(
                      onTap: () {
                        HapticFeedback.lightImpact();
                        launchUrl(Uri.parse(c.link));
                      },
                      child: Row(
                        children: [
                          Text("CREDENTIAL", style: TextStyle(fontWeight: FontWeight.w900, color: c.color, fontSize: 10, letterSpacing: 1)),
                          const SizedBox(width: 6),
                          Icon(FontAwesomeIcons.arrowUpRightFromSquare, size: 10, color: c.color),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: (i * 100).ms, duration: 800.ms).slideY(begin: 0.1, end: 0);
  }
}
