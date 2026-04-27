import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'theme.dart';
import 'sections.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

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
            SectionWrapper(key: _homeKey, hasBorder: false, topPadding: 0, bottomPadding: 0, glowColors: const [AppColors.c1, AppColors.c3], child: const HeroSection()),
            SectionWrapper(key: _aboutKey, glowColors: const [AppColors.c2, AppColors.c4], child: const AboutSection()),
            SectionWrapper(key: _skillsKey, glowColors: const [AppColors.c3, AppColors.c1], child: const SkillsSection()),
            SectionWrapper(key: _projectsKey, glowColors: const [AppColors.c6, AppColors.c2], child: const ProjectsSection()),
            SectionWrapper(key: _experienceKey, glowColors: const [AppColors.c5, AppColors.c1], child: const ExperienceSection()),
            SectionWrapper(key: _certificationsKey, glowColors: const [AppColors.c4, AppColors.c7], child: const CertificationsSection()),
            SectionWrapper(key: _whyMeKey, glowColors: const [AppColors.c1, AppColors.c6], child: const WhyMeSection()),
            SectionWrapper(key: _blogKey, glowColors: const [AppColors.c3, AppColors.c5], child: const BlogSection()),
            SectionWrapper(key: _contactKey, hasBorder: false, glowColors: const [AppColors.c1, AppColors.c2], child: const ContactSection()),
            const FooterSection(),
          ],
        ),
      ),
      floatingActionButton: _isScrolled
          ? Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: const LinearGradient(colors: [AppColors.c1, AppColors.c2]),
                boxShadow: [BoxShadow(color: AppColors.c1.withOpacity(0.3), blurRadius: 12, offset: const Offset(0, 4))],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: FloatingActionButton(
                    mini: true,
                    backgroundColor: Colors.white.withOpacity(0.1),
                    elevation: 0,
                    child: const Icon(Icons.arrow_upward, color: Colors.white, size: 20),
                    onPressed: () {
                      HapticFeedback.mediumImpact();
                      _scrollTo(_homeKey);
                    },
                  ),
                ),
              ),
            ).animate().scale(duration: 400.ms, curve: Curves.backOut)
          : null,
    );
  }

  Widget _buildDrawer(BuildContext context, ColorScheme colorScheme) {
    return Drawer(
      backgroundColor: Colors.transparent,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.bg.withOpacity(0.85),
            border: const Border(left: BorderSide(color: AppColors.border, width: 0.5)),
          ),
          child: Column(
            children: [
              _buildDrawerHeader(),
              const Divider(color: AppColors.border, height: 1),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                  children: [
                    _buildDrawerItem('Home', FontAwesomeIcons.house, _homeKey),
                    _buildDrawerItem('About', FontAwesomeIcons.user, _aboutKey),
                    _buildDrawerItem('Skills', FontAwesomeIcons.bolt, _skillsKey),
                    _buildDrawerItem('Projects', FontAwesomeIcons.code, _projectsKey),
                    _buildDrawerItem('Experience', FontAwesomeIcons.briefcase, _experienceKey),
                    _buildDrawerItem('Certifications', FontAwesomeIcons.certificate, _certificationsKey),
                    _buildDrawerItem('Why Me', FontAwesomeIcons.circleQuestion, _whyMeKey),
                    _buildDrawerItem('Blog', FontAwesomeIcons.newspaper, _blogKey),
                    _buildDrawerItem('Contact', FontAwesomeIcons.envelope, _contactKey),
                  ],
                ),
              ),
              _buildDrawerFooter(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDrawerHeader() {
    return Container(
      padding: const EdgeInsets.only(top: 60, bottom: 30, left: 24, right: 24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.c1.withOpacity(0.15), Colors.transparent],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.c1, width: 2),
              image: const DecorationImage(image: AssetImage('assets/profile2.webp'), fit: BoxFit.cover),
            ),
          ),
          const SizedBox(height: 20),
          const Text('Farmanullah Ansari', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w900)),
          const Text('Full-Stack Engineer', style: TextStyle(color: AppColors.c1, fontSize: 13, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(String title, IconData icon, GlobalKey key) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon, color: AppColors.textDim, size: 18),
        title: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 15)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        hoverColor: AppColors.c1.withOpacity(0.1),
        onTap: () {
          HapticFeedback.lightImpact();
          Navigator.pop(context);
          _scrollTo(key);
        },
      ),
    );
  }

  Widget _buildDrawerFooter() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildFooterIcon(FontAwesomeIcons.github, 'https://github.com/farmanullah1'),
              _buildFooterIcon(FontAwesomeIcons.linkedin, 'https://linkedin.com/in/farmanullah-ansari'),
              _buildFooterIcon(FontAwesomeIcons.twitter, 'https://x.com/farmanullah9088'),
            ],
          ),
          const SizedBox(height: 20),
          const Text('v1.0.0 Stable', style: TextStyle(color: AppColors.textDim, fontSize: 11, fontFamily: 'Fira Code')),
        ],
      ),
    );
  }

  Widget _buildFooterIcon(IconData icon, String url) {
    return IconButton(
      icon: Icon(icon, color: AppColors.textDim, size: 18),
      onPressed: () => launchUrl(Uri.parse(url)),
    );
  }
}
