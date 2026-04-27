import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme.dart';
import 'sections.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  bool _isScrolled = false;
  double _scrollProgress = 0.0;

  final GlobalKey _homeKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _experienceKey = GlobalKey();
  final GlobalKey _certificationsKey = GlobalKey();
  final GlobalKey _whyMeKey = GlobalKey();
  final GlobalKey _blogKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.hasClients) {
      setState(() {
        _isScrolled = _scrollController.offset > 50;
        _scrollProgress = (_scrollController.offset / _scrollController.position.maxScrollExtent).clamp(0.0, 1.0);
      });
    }
  }

  void _scrollTo(GlobalKey key) {
    if (key.currentContext != null) {
      Scrollable.ensureVisible(
        key.currentContext!,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(68),
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
            child: AppBar(
              backgroundColor: _isScrolled
                  ? AppColors.navbarBg
                  : Colors.transparent,
              elevation: 0,
              centerTitle: false,
              title: ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [AppColors.c1, AppColors.c3, AppColors.c1],
                ).createShader(bounds),
                child: const Text(
                  'Farmanullah.',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 28,
                    letterSpacing: -1,
                    color: Colors.white,
                  ),
                ),
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(3),
                child: _isScrolled
                    ? Container(
                        height: 3,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(colors: [AppColors.c1, AppColors.c2, AppColors.c3]),
                        ),
                        child: FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: _scrollProgress,
                          child: Container(
                            decoration: const BoxDecoration(
                              boxShadow: [BoxShadow(color: AppColors.c1, blurRadius: 12)],
                            ),
                          ),
                        ),
                      )
                    : const SizedBox(),
              ),
              actions: [
                IconButton(
                  icon: Icon(themeProvider.isDark ? FontAwesomeIcons.sun : FontAwesomeIcons.moon, size: 18),
                  onPressed: () => themeProvider.toggleTheme(),
                  color: AppColors.text,
                ),
                Builder(
                  builder: (context) => IconButton(
                    icon: const Icon(Icons.menu, color: AppColors.text),
                    onPressed: () => Scaffold.of(context).openEndDrawer(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      endDrawer: _buildDrawer(context, colorScheme),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            Container(key: _homeKey, child: const HeroSection()),
            Container(key: _aboutKey, child: const AboutSection()),
            Container(key: _skillsKey, child: const SkillsSection()),
            Container(key: _projectsKey, child: const ProjectsSection()),
            Container(key: _experienceKey, child: const ExperienceSection()),
            Container(key: _certificationsKey, child: const CertificationsSection()),
            Container(key: _whyMeKey, child: const WhyMeSection()),
            Container(key: _blogKey, child: const BlogSection()),
            Container(key: _contactKey, child: const ContactSection()),
            const FooterSection(),
          ],
        ),
      ),
      floatingActionButton: _isScrolled
          ? FloatingActionButton(
              mini: true,
              backgroundColor: AppColors.c2,
              child: const Icon(Icons.arrow_upward, color: Colors.white),
              onPressed: () => _scrollTo(_homeKey),
            )
          : null,
    );
  }

  Widget _buildDrawer(BuildContext context, ColorScheme colorScheme) {
    return Drawer(
      backgroundColor: AppColors.bg.withOpacity(0.96),
      child: Column(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [AppColors.c1, AppColors.c2]),
            ),
            child: const Center(
              child: Text(
                'Navigation',
                style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildDrawerItem('Home', _homeKey),
                _buildDrawerItem('About', _aboutKey),
                _buildDrawerItem('Skills', _skillsKey),
                _buildDrawerItem('Projects', _projectsKey),
                _buildDrawerItem('Experience', _experienceKey),
                _buildDrawerItem('Certifications', _certificationsKey),
                _buildDrawerItem('Why Me', _whyMeKey),
                _buildDrawerItem('Insights', _blogKey),
                _buildDrawerItem('Contact', _contactKey),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(String title, GlobalKey key) {
    return ListTile(
      title: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      onTap: () {
        Navigator.pop(context);
        _scrollTo(key);
      },
    );
  }
}
