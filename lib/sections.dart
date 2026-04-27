import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';
import 'theme.dart';
import 'models.dart';

// --- Shared Components ---

class SectionHeader extends StatelessWidget {
  final String title;
  final String? subtitle;

  const SectionHeader({Key? key, required this.title, this.subtitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w900,
            letterSpacing: -1,
          ),
        ).animate().fadeIn(duration: 600.ms).slideY(begin: -0.2, end: 0),
        const SizedBox(height: 12),
        Container(
          width: 56,
          height: 4,
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [AppColors.c1, AppColors.c2]),
            borderRadius: BorderRadius.circular(4),
            boxShadow: [BoxShadow(color: AppColors.c1.withOpacity(0.5), blurRadius: 10)],
          ),
        ).animate().scaleX(begin: 0, end: 1, duration: 800.ms),
        if (subtitle != null) ...[
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              subtitle!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.textDim,
                fontSize: 16,
                height: 1.6,
              ),
            ),
          ).animate().fadeIn(delay: 200.ms),
        ],
      ],
    );
  }
}

class GlassCard extends StatelessWidget {
  final Widget child;
  final double blur;
  final double opacity;
  final Color? color;
  final BorderRadius? borderRadius;
  final Border? border;

  const GlassCard({
    Key? key,
    required this.child,
    this.blur = 24,
    this.opacity = 0.04,
    this.color,
    this.borderRadius,
    this.border,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(18),
      child: BackdropFilter(
        filter: ColorFilter.mode(Colors.white.withOpacity(0.01), BlendMode.srcOver),
        child: Container(
          decoration: BoxDecoration(
            color: color ?? Colors.white.withOpacity(opacity),
            borderRadius: borderRadius ?? BorderRadius.circular(18),
            border: border ?? Border.all(color: Colors.white.withOpacity(0.08)),
          ),
          child: child,
        ),
      ),
    );
  }
}

// --- Hero Section ---

