import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'theme.dart';
import 'sections/sections.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  
  final GlobalKey _homeKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _experienceKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  void _scrollTo(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDark;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(68),
        child: AnimatedBuilder(
          animation: _scrollController,
          builder: (context, child) {
            double offset = _scrollController.hasClients ? _scrollController.offset : 0;
            bool isScrolled = offset > 50;
            double progress = 0;
            if (_scrollController.hasClients && _scrollController.position.maxScrollExtent > 0) {
              progress = (offset / _scrollController.position.maxScrollExtent).clamp(0.0, 1.0);
            }

            return ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: AppBar(
                  backgroundColor: isScrolled 
                    ? (isDark ? AppColors.navbarBg : AppColors.navbarBgLight)
                    : Colors.transparent,
                  elevation: 0,
                  title: _buildLogo(),
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(2),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      height: 2,
                      width: double.infinity,
                      child: FractionallySizedBox(
                        widthFactor: progress,
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(colors: [AppColors.c1, AppColors.c2, AppColors.c3]),
                            boxShadow: [BoxShadow(color: AppColors.c1, blurRadius: 10)],
                          ),
                        ),
                      ),
                    ),
                  ),
                  actions: [
                    if (MediaQuery.of(context).size.width > 800) 
                      _buildNavLinks()
                    else
                      IconButton(
                        icon: const Icon(Icons.menu),
                        onPressed: () => Scaffold.of(context).openEndDrawer(),
                      ),
                    IconButton(
                      icon: Icon(isDark ? FontAwesomeIcons.sun : FontAwesomeIcons.moon, size: 18),
                      onPressed: () => themeProvider.toggleTheme(),
                    ),
                    const SizedBox(width: 8),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      endDrawer: _buildDrawer(),
      body: CustomScrollView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        slivers: [
          _buildSliverSection(_homeKey, const HeroSection(), topPadding: 0),
          _buildSliverSection(_aboutKey, const AboutSection()),
          _buildSliverSection(_skillsKey, const SkillsSection()),
          _buildSliverSection(_projectsKey, const ProjectsSection()),
          _buildSliverSection(_experienceKey, const ExperienceSection()),
          _buildSliverSection(GlobalKey(), const CertificationsSection()),
          _buildSliverSection(GlobalKey(), const WhyMeSection()),
          _buildSliverSection(GlobalKey(), const BlogSection()),
          _buildSliverSection(_contactKey, const ContactSection()),
          const SliverToBoxAdapter(child: FooterSection()),
        ],
      ),
      floatingActionButton: AnimatedBuilder(
        animation: _scrollController,
        builder: (context, child) {
          double offset = _scrollController.hasClients ? _scrollController.offset : 0;
          return AnimatedScale(
            scale: offset > 400 ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 300),
            child: FloatingActionButton(
              onPressed: () => _scrollTo(_homeKey),
              backgroundColor: AppColors.c1,
              child: const Icon(Icons.arrow_upward, color: Colors.white),
            ),
          );
        },
      ),
    );
  }

  Widget _buildLogo() {
    return const Text(
      "Farmanullah.",
      style: TextStyle(fontWeight: FontWeight.w900, fontSize: 24, letterSpacing: -1, color: AppColors.c1),
    );
  }

  Widget _buildNavLinks() {
    return Row(
      children: [
        _navBtn("Home", _homeKey),
        _navBtn("About", _aboutKey),
        _navBtn("Skills", _skillsKey),
        _navBtn("Projects", _projectsKey),
        _navBtn("Contact", _contactKey),
      ],
    );
  }

  Widget _navBtn(String label, GlobalKey key) {
    return TextButton(
      onPressed: () => _scrollTo(key),
      child: Text(label, style: const TextStyle(color: AppColors.textDim, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      backgroundColor: AppColors.bg,
      child: ListView(
        children: [
          const DrawerHeader(child: Center(child: Text("Farmanullah Ansari", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)))),
          _drawerItem("Home", _homeKey),
          _drawerItem("About", _aboutKey),
          _drawerItem("Skills", _skillsKey),
          _drawerItem("Projects", _projectsKey),
          _drawerItem("Experience", _experienceKey),
          _drawerItem("Contact", _contactKey),
        ],
      ),
    );
  }

  Widget _drawerItem(String label, GlobalKey key) {
    return ListTile(
      title: Text(label),
      onTap: () {
        Navigator.pop(context);
        _scrollTo(key);
      },
    );
  }

  Widget _buildSliverSection(GlobalKey key, Widget child, {double topPadding = 100}) {
    return SliverPadding(
      padding: EdgeInsets.fromLTRB(
        MediaQuery.of(context).size.width < 800 ? 20 : 60,
        topPadding,
        MediaQuery.of(context).size.width < 800 ? 20 : 60,
        100,
      ),
      sliver: SliverToBoxAdapter(
        key: key,
        child: child,
      ),
    );
  }
}
