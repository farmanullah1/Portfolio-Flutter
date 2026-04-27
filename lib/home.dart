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
        preferredSize: const Size.fromHeight(60),
        child: Column(
          children: [
            AppBar(
              backgroundColor: _isScrolled
                  ? colorScheme.surface.withOpacity(0.85)
                  : Colors.transparent,
              elevation: 0,
              centerTitle: false,
              title: Text(
                'Farmanullah.',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
              actions: [
                IconButton(
                  icon: Icon(themeProvider.isDark ? FontAwesomeIcons.sun : FontAwesomeIcons.moon, size: 18),
                  onPressed: () => themeProvider.toggleTheme(),
                  color: colorScheme.onSurface,
                ),
                Builder(
                  builder: (context) => IconButton(
                    icon: Icon(Icons.menu, color: colorScheme.onSurface),
                    onPressed: () => Scaffold.of(context).openEndDrawer(),
                  ),
                ),
              ],
            ),
            if (_isScrolled)
              LinearProgressIndicator(
                value: _scrollProgress,
                backgroundColor: Colors.transparent,
                valueColor: AlwaysStoppedAnimation<Color>(colorScheme.primary),
                minHeight: 2,
              ),
          ],
        ),
      ),
      endDrawer: Drawer(
        child: Container(
          color: colorScheme.surface,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(color: colorScheme.primary),
                child: const Text(
                  'Navigation',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
              _buildDrawerItem('Home', _homeKey),
              _buildDrawerItem('About', _aboutKey),
              _buildDrawerItem('Skills', _skillsKey),
              _buildDrawerItem('Projects', _projectsKey),
              _buildDrawerItem('Experience', _experienceKey),
              _buildDrawerItem('Certifications', _certificationsKey),
              _buildDrawerItem('Why Work With Me?', _whyMeKey),
              _buildDrawerItem('Insights & Blog', _blogKey),
              _buildDrawerItem('Contact', _contactKey),
            ],
          ),
        ),
      ),
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
              backgroundColor: colorScheme.primary,
              child: const Icon(Icons.arrow_upward, color: Colors.white),
              onPressed: () => _scrollTo(_homeKey),
            )
          : null,
    );
  }

  Widget _buildDrawerItem(String title, GlobalKey key) {
    return ListTile(
      title: Text(title),
      onTap: () {
        Navigator.pop(context);
        _scrollTo(key);
      },
    );
  }
}