class HeroSection extends StatefulWidget {
  const HeroSection({Key? key}) : super(key: key);

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> with TickerProviderStateMixin {
  int _roleIndex = 0;
  String _displayedRole = "";
  bool _isTyping = true;
  Timer? _typingTimer;

  final List<String> _roles = [
    'Full-Stack Developer',
    'MERN Stack Engineer',
    'ASP.NET Core Developer',
    'Cloud & DevOps Enthusiast',
    'TypeScript Developer',
    'Docker & Containerization Specialist',
    'Data Analyst & Power BI Developer',
    'Software Engineer',
    'Backend API Architect',
    'Frontend Specialist (React)',
    'Cloud Infrastructure Engineer',
    'Logic & Game Engine Developer'
  ];

  @override
  void initState() {
    super.initState();
    _startTyping();
  }

  void _startTyping() {
    String target = _roles[_roleIndex];
    if (_isTyping) {
      if (_displayedRole.length < target.length) {
        _typingTimer = Timer(const Duration(milliseconds: 60), () {
          if (mounted) {
            setState(() {
              _displayedRole = target.substring(0, _displayedRole.length + 1);
            });
            _startTyping();
          }
        });
      } else {
        _typingTimer = Timer(const Duration(milliseconds: 1900), () {
          if (mounted) {
            setState(() => _isTyping = false);
            _startTyping();
          }
        });
      }
    } else {
      if (_displayedRole.isNotEmpty) {
        _typingTimer = Timer(const Duration(milliseconds: 30), () {
          if (mounted) {
            setState(() {
              _displayedRole = _displayedRole.substring(0, _displayedRole.length - 1);
            });
            _startTyping();
          }
        });
      } else {
        if (mounted) {
          setState(() {
            _roleIndex = (_roleIndex + 1) % _roles.length;
            _isTyping = true;
          });
          _startTyping();
        }
      }
    }
  }

  @override
  void dispose() {
    _typingTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 1000;

    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 800),
      child: Stack(
        children: [
          _buildBackground(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: isMobile ? 24 : 100, vertical: 80),
            child: isMobile ? _buildMobileLayout() : _buildDesktopLayout(),
          ),
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: _buildScrollCue(),
          ),
        ],
      ),
    );
  }

  Widget _buildBackground() {
    return Positioned.fill(
      child: Stack(
        children: [
          _buildOrb(const Color(0x7A7C3AED), top: -100, right: -100, size: 600),
          _buildOrb(const Color(0x66E040FB), bottom: -100, left: -100, size: 500),
          _buildOrb(const Color(0x4700E5FF), top: 200, left: 100, size: 350),
          Opacity(
            opacity: 0.1,
            child: CustomPaint(
              painter: GridPainter(),
              size: Size.infinite,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrb(Color color, {double? top, double? bottom, double? left, double? right, required double size}) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [color, color.withOpacity(0)],
          ),
        ),
      ).animate(onPlay: (c) => c.repeat(reverse: true)).move(begin: const Offset(-20, -20), end: const Offset(20, 20), duration: 8.seconds),
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: _buildTextContent(),
        ),
        Expanded(
          flex: 1,
          child: _buildHeroImage(),
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildHeroImage(),
        const SizedBox(height: 60),
        _buildTextContent(),
      ],
    );
  }

  Widget _buildTextContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildBadge(),
        const SizedBox(height: 24),
        const Text(
          "Hi, I'm",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: AppColors.textMuted),
        ),
        const Text(
          "Farmanullah Ansari",
          style: TextStyle(
            fontSize: 72,
            fontWeight: FontWeight.w900,
            height: 1,
            letterSpacing: -2,
            color: Colors.white,
          ),
        ).animate().shimmer(duration: 3.seconds, color: AppColors.c1),
        const SizedBox(height: 16),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            const Text(
              "I'm a ",
              style: TextStyle(fontSize: 24, color: AppColors.textDim),
            ),
            Text(
              _displayedRole,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: AppColors.c3,
              ),
            ),
            Container(
              width: 2,
              height: 28,
              color: AppColors.c3,
              margin: const EdgeInsets.only(left: 4),
            ).animate(onPlay: (c) => c.repeat()).fadeOut(duration: 400.ms),
          ],
        ),
        const SizedBox(height: 32),
        const SizedBox(
          width: 500,
          child: Text(
            "I engineer dynamic, user-friendly, and scalable web applications. Passionate about the MERN stack, ASP.NET Core, cloud computing, and building seamless digital experiences.",
            style: TextStyle(fontSize: 16, color: AppColors.textMuted, height: 1.8),
          ),
        ),
        const SizedBox(height: 48),
        _buildStats(),
        const SizedBox(height: 48),
        _buildActions(),
        const SizedBox(height: 40),
        _buildSocials(),
      ],
    ).animate().fadeIn(duration: 800.ms).slideX(begin: -0.1, end: 0);
  }

  Widget _buildBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.c1.withOpacity(0.12),
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: AppColors.c1.withOpacity(0.38)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: AppColors.c3,
              shape: BoxShape.circle,
            ),
          ).animate(onPlay: (c) => c.repeat()).scale(begin: const Offset(1,1), end: const Offset(1.5, 1.5)).fadeOut(),
          const SizedBox(width: 12),
          const Text(
            "Available for new opportunities",
            style: TextStyle(color: AppColors.c1, fontWeight: FontWeight.bold, fontSize: 13),
          ),
        ],
      ),
    );
  }

  Widget _buildStats() {
    final stats = [
      {'num': '3+', 'label': 'Years Coding'},
      {'num': '10+', 'label': 'Projects Built'},
      {'num': '10+', 'label': 'Certifications'},
    ];

    return GlassCard(
      opacity: 0.1,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: stats.asMap().entries.map((e) {
            return Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      e.value['num']!,
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                        color: AppColors.c1,
                      ),
                    ),
                    Text(
                      e.value['label']!.toUpperCase(),
                      style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.textDim, letterSpacing: 1),
                    ),
                  ],
                ),
                if (e.key < stats.length - 1)
                  Container(
                    width: 1,
                    height: 40,
                    color: Colors.white.withOpacity(0.1),
                    margin: const EdgeInsets.symmetric(horizontal: 32),
                  ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildActions() {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        _buildButton("Hire Me", FontAwesomeIcons.envelope, isPrimary: true),
        _buildButton("Download CV", FontAwesomeIcons.download, isPrimary: false),
      ],
    );
  }

  Widget _buildButton(String text, IconData icon, {required bool isPrimary}) {
    return Container(
      decoration: isPrimary ? BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: const LinearGradient(colors: [AppColors.c1, AppColors.c2]),
        boxShadow: [BoxShadow(color: AppColors.c1.withOpacity(0.3), blurRadius: 15, offset: const Offset(0, 5))],
      ) : null,
      child: ElevatedButton.icon(
        onPressed: () {},
        icon: Icon(icon, size: 16, color: isPrimary ? Colors.white : AppColors.c1),
        label: Text(text, style: TextStyle(color: isPrimary ? Colors.white : AppColors.c1)),
        style: ElevatedButton.styleFrom(
          backgroundColor: isPrimary ? Colors.transparent : AppColors.bgCard,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 22),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: isPrimary ? BorderSide.none : const BorderSide(color: AppColors.c1, width: 1.5),
          ),
        ),
      ),
    ).animate(onPlay: (c) => c.repeat()).shimmer(delay: 3.seconds, duration: 2.seconds);
  }

  Widget _buildSocials() {
    return Row(
      children: [
        _buildSocialBtn(FontAwesomeIcons.github, "https://github.com/farmanullah1"),
        _buildSocialBtn(FontAwesomeIcons.linkedin, "https://linkedin.com/in/farmanullah-ansari"),
        const SizedBox(width: 12),
        const Text("Let's connect", style: TextStyle(color: AppColors.textDim, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildSocialBtn(IconData icon, String url) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      child: IconButton(
        onPressed: () => launchUrl(Uri.parse(url)),
        icon: Icon(icon, size: 20, color: AppColors.textMuted),
        style: IconButton.styleFrom(
          backgroundColor: Colors.white.withOpacity(0.04),
          padding: const EdgeInsets.all(12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide(color: Colors.white.withOpacity(0.08))),
        ),
      ),
    );
  }

  Widget _buildHeroImage() {
    return Center(
      child: SizedBox(
        width: 500,
        height: 500,
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            // Orbital Badges
            ..._buildFloatingBadges(),
            // Rings
            Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.c2.withOpacity(0.2), width: 1.5),
              ),
            ).animate(onPlay: (c) => c.repeat(reverse: true)).scale(begin: const Offset(1,1), end: const Offset(1.05, 1.05), duration: 3.seconds),
            
            SizedBox(
              width: 440,
              height: 440,
              child: CustomPaint(
                painter: DashedRingPainter(color: AppColors.c1.withOpacity(0.3)),
              ),
            ).animate(onPlay: (c) => c.repeat()).rotate(duration: 25.seconds),

            Container(
              width: 420,
              height: 420,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: SweepGradient(
                  colors: [AppColors.c1.withOpacity(0), AppColors.c1.withOpacity(0.5), AppColors.c1.withOpacity(0)],
                  stops: const [0.0, 0.5, 1.0],
                ),
              ),
            ).animate(onPlay: (c) => c.repeat()).rotate(duration: 8.seconds),

            // Main Image
            Container(
              width: 340,
              height: 340,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.c2, width: 2),
                boxShadow: [
                  BoxShadow(color: AppColors.c1.withOpacity(0.4), blurRadius: 40),
                  BoxShadow(color: AppColors.c2.withOpacity(0.2), blurRadius: 80),
                ],
              ),
              child: ClipOval(
                child: Image.asset(
                  'assets/profile2.webp',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildFloatingBadges() {
    final badges = [
      {'text': 'React.js', 'icon': FontAwesomeIcons.react, 'color': const Color(0xFF61DAFB), 'top': 0.05, 'left': 0.15, 'dur': 3.0},
      {'text': 'Node.js', 'icon': FontAwesomeIcons.nodeJs, 'color': const Color(0xFF339933), 'top': 0.15, 'left': 0.85, 'dur': 3.8},
      {'text': 'AWS', 'icon': FontAwesomeIcons.aws, 'color': const Color(0xFFFF9900), 'top': 0.45, 'left': 0.95, 'dur': 3.3},
      {'text': 'TypeScript', 'icon': FontAwesomeIcons.code, 'color': const Color(0xFF3178C6), 'top': 0.75, 'left': 0.85, 'dur': 3.5},
      {'text': 'Docker', 'icon': FontAwesomeIcons.docker, 'color': const Color(0xFF2496ED), 'top': 0.90, 'left': 0.50, 'dur': 3.6},
      {'text': 'C# / .NET', 'icon': FontAwesomeIcons.terminal, 'color': const Color(0xFF00A4EF), 'top': 0.75, 'left': 0.15, 'dur': 4.0},
      {'text': 'Python', 'icon': FontAwesomeIcons.python, 'color': const Color(0xFF3776AB), 'top': 0.45, 'left': 0.05, 'dur': 3.7},
    ];

    return badges.map((b) {
      return Positioned(
        top: 500 * (b['top'] as double),
        left: 500 * (b['left'] as double),
        child: _buildFloatingBadge(
          b['text'] as String,
          b['icon'] as IconData,
          b['color'] as Color,
          b['dur'] as double,
        ),
      );
    }).toList();
  }

  Widget _buildFloatingBadge(String text, IconData icon, Color color, double dur) {
    return GlassCard(
      blur: 18,
      opacity: 0.8,
      color: const Color(0xD10F0724),
      borderRadius: BorderRadius.circular(30),
      border: Border.all(color: color.withOpacity(0.3)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14, color: color),
            const SizedBox(width: 8),
            Text(
              text,
              style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    ).animate(onPlay: (c) => c.repeat(reverse: true)).moveY(begin: -10, end: 10, duration: (dur * 1000).toInt().ms, curve: Curves.easeInOut);
  }

  Widget _buildScrollCue() {
    return Column(
      children: [
        const Text(
          'SCROLL DOWN',
          style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.5, color: AppColors.textDim),
        ),
        const SizedBox(height: 8),
        Container(
          width: 22,
          height: 34,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.c2.withOpacity(0.5)),
          ),
          child: Column(
            children: [
              const SizedBox(height: 5),
              Container(
                width: 3,
                height: 8,
                decoration: BoxDecoration(
                  color: AppColors.c1,
                  borderRadius: BorderRadius.circular(3),
                ),
              ).animate(onPlay: (c) => c.repeat()).moveY(begin: 0, end: 12, duration: 1.8.seconds).fadeOut(),
            ],
          ),
        ),
      ],
    ).animate().fadeIn(delay: 1.5.seconds);
  }
}

class GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0x15AA64FF)
      ..strokeWidth = 1;

    const spacing = 60.0;
    for (double i = 0; i < size.width; i += spacing) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
    }
    for (double i = 0; i < size.height; i += spacing) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
    }
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class DashedRingPainter extends CustomPainter {
  final Color color;
  DashedRingPainter({required this.color});
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color..strokeWidth = 2..style = PaintingStyle.stroke;
    const double dashWidth = 10, dashSpace = 6;
    double currentAngle = 0;
    final double radius = size.width / 2;
    while (currentAngle < 2 * 3.14159) {
      canvas.drawArc(Rect.fromCircle(center: Offset(radius, radius), radius: radius), currentAngle, dashWidth / radius, false, paint);
      currentAngle += (dashWidth + dashSpace) / radius;
    }
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

// --- About Section ---

class AboutSection extends StatelessWidget {
  const AboutSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 1000;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 100.0, horizontal: isMobile ? 24 : 100),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Column(
        children: [
          const SectionHeader(title: 'About Me'),
          const SizedBox(height: 64),
          if (isMobile)
            Column(children: [_buildAboutText(context), const SizedBox(height: 60), _buildHighlights(screenWidth)])
          else
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 1, child: _buildAboutText(context)),
                const SizedBox(width: 80),
                Expanded(flex: 1, child: _buildHighlights(screenWidth)),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildAboutText(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: const TextSpan(
            style: TextStyle(fontSize: 18, height: 1.8, color: AppColors.textMuted, fontFamily: 'Outfit'),
            children: [
              TextSpan(text: "I'm a passionate "),
              TextSpan(text: "Full-Stack Software Engineer", style: TextStyle(color: AppColors.c1, fontWeight: FontWeight.bold)),
              TextSpan(text: " based in Pakistan, specialising in building exceptional digital experiences. With a strong foundation in modern frameworks and scalable architectures, I transform complex problems into elegant, performant solutions."),
            ],
          ),
        ).animate().fadeIn(duration: 600.ms).slideX(begin: -0.1, end: 0),
        const SizedBox(height: 24),
        const Text(
          "When I'm not coding, I'm exploring new cloud technologies, contributing to open-source projects, or writing technical articles to share knowledge with the community.",
          style: TextStyle(fontSize: 18, height: 1.8, color: AppColors.textMuted),
        ).animate().fadeIn(duration: 600.ms, delay: 200.ms),
        const SizedBox(height: 40),
        Row(
          children: [
            _buildActionBtn("Download CV", isPrimary: true),
            const SizedBox(width: 20),
            _buildActionBtn("Hire Me", isPrimary: false),
          ],
        ).animate().fadeIn(duration: 600.ms, delay: 400.ms),
      ],
    );
  }

  Widget _buildActionBtn(String text, {required bool isPrimary}) {
    return Container(
      decoration: isPrimary ? BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: const LinearGradient(colors: [AppColors.c1, AppColors.c2]),
      ) : null,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: isPrimary ? Colors.transparent : Colors.transparent,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 22),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: isPrimary ? BorderSide.none : const BorderSide(color: AppColors.c1, width: 1.5),
          ),
        ),
        child: Text(text, style: TextStyle(color: isPrimary ? Colors.white : AppColors.c1, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildHighlights(double screenWidth) {
    final highlights = [
      {'icon': FontAwesomeIcons.code, 'title': 'Clean Code', 'desc': 'Readable, maintainable, and well-structured code is a priority.', 'color': AppColors.c1},
      {'icon': FontAwesomeIcons.laptopCode, 'title': 'Modern Stack', 'desc': 'Proficient in MERN, ASP.NET Core, and cloud-native technologies.', 'color': AppColors.c3},
      {'icon': FontAwesomeIcons.cloudArrowUp, 'title': 'Cloud-Ready', 'desc': 'Experienced deploying scalable apps on AWS with Docker.', 'color': AppColors.c4},
      {'icon': FontAwesomeIcons.userCheck, 'title': 'User-Focused', 'desc': 'Every decision stems from empathy — fast and intuitive.', 'color': AppColors.c5},
    ];

    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 20,
      crossAxisSpacing: 20,
      childAspectRatio: 1.1,
      children: highlights.asMap().entries.map((e) => _buildAboutCard(e.value, e.key)).toList(),
    );
  }

  Widget _buildAboutCard(Map<String, dynamic> h, int i) {
    final color = h['color'] as Color;
    return GlassCard(
      opacity: 0.05,
      child: Stack(
        children: [
          Positioned(
            top: -30,
            right: -30,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(colors: [color.withOpacity(0.3), color.withOpacity(0)]),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(h['icon'] as IconData, color: color, size: 28),
                const SizedBox(height: 16),
                Text(h['title'] as String, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text(h['desc'] as String, style: const TextStyle(fontSize: 13, color: AppColors.textMuted, height: 1.5)),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 3,
              color: color.withOpacity(0.6),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: (i * 100).ms).slideY(begin: 0.2, end: 0);
  }
}

// --- Skills Section ---

class SkillsSection extends StatefulWidget {
  const SkillsSection({Key? key}) : super(key: key);
  @override
  State<SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends State<SkillsSection> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) => _startMarquee());
  }

  void _startMarquee() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: 30.seconds,
        curve: Curves.linear,
      ).then((_) {
        if (mounted) {
          _scrollController.jumpTo(0);
          _startMarquee();
        }
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 100.0),
      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.border))),
      child: Column(
        children: [
          const SectionHeader(title: 'Technical Skills'),
          const SizedBox(height: 40),
          _buildInfiniteMarquee(),
          const SizedBox(height: 80),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: isMobile ? 24 : 100),
            child: GridView.count(
              crossAxisCount: isMobile ? 1 : (screenWidth < 1100 ? 2 : 4),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 24,
              crossAxisSpacing: 24,
              childAspectRatio: isMobile ? 1.4 : 1.1,
              children: [
                _buildSkillCategory('Frontend', AppColors.c1, ['React.js', 'TypeScript', 'Tailwind CSS', 'HTML5 / CSS3', 'Framer Motion']),
                _buildSkillCategory('Backend', AppColors.c2, ['Node.js', 'Express.js', 'ASP.NET Core', 'C# / .NET', 'RESTful APIs']),
                _buildSkillCategory('Database & Cloud', AppColors.c3, ['MongoDB', 'SQL Server', 'AWS (EC2/S3)', 'Docker', 'CI/CD']),
                _buildSkillCategory('Tools & Other', AppColors.c5, ['Git & GitHub', 'Power BI', 'Python', 'Figma', 'Postman']),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfiniteMarquee() {
    final items = [
      {'name': 'C#', 'icon': FontAwesomeIcons.terminal, 'color': const Color(0xFF00A4EF)},
      {'name': 'ASP.NET', 'icon': FontAwesomeIcons.networkWired, 'color': const Color(0xFF512BD4)},
      {'name': 'React.js', 'icon': FontAwesomeIcons.react, 'color': const Color(0xFF61DAFB)},
      {'name': 'Node.js', 'icon': FontAwesomeIcons.nodeJs, 'color': const Color(0xFF339933)},
      {'name': 'MongoDB', 'icon': FontAwesomeIcons.database, 'color': const Color(0xFF47A248)},
      {'name': 'Docker', 'icon': FontAwesomeIcons.docker, 'color': const Color(0xFF2496ED)},
      {'name': 'AWS', 'icon': FontAwesomeIcons.aws, 'color': const Color(0xFFFF9900)},
      {'name': 'Python', 'icon': FontAwesomeIcons.python, 'color': const Color(0xFF3776AB)},
      {'name': 'Git', 'icon': FontAwesomeIcons.github, 'color': const Color(0xFFF05032)},
    ];

    return SizedBox(
      height: 160,
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final item = items[index % items.length];
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(item['icon'] as IconData, size: 64, color: (item['color'] as Color).withOpacity(0.6)).animate(onPlay: (c) => c.repeat(reverse: true)).moveY(begin: -5, end: 5, duration: 2.seconds),
                const SizedBox(height: 16),
                Text(item['name'] as String, style: const TextStyle(fontWeight: FontWeight.w800, color: AppColors.textDim, fontSize: 16)),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSkillCategory(String title, Color color, List<String> skills) {
    return GlassCard(
      opacity: 0.05,
      child: Stack(
        children: [
          Positioned(left: 0, top: 0, bottom: 0, child: Container(width: 4, decoration: BoxDecoration(color: color, borderRadius: const BorderRadius.horizontal(left: Radius.circular(18)), boxShadow: [BoxShadow(color: color, blurRadius: 10)]))),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
                    const SizedBox(width: 10),
                    Text(title, style: TextStyle(color: color, fontWeight: FontWeight.w900, fontSize: 16)),
                  ],
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: skills.map((s) => _buildSkillPill(s, color)).toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillPill(String name, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(color: color.withOpacity(0.08), borderRadius: BorderRadius.circular(20), border: Border.all(color: color.withOpacity(0.2))),
      child: Text(name, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white)),
    );
  }
}

// --- Projects Section ---

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({Key? key}) : super(key: key);
  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  String _filter = 'All';
  int _visibleCount = 8;

  @override
  Widget build(BuildContext context) {
    final filtered = ContentData.projects.where((p) {
      if (_filter == 'All') return true;
      if (_filter == 'Featured') return p.featured;
      return p.tech.any((t) => t.contains(_filter));
    }).toList();
    final displayed = filtered.take(_visibleCount).toList();

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 100.0, horizontal: 24),
      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.border))),
      child: Column(
        children: [
          const SectionHeader(title: 'Featured Projects'),
          const SizedBox(height: 48),
          _buildFilters(),
          const SizedBox(height: 48),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: displayed.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: MediaQuery.of(context).size.width < 800 ? 1 : (MediaQuery.of(context).size.width < 1200 ? 2 : 3),
              crossAxisSpacing: 24,
              mainAxisSpacing: 24,
              childAspectRatio: 0.88,
            ),
            itemBuilder: (context, i) => _buildProjectCard(displayed[i]),
          ),
          if (_visibleCount < filtered.length) ...[
            const SizedBox(height: 64),
            ElevatedButton(
              onPressed: () => setState(() => _visibleCount += 8),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.bgCard,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30), side: const BorderSide(color: AppColors.c1)),
              ),
              child: const Text("More Projects", style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildFilters() {
    final filters = ['All', 'Featured', 'MERN', 'React', '.NET', 'TypeScript'];
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: filters.map((f) => ChoiceChip(
        label: Text(f),
        selected: _filter == f,
        onSelected: (v) => setState(() {
          _filter = f;
          _visibleCount = 8;
        }),
        backgroundColor: AppColors.bgCard,
        selectedColor: AppColors.c1,
        labelStyle: TextStyle(color: _filter == f ? Colors.white : AppColors.textDim, fontWeight: FontWeight.bold),
      )).toList(),
    );
  }

  Widget _buildProjectCard(Project p) {
    return GlassCard(
      opacity: 0.05,
      child: Stack(
        children: [
          if (p.featured)
            Positioned(
              top: 12, right: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: AppColors.c1.withOpacity(0.2), borderRadius: BorderRadius.circular(20), border: Border.all(color: AppColors.c1)),
                child: const Row(children: [Icon(Icons.star, size: 10, color: AppColors.c1), SizedBox(width: 4), Text("Featured", style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: AppColors.c1))]),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(p.icon, color: AppColors.c1, size: 32),
                const SizedBox(height: 24),
                Text(p.title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                Text(p.desc, style: const TextStyle(color: AppColors.textMuted, fontSize: 14, height: 1.6), maxLines: 4, overflow: TextOverflow.ellipsis),
                const Spacer(),
                Wrap(spacing: 8, runSpacing: 8, children: p.tech.map((t) => Text(t, style: const TextStyle(fontSize: 11, color: AppColors.textDim, fontWeight: FontWeight.bold))).toList()),
                const SizedBox(height: 24),
                Row(
                  children: [
                    if (p.live.isNotEmpty) _buildCardLink(FontAwesomeIcons.arrowUpRightFromSquare, p.live),
                    const SizedBox(width: 12),
                    _buildCardLink(FontAwesomeIcons.github, p.code),
                  ],
                ),
              ],
            ),
          ),
          Positioned(top: 0, left: 0, right: 0, child: Container(height: 3, decoration: const BoxDecoration(gradient: LinearGradient(colors: [AppColors.c1, AppColors.c3])))),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms).scale(begin: const Offset(0.95, 0.95), end: const Offset(1, 1));
  }

  Widget _buildCardLink(IconData icon, String url) {
    return GestureDetector(
      onTap: () => launchUrl(Uri.parse(url)),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(color: Colors.white.withOpacity(0.04), borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.white.withOpacity(0.08))),
        child: Icon(icon, size: 16, color: Colors.white.withOpacity(0.8)),
      ),
    );
  }
}

