import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../theme.dart';
import '../data.dart';
import '../models.dart';
import '../widgets/glass_card.dart';
import '../widgets/section_header.dart';

class SkillsSection extends StatefulWidget {
  const SkillsSection({super.key});

  @override
  State<SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends State<SkillsSection> with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _animationController = AnimationController(
      vsync: this,
      duration: 180.seconds, // Slower marquee as requested
    )..addListener(() {
      if (_scrollController.hasClients) {
        final maxScroll = _scrollController.position.maxScrollExtent;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (_scrollController.hasClients && mounted) {
            _scrollController.jumpTo(_animationController.value * maxScroll);
          }
        });
      }
    });
    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 1000;

    return Column(
      children: [
        const SectionHeader(
          title: 'Technical Arsenal',
          index: '04',
          subtitle: 'A specialized tech stack engineered for building high-performance, scalable digital solutions.',
        ),
        const SizedBox(height: 64),
        _buildMarquee(context),
        const SizedBox(height: 80),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: isMobile ? 0 : 20),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: ContentData.skills.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isMobile ? 1 : (screenWidth < 1300 ? 2 : 4),
              mainAxisSpacing: 32,
              crossAxisSpacing: 32,
              childAspectRatio: isMobile ? 1.3 : (screenWidth < 1300 ? 1.0 : 0.82),
            ),
            itemBuilder: (context, index) => _buildSkillCategory(context, ContentData.skills[index], index, isMobile),
          ),
        ),
      ],
    );
  }

  Widget _buildMarquee(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return RepaintBoundary(
      child: SizedBox(
        height: 140,
        width: double.infinity,
        child: ShaderMask(
          shaderCallback: (rect) {
            return const LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Colors.transparent, Colors.black, Colors.black, Colors.transparent],
              stops: [0.0, 0.15, 0.85, 1.0],
            ).createShader(rect);
          },
          blendMode: BlendMode.dstIn,
          child: ListView.builder(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(), // Prevent manual scroll interference
            itemCount: 1000,
            itemBuilder: (context, index) {
              final item = ContentData.marquee[index % ContentData.marquee.length];
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        color: (isDark ? Colors.white : Colors.black).withValues(alpha: 0.04),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: (isDark ? Colors.white : Colors.black).withValues(alpha: 0.08)),
                        boxShadow: [
                          if (isDark) BoxShadow(color: AppColors.c1.withValues(alpha: 0.05), blurRadius: 10)
                        ],
                      ),
                      child: Center(
                        child: Icon(_getSkillIcon(item.name) ?? item.icon, color: AppColors.c1, size: 32),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      item.name,
                      style: TextStyle(
                        fontSize: 13, 
                        fontWeight: FontWeight.w900, 
                        color: isDark ? AppColors.textDim : AppColors.textDimLight,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSkillCategory(BuildContext context, SkillCategory category, int index, bool isMobile) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GlassCard(
      hasGlow: true,
      glowColor: category.color,
      child: Stack(
        children: [
          Positioned(
            bottom: -30,
            right: -30,
            child: Icon(category.icon, size: 140, color: category.color.withValues(alpha: 0.04)),
          ),
          Padding(
            padding: EdgeInsets.all(isMobile ? 28.0 : 36.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: category.color.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Icon(category.icon, color: category.color, size: 24),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      category.title, 
                      style: TextStyle(
                        fontSize: 19, 
                        fontWeight: FontWeight.w900, 
                        color: isDark ? Colors.white : AppColors.textLight,
                        letterSpacing: -0.5
                      )
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                Expanded(
                  child: Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: category.skills.map((s) => _buildSkillBadge(context, s, category.color)).toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: (index * 150).ms, duration: 800.ms).slideY(begin: 0.1, end: 0);
  }

  Widget _buildSkillBadge(BuildContext context, String name, Color color) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final icon = _getSkillIcon(name);
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: (isDark ? Colors.white : Colors.black).withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.2), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 13, color: color),
            const SizedBox(width: 10),
          ],
          Text(
            name,
            style: TextStyle(
              color: isDark ? Colors.white : AppColors.textLight,
              fontSize: 12,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  IconData? _getSkillIcon(String name) {
    final n = name.toLowerCase();
    
    // Core Languages & Frameworks
    if (n.contains('react') || n.contains('next.js') || n.contains('vite')) return FontAwesomeIcons.react;
    if (n.contains('node') || n.contains('express')) return FontAwesomeIcons.nodeJs;
    if (n.contains('js') || n.contains('javascript') || n.contains('typescript') || n.contains('ts')) return FontAwesomeIcons.js;
    if (n.contains('python') || n.contains('flask') || n.contains('django')) return FontAwesomeIcons.python;
    if (n.contains('java') || n.contains('spring')) return FontAwesomeIcons.java;
    if (n.contains('c#') || n.contains('.net')) return FontAwesomeIcons.code;
    
    // Mobile
    if (n.contains('flutter') || n.contains('dart') || n.contains('mobile')) return FontAwesomeIcons.mobileScreen;
    
    // Cloud & DevOps
    if (n.contains('aws')) return FontAwesomeIcons.aws;
    if (n.contains('azure')) return FontAwesomeIcons.microsoft;
    if (n.contains('gcp') || n.contains('google cloud')) return FontAwesomeIcons.google;
    if (n.contains('docker')) return FontAwesomeIcons.docker;
    if (n.contains('kubernetes')) return FontAwesomeIcons.cube;
    if (n.contains('git') || n.contains('github') || n.contains('gitlab')) return FontAwesomeIcons.github;
    if (n.contains('action')) return FontAwesomeIcons.play;
    if (n.contains('linux') || n.contains('ubuntu') || n.contains('terminal')) return FontAwesomeIcons.linux;
    
    // Databases
    if (n.contains('sql') || n.contains('postgres') || n.contains('mysql') || n.contains('oracle') || n.contains('database')) return FontAwesomeIcons.database;
    if (n.contains('mongo') || n.contains('nosql')) return FontAwesomeIcons.leaf;
    if (n.contains('redis')) return FontAwesomeIcons.fire;
    
    // Frontend Tools
    if (n.contains('html')) return FontAwesomeIcons.html5;
    if (n.contains('css') || n.contains('sass') || n.contains('less') || n.contains('tailwind') || n.contains('bootstrap')) return FontAwesomeIcons.css3;
    if (n.contains('redux') || n.contains('state')) return FontAwesomeIcons.atom;
    
    // Design & UI
    if (n.contains('figma')) return FontAwesomeIcons.figma;
    if (n.contains('sketch')) return FontAwesomeIcons.sketch;
    if (n.contains('design') || n.contains('ui') || n.contains('ux')) return FontAwesomeIcons.palette;
    
    // Tools
    if (n.contains('jira')) return FontAwesomeIcons.jira;
    if (n.contains('trello')) return FontAwesomeIcons.trello;
    if (n.contains('postman')) return FontAwesomeIcons.envelopeOpen;
    if (n.contains('docker')) return FontAwesomeIcons.docker;
    
    // Data
    if (n.contains('power bi') || n.contains('tableau') || n.contains('excel')) return FontAwesomeIcons.chartBar;
    
    // Default
    if (n.contains('api') || n.contains('rest')) return FontAwesomeIcons.server;
    if (n.contains('security')) return FontAwesomeIcons.shieldHalved;
    
    return null;
  }
}