// --- Experience Section ---

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 100.0, horizontal: isMobile ? 24 : 100),
      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.border))),
      child: Column(
        children: [
          const SectionHeader(title: 'Experience & Education'),
          const SizedBox(height: 64),
          Stack(
            children: [
              Positioned(left: 20, top: 0, bottom: 0, child: Container(width: 4, decoration: BoxDecoration(gradient: const LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [AppColors.c1, AppColors.c2, AppColors.c3]), borderRadius: BorderRadius.circular(4), boxShadow: [BoxShadow(color: AppColors.c2.withOpacity(0.3), blurRadius: 10)]))),
              Column(children: ContentData.experiences.asMap().entries.map((e) => _buildTimelineItem(e.value, e.key)).toList()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineItem(Experience exp, int i) {
    return Container(
      margin: const EdgeInsets.only(bottom: 48, left: 52),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(left: -80, top: 0, child: Container(width: 48, height: 48, decoration: BoxDecoration(shape: BoxShape.circle, gradient: const LinearGradient(colors: [AppColors.c1, AppColors.c2]), border: Border.all(color: AppColors.bg, width: 4), boxShadow: [BoxShadow(color: AppColors.c1.withOpacity(0.3), blurRadius: 10)]), child: Icon(exp.type == 'work' ? FontAwesomeIcons.briefcase : FontAwesomeIcons.graduationCap, size: 18, color: Colors.white))),
          GlassCard(
            opacity: 0.05,
            child: Padding(
              padding: const EdgeInsets.all(28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6), decoration: BoxDecoration(color: AppColors.c1.withOpacity(0.1), borderRadius: BorderRadius.circular(20), border: Border.all(color: AppColors.c1.withOpacity(0.3))), child: Text(exp.date, style: const TextStyle(color: AppColors.c1, fontSize: 12, fontWeight: FontWeight.bold, fontFamily: 'Fira Code'))),
                  const SizedBox(height: 16),
                  Text(exp.title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900)),
                  Text(exp.company, style: const TextStyle(fontSize: 16, color: AppColors.c3, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 16),
                  const Divider(color: AppColors.border),
                  const SizedBox(height: 8),
                  ...exp.bullets.map((b) => Padding(padding: const EdgeInsets.only(bottom: 10), child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text('▹ ', style: TextStyle(color: AppColors.c2, fontSize: 18)), Expanded(child: Text(b, style: const TextStyle(color: AppColors.textMuted, height: 1.5)))]))),
                ],
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: (i * 200).ms).slideX(begin: 0.1, end: 0);
  }
}

// --- Certifications Section ---

class CertificationsSection extends StatefulWidget {
  const CertificationsSection({Key? key}) : super(key: key);
  @override
  State<CertificationsSection> createState() => _CertificationsSectionState();
}

class _CertificationsSectionState extends State<CertificationsSection> {
  String _filter = 'All';
  String _search = '';

  @override
  Widget build(BuildContext context) {
    final filtered = ContentData.certs.where((c) {
      final mf = _filter == 'All' || c.category == _filter;
      final ms = c.title.toLowerCase().contains(_search.toLowerCase()) || c.issuer.toLowerCase().contains(_search.toLowerCase()) || c.skills.any((s) => s.toLowerCase().contains(_search.toLowerCase()));
      return mf && ms;
    }).toList();

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 100.0, horizontal: 24),
      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.border))),
      child: Column(
        children: [
          const SectionHeader(title: 'Licenses & Certifications'),
          const SizedBox(height: 32),
          _buildStatsBar(),
          const SizedBox(height: 40),
          _buildSearchBar(),
          const SizedBox(height: 32),
          _buildFilters(),
          const SizedBox(height: 48),
          GridView.builder(
            shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
            itemCount: filtered.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: MediaQuery.of(context).size.width < 800 ? 1 : (MediaQuery.of(context).size.width < 1200 ? 2 : 3),
              crossAxisSpacing: 24,
              mainAxisSpacing: 24,
              childAspectRatio: 0.9,
            ),
            itemBuilder: (context, i) => _buildCertCard(filtered[i]),
          ),
          if (filtered.isEmpty) const Padding(padding: EdgeInsets.only(top: 40), child: Text("No certifications match your search.", style: TextStyle(color: AppColors.textDim))),
        ],
      ),
    );
  }

  Widget _buildStatsBar() {
    return GlassCard(
      opacity: 0.05,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        child: Wrap(
          alignment: WrapAlignment.center,
          spacing: 40,
          runSpacing: 20,
          children: [
            _buildStat(ContentData.certs.length.toString(), 'Total Certs'),
            _buildStat('2', 'Issuers'),
            _buildStat('5', 'Categories'),
          ],
        ),
      ),
    );
  }

  Widget _buildStat(String n, String l) {
    return Column(children: [Text(n, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: AppColors.c1)), Text(l.toUpperCase(), style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.textDim, letterSpacing: 1))]);
  }

  Widget _buildSearchBar() {
    return Container(
      constraints: const BoxConstraints(maxWidth: 600),
      child: TextField(
        onChanged: (v) => setState(() => _search = v),
        style: const TextStyle(fontSize: 16),
        decoration: InputDecoration(
          hintText: "Search by name, issuer, or skill...",
          hintStyle: TextStyle(color: Colors.white.withOpacity(0.2)),
          prefixIcon: const Icon(Icons.search, color: AppColors.textDim),
          filled: true, fillColor: Colors.white.withOpacity(0.04),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.white.withOpacity(0.1))),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.c1)),
        ),
      ),
    );
  }

  Widget _buildFilters() {
    final filters = ['All', '.NET', 'React', 'DevOps', 'AI', 'Other'];
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: filters.map((f) => ChoiceChip(
        label: Text(f),
        selected: _filter == f,
        onSelected: (v) => setState(() => _filter = f),
        selectedColor: AppColors.c1,
        labelStyle: TextStyle(color: _filter == f ? Colors.white : AppColors.textDim, fontWeight: FontWeight.bold),
      )).toList(),
    );
  }

  Widget _buildCertCard(Certification c) {
    return GlassCard(
      opacity: 0.05,
      child: Stack(
        children: [
          Positioned(top: 0, left: 0, right: 0, child: Container(height: 4, color: c.color)),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(FontAwesomeIcons.award, color: c.color, size: 32),
                    Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: c.color.withOpacity(0.1), borderRadius: BorderRadius.circular(8), border: Border.all(color: c.color.withOpacity(0.3))), child: Text(c.category, style: TextStyle(color: c.color, fontSize: 10, fontWeight: FontWeight.bold))),
                  ],
                ),
                const SizedBox(height: 24),
                Text(c.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold), maxLines: 2, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 8),
                Text(c.issuer, style: const TextStyle(color: AppColors.textDim, fontWeight: FontWeight.w700)),
                const SizedBox(height: 16),
                Wrap(spacing: 6, runSpacing: 6, children: c.skills.map((s) => Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: c.color.withOpacity(0.08), borderRadius: BorderRadius.circular(6), border: Border.all(color: c.color.withOpacity(0.2))), child: Text(s, style: TextStyle(color: c.color, fontSize: 10, fontWeight: FontWeight.bold)))).toList()),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(c.date, style: const TextStyle(color: AppColors.textMuted, fontSize: 12, fontFamily: 'Fira Code')),
                    TextButton(onPressed: () => launchUrl(Uri.parse(c.link)), child: const Text("Show Credential →", style: TextStyle(fontWeight: FontWeight.bold))),
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

// --- Why Me Section ---

class WhyMeSection extends StatelessWidget {
  const WhyMeSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    final isTablet = screenWidth < 1200;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 100.0, horizontal: isMobile ? 24 : 100),
      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.border))),
      child: Column(
        children: [
          const SectionHeader(
            title: 'Why Work With Me?',
            subtitle: 'I bring more than just code — I bring commitment, craftsmanship, and a genuine passion for building things that matter.',
          ),
          const SizedBox(height: 64),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: ContentData.whyMeFeatures.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isMobile ? 1 : (isTablet ? 2 : 4),
              mainAxisSpacing: 24,
              crossAxisSpacing: 24,
              childAspectRatio: isMobile ? 1.6 : 1.1,
            ),
            itemBuilder: (context, index) => _buildFeatureCard(ContentData.whyMeFeatures[index]),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(WhyMeFeature f) {
    return GlassCard(
      opacity: 0.05,
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(f.icon, color: f.color, size: 32),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(color: f.color.withOpacity(0.1), borderRadius: BorderRadius.circular(8), border: Border.all(color: f.color.withOpacity(0.3))),
                  child: Text(f.tag, style: TextStyle(color: f.color, fontSize: 10, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(f.title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Expanded(child: Text(f.desc, style: const TextStyle(color: AppColors.textMuted, fontSize: 14, height: 1.6))),
            const SizedBox(height: 20),
            Container(height: 3, width: 48, decoration: BoxDecoration(color: f.color, borderRadius: BorderRadius.circular(2))),
          ],
        ),
      ),
    );
  }
}

// --- Blog Section ---

class BlogSection extends StatelessWidget {
  const BlogSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 100.0, horizontal: 24),
      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.border))),
      child: Column(
        children: [
          const SectionHeader(title: 'Insights & Articles'),
          const SizedBox(height: 64),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: ContentData.articles.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isMobile ? 1 : 2,
              crossAxisSpacing: 24,
              mainAxisSpacing: 24,
              childAspectRatio: isMobile ? 1.4 : 1.6,
            ),
            itemBuilder: (context, i) => _buildBlogCard(ContentData.articles[i]),
          ),
        ],
      ),
    );
  }

  Widget _buildBlogCard(BlogArticle a) {
    return GlassCard(
      opacity: 0.08,
      child: Stack(
        children: [
          Positioned(top: 0, left: 0, right: 0, child: Container(height: 4, color: a.color)),
          Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: a.color.withOpacity(0.1), borderRadius: BorderRadius.circular(8)), child: Text(a.tag, style: TextStyle(color: a.color, fontSize: 10, fontWeight: FontWeight.bold))),
                const SizedBox(height: 20),
                Text(a.title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900)),
                const SizedBox(height: 12),
                Text(a.desc, style: const TextStyle(color: AppColors.textMuted, fontSize: 15, height: 1.6), maxLines: 2, overflow: TextOverflow.ellipsis),
                const Spacer(),
                Row(
                  children: [
                    const Icon(Icons.access_time, size: 14, color: AppColors.textDim),
                    const SizedBox(width: 6),
                    Text(a.readTime, style: const TextStyle(color: AppColors.textDim, fontSize: 12, fontWeight: FontWeight.bold)),
                    const Spacer(),
                    TextButton.icon(
                      onPressed: () => launchUrl(Uri.parse(a.link)),
                      icon: const Text("Read More"),
                      label: const Icon(Icons.arrow_forward, size: 16),
                      style: TextButton.styleFrom(foregroundColor: a.color, textStyle: const TextStyle(fontWeight: FontWeight.bold)),
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

// --- Contact Section ---

class ContactSection extends StatefulWidget {
  const ContactSection({Key? key}) : super(key: key);
  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _formKey = GlobalKey<FormState>();
  bool _isSending = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 1000;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 100.0, horizontal: isMobile ? 24 : 100),
      child: Column(
        children: [
          const SectionHeader(title: 'Get In Touch', subtitle: "I'm currently open to new opportunities. Whether you have a question or just want to say hi, I'll try my best to get back to you!"),
          const SizedBox(height: 80),
          if (isMobile)
            Column(children: [_buildContactInfo(), const SizedBox(height: 60), _buildContactForm()])
          else
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 1, child: _buildContactInfo()),
                const SizedBox(width: 80),
                Expanded(flex: 1, child: _buildContactForm()),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildContactInfo() {
    final socials = [
      {'label': 'Email', 'text': 'farmanullahansari999@gmail.com', 'icon': FontAwesomeIcons.envelope, 'url': 'mailto:farmanullahansari999@gmail.com'},
      {'label': 'LinkedIn', 'text': 'linkedin.com/in/farmanullah-ansari', 'icon': FontAwesomeIcons.linkedin, 'url': 'https://www.linkedin.com/in/farmanullah-ansari'},
      {'label': 'GitHub', 'text': 'github.com/farmanullah1', 'icon': FontAwesomeIcons.github, 'url': 'https://github.com/farmanullah1'},
      {'label': 'Twitter', 'text': '@farmanullah9088', 'icon': FontAwesomeIcons.twitter, 'url': 'https://x.com/farmanullah9088'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Let's build something amazing together", style: TextStyle(fontSize: 36, fontWeight: FontWeight.w900, height: 1.2, color: Colors.white)),
        const SizedBox(height: 24),
        const Text("Whether you have a project idea, a job opportunity, or just want to say hello — my inbox is always open. I'm especially interested in large-scale MERN or ASP.NET projects.", style: TextStyle(color: AppColors.textMuted, fontSize: 16, height: 1.8)),
        const SizedBox(height: 48),
        ...socials.map((s) => _buildSocialRow(s)).toList(),
        const SizedBox(height: 48),
        Row(children: [const Icon(FontAwesomeIcons.locationDot, size: 16, color: AppColors.c1), const SizedBox(width: 12), const Text("Sindh, Pakistan — Open to remote worldwide", style: TextStyle(color: AppColors.textDim, fontWeight: FontWeight.bold))]),
      ],
    );
  }

  Widget _buildSocialRow(Map<String, dynamic> s) {
    return GestureDetector(
      onTap: () => launchUrl(Uri.parse(s['url'])),
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(color: AppColors.bgCard, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.border)),
        child: Row(
          children: [
            Container(width: 48, height: 48, decoration: BoxDecoration(gradient: const LinearGradient(colors: [AppColors.c1, AppColors.c2]), borderRadius: BorderRadius.circular(12)), child: Icon(s['icon'] as IconData, color: Colors.white, size: 20)),
            const SizedBox(width: 20),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(s['label'] as String, style: const TextStyle(color: AppColors.textDim, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1)), const SizedBox(height: 4), Text(s['text'] as String, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800))]),
          ],
        ),
      )).animate().fadeIn(duration: 400.ms).slideX(begin: -0.05, end: 0);
  }

  Widget _buildContactForm() {
    return Form(
      key: _formKey,
      child: GlassCard(
        opacity: 0.1,
        child: Padding(
          padding: const EdgeInsets.all(48),
          child: Column(
            children: [
              _buildField("Your Name", "John Doe"),
              const SizedBox(height: 28),
              _buildField("Email Address", "john@example.com"),
              const SizedBox(height: 28),
              _buildField("Subject", "Project Inquiry"),
              const SizedBox(height: 28),
              _buildField("Message", "Tell me about your project...", maxLines: 6),
              const SizedBox(height: 48),
              _buildSubmitBtn(),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(duration: 600.ms, delay: 200.ms);
  }

  Widget _buildField(String label, String hint, {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label.toUpperCase(), style: const TextStyle(color: AppColors.textDim, fontWeight: FontWeight.bold, fontSize: 11, letterSpacing: 1.2)),
        const SizedBox(height: 12),
        TextFormField(
          maxLines: maxLines,
          style: const TextStyle(fontSize: 16),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.white.withOpacity(0.15)),
            filled: true, fillColor: Colors.white.withOpacity(0.03),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.white.withOpacity(0.1))),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.c1, width: 2)),
            contentPadding: const EdgeInsets.all(20),
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitBtn() {
    return Container(
      width: double.infinity,
      height: 64,
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [AppColors.c1, AppColors.c2]),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: AppColors.c1.withOpacity(0.4), blurRadius: 20, offset: const Offset(0, 8))],
      ),
      child: ElevatedButton(
        onPressed: () {
          setState(() => _isSending = true);
          Future.delayed(2.seconds, () => setState(() {
            _isSending = false;
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Message sent successfully!")));
          }));
        },
        style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, shadowColor: Colors.transparent, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
        child: Text(_isSending ? "Sending..." : "Send Message", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Colors.white, letterSpacing: 1)),
      ),
    );
  }
}

// --- Footer Section ---

class FooterSection extends StatelessWidget {
  const FooterSection({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 800;

    return Container(
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.border)),
        gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0x1A000000), Color(0x7305010E)]),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 80, horizontal: isMobile ? 24 : 100),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShaderMask(
                        shaderCallback: (bounds) => const LinearGradient(colors: [AppColors.c1, AppColors.c3]).createShader(bounds),
                        child: const Text('Farmanullah.', style: TextStyle(fontSize: 36, fontWeight: FontWeight.w900, color: Colors.white, letterSpacing: -1.5)),
                      ),
                      const SizedBox(height: 16),
                      const Text('Full-Stack Software Engineer building exceptional digital experiences with modern technology.', style: TextStyle(color: AppColors.textDim, fontSize: 15, height: 1.6), maxLines: 3),
                      const SizedBox(height: 40),
                      _buildSocialIcons(),
                    ],
                  ),
                ),
                if (!isMobile) ...[
                  const SizedBox(width: 60),
                  _buildFooterGroup('Explore', ['About', 'Skills', 'Projects', 'Experience']),
                  const SizedBox(width: 40),
                  _buildFooterGroup('Legal', ['Privacy Policy', 'Terms of Service', 'Cookie Policy']),
                  const SizedBox(width: 40),
                  _buildFooterGroup('Connect', ['LinkedIn', 'GitHub', 'Twitter', 'Email']),
                ],
              ],
            ),
          ),
          const Divider(color: AppColors.border),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('© ${DateTime.now().year} Farmanullah Ansari. Crafted with passion.', style: const TextStyle(color: AppColors.textDim, fontSize: 13)),
                Row(children: [const Icon(FontAwesomeIcons.solidHeart, color: AppColors.c1, size: 12), const SizedBox(width: 8), const Text('Back to top ↑', style: TextStyle(color: AppColors.textDim, fontSize: 13, fontWeight: FontWeight.w800))]),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialIcons() {
    final icons = [
      {'icon': FontAwesomeIcons.github, 'url': 'https://github.com/farmanullah1'},
      {'icon': FontAwesomeIcons.linkedin, 'url': 'https://linkedin.com/in/farmanullah-ansari'},
      {'icon': FontAwesomeIcons.twitter, 'url': 'https://x.com/farmanullah9088'},
    ];
    return Row(
      children: icons.map((s) => Container(
        margin: const EdgeInsets.only(right: 16),
        child: IconButton(
          onPressed: () => launchUrl(Uri.parse(s['url'] as String)),
          icon: Icon(s['icon'] as IconData, size: 18, color: AppColors.textMuted),
          style: IconButton.styleFrom(
            backgroundColor: AppColors.bgCard,
            padding: const EdgeInsets.all(12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: const BorderSide(color: AppColors.border)),
          ),
        ),
      )).toList(),
    );
  }

  Widget _buildFooterGroup(String t, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(t.toUpperCase(), style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: Colors.white, letterSpacing: 1.5, fontFamily: 'Fira Code')),
        const SizedBox(height: 28),
        ...items.map((i) => Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Text(i, style: const TextStyle(color: AppColors.textDim, fontSize: 14, fontWeight: FontWeight.w600)),
        )),
      ],
    );
  }
}
