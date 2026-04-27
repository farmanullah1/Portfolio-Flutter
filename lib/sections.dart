import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';
import 'models.dart';
import 'theme.dart';

// --- Shared Widgets ---

class GlassCard extends StatelessWidget {
  final Widget child;
  final double blur;
  final double opacity;
  final BorderRadius? borderRadius;
  final Border? border;
  final Color? color;

  const GlassCard({
    Key? key,
    required this.child,
    this.blur = 18.0,
    this.opacity = 0.035,
    this.borderRadius,
    this.border,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(18),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          decoration: BoxDecoration(
            color: color ?? Colors.white.withOpacity(opacity),
            borderRadius: borderRadius ?? BorderRadius.circular(18),
            border: border ?? Border.all(color: Colors.white.withOpacity(0.065)),
          ),
          child: child,
        ),
      ),
    );
  }
}

class PortfolioBackground extends StatelessWidget {
  const PortfolioBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Orbs
        _buildOrb(
          color: const Color(0x7A7C3AED), // rgba(124,58,237,.48)
          size: 800,
          top: -200,
          right: -200,
          duration: 14.seconds,
        ),
        _buildOrb(
          color: const Color(0x66E040FB), // rgba(224,64,251,.4)
          size: 700,
          bottom: -150,
          left: -100,
          duration: 16.seconds,
          reverse: true,
        ),
        _buildOrb(
          color: const Color(0x4700E5FF), // rgba(0,229,255,.28)
          size: 420,
          top: 0.45,
          left: 0.35,
          duration: 22.seconds,
        ),
        // Grid
        Opacity(
          opacity: 0.06,
          child: CustomPaint(
            painter: GridPainter(),
            child: Container(),
          ),
        ),
      ],
    );
  }

  Widget _buildOrb({
    required Color color,
    required double size,
    double? top,
    double? left,
    double? right,
    double? bottom,
    required Duration duration,
    bool reverse = false,
  }) {
    return Positioned(
      top: top,
      left: left,
      right: right,
      bottom: bottom,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [color, Colors.transparent],
            stops: const [0.0, 0.65],
          ),
        ),
      ).animate(onPlay: (controller) => controller.repeat(reverse: true)).move(
            begin: const Offset(0, 0),
            end: reverse ? const Offset(-40, 50) : const Offset(55, -40),
            duration: duration,
            curve: Curves.easeInOut,
          ).scale(
            begin: const Offset(1, 1),
            end: const Offset(1.15, 1.15),
            duration: duration,
            curve: Curves.easeInOut,
          ),
    );
  }
}

class GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFaa50ff).withOpacity(1.0)
      ..strokeWidth = 1;

    const double spacing = 60.0;

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

// --- Section Header ---

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
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 48, fontWeight: FontWeight.w900, letterSpacing: -1, height: 1.1),
        ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.5, end: 0),
        const SizedBox(height: 14),
        Container(
          width: 56,
          height: 4,
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [AppColors.c1, AppColors.c2]),
            borderRadius: BorderRadius.circular(4),
            boxShadow: const [BoxShadow(color: AppColors.c1, blurRadius: 14)],
          ),
        ).animate().scaleX(begin: 0, end: 1, duration: 600.ms),
        if (subtitle != null) ...[
          const SizedBox(height: 24),
          Text(
            subtitle!,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16, color: AppColors.textMuted, height: 1.6),
          ).animate().fadeIn(delay: 200.ms),
        ],
      ],
    );
  }
}

// --- Hero Section ---

class HeroSection extends StatefulWidget {
  const HeroSection({Key? key}) : super(key: key);

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> {
  static const List<String> _roles = [
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
    'Cross-Platform Solutions Developer',
    'Open Source Contributor',
    'Logic & Game Engine Developer'
  ];

  int _roleIndex = 0;
  String _currentText = '';
  bool _isDeleting = false;
  late Duration _typingSpeed;

  @override
  void initState() {
    super.initState();
    _typingSpeed = const Duration(milliseconds: 58);
    _type();
  }

  void _type() {
    if (!mounted) return;

    final fullText = _roles[_roleIndex];

    setState(() {
      if (_isDeleting) {
        if (_currentText.isNotEmpty) {
          _currentText = fullText.substring(0, _currentText.length - 1);
          _typingSpeed = const Duration(milliseconds: 32);
        }
      } else {
        if (_currentText.length < fullText.length) {
          _currentText = fullText.substring(0, _currentText.length + 1);
          _typingSpeed = const Duration(milliseconds: 58);
        }
      }
    });

    if (!_isDeleting && _currentText == fullText) {
      _typingSpeed = const Duration(milliseconds: 1900);
      _isDeleting = true;
    } else if (_isDeleting && _currentText == '') {
      _isDeleting = false;
      _roleIndex = (_roleIndex + 1) % _roles.length;
      _typingSpeed = const Duration(milliseconds: 500);
    }

    Future.delayed(_typingSpeed, _type);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 900;

    return Stack(
      children: [
        const PortfolioBackground(),
        Container(
          constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height),
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 24.0 : 100.0,
            vertical: 80.0,
          ),
          child: Column(
            children: [
              const SizedBox(height: 60),
              if (isMobile)
                _buildHeroContent(context, true)
              else
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(child: _buildHeroContent(context, false)),
                    const SizedBox(width: 80),
                    _buildHeroImage(context),
                  ],
                ),
              if (isMobile) ...[
                const SizedBox(height: 60),
                _buildHeroImage(context),
              ],
              const SizedBox(height: 40),
              _buildScrollCue(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHeroContent(BuildContext context, bool centered) {
    final alignment = centered ? CrossAxisAlignment.center : CrossAxisAlignment.start;
    final textAlign = centered ? TextAlign.center : TextAlign.start;

    return Column(
      crossAxisAlignment: alignment,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 9),
          decoration: BoxDecoration(
            color: AppColors.c1.withOpacity(0.12),
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: AppColors.c1.withOpacity(0.38)),
            boxShadow: [
              BoxShadow(color: AppColors.c1.withOpacity(0.1), blurRadius: 22),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildBlinkDot(),
              const SizedBox(width: 10),
              const Text(
                'Available for new opportunities',
                style: TextStyle(
                  color: AppColors.c1,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.5, end: 0),
        const SizedBox(height: 28),
        Text(
          'Hi, I\'m',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: AppColors.textMuted,
          ),
        ).animate().fadeIn(delay: 200.ms),
        const SizedBox(height: 6),
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [AppColors.c1, AppColors.c2, AppColors.c3, AppColors.c4, AppColors.c1],
          ).createShader(bounds),
          child: Text(
            'Farmanullah Ansari',
            style: TextStyle(
              fontSize: centered ? 48 : 72,
              fontWeight: FontWeight.w900,
              height: 1.0,
              letterSpacing: -2.0,
              color: Colors.white,
            ),
          ),
        ).animate().fadeIn(delay: 400.ms).slideY(),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: centered ? MainAxisAlignment.center : MainAxisAlignment.start,
          children: [
            const Text(
              'I\'m a ',
              style: TextStyle(fontSize: 20, color: AppColors.textMuted),
            ),
            Text(
              _currentText,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: AppColors.c3,
                shadows: [Shadow(color: AppColors.c3, blurRadius: 20)],
              ),
            ),
            _buildTypingCursor(),
          ],
        ).animate().fadeIn(delay: 600.ms),
        const SizedBox(height: 32),
        Text(
          'I engineer dynamic, user-friendly, and scalable web applications. Passionate about the MERN stack, ASP.NET Core, cloud computing, and building seamless digital experiences.',
          textAlign: textAlign,
          style: const TextStyle(
            fontSize: 16,
            height: 1.8,
            color: AppColors.textMuted,
          ),
        ).animate().fadeIn(delay: 800.ms),
        const SizedBox(height: 38),
        Wrap(
          spacing: 24,
          runSpacing: 24,
          alignment: centered ? WrapAlignment.center : WrapAlignment.start,
          children: [
            _buildStat('3+', 'Years Coding'),
            _buildStat('10+', 'Projects Built'),
            _buildStat('10+', 'Certifications'),
          ],
        ).animate().fadeIn(delay: 900.ms),
        const SizedBox(height: 40),
        Wrap(
          spacing: 14,
          runSpacing: 14,
          alignment: centered ? WrapAlignment.center : WrapAlignment.start,
          children: [
            _buildButton('Hire Me', Icons.mail, true),
            _buildButton('Download CV', Icons.download, false),
          ],
        ).animate().fadeIn(delay: 1000.ms),
        const SizedBox(height: 28),
        Row(
          mainAxisAlignment: centered ? MainAxisAlignment.center : MainAxisAlignment.start,
          children: [
            _buildSocialLink(FontAwesomeIcons.github, 'https://github.com/farmanullah1'),
            const SizedBox(width: 10),
            _buildSocialLink(FontAwesomeIcons.linkedin, 'https://www.linkedin.com/in/farmanullah-ansari'),
            const SizedBox(width: 16),
            const Text(
              'Let\'s connect',
              style: TextStyle(color: AppColors.textDim, fontWeight: FontWeight.w600, fontSize: 14),
            ),
          ],
        ).animate().fadeIn(delay: 1100.ms),
      ],
    );
  }

  Widget _buildBlinkDot() {
    return Container(
      width: 9,
      height: 9,
      decoration: const BoxDecoration(color: AppColors.c3, shape: BoxShape.circle),
    ).animate(onPlay: (controller) => controller.repeat()).scale(
          begin: const Offset(1, 1),
          end: const Offset(1.5, 1.5),
          duration: 1.6.seconds,
          curve: Curves.easeInOut,
        ).custom(
          builder: (context, value, child) => Opacity(
            opacity: 1.0 - (value * 0.6),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(color: AppColors.c3.withOpacity(0.6), spreadRadius: value * 10),
                ],
              ),
            ),
          ),
        );
  }

  Widget _buildTypingCursor() {
    return Container(
      width: 2,
      height: 24,
      margin: const EdgeInsets.only(left: 2),
      decoration: BoxDecoration(
        color: AppColors.c3,
        borderRadius: BorderRadius.circular(2),
        boxShadow: const [BoxShadow(color: AppColors.c3, blurRadius: 8)],
      ),
    ).animate(onPlay: (controller) => controller.repeat()).fadeOut(duration: 425.ms);
  }

  Widget _buildStat(String num, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [AppColors.c1, AppColors.c2, AppColors.c3],
          ).createShader(bounds),
          child: Text(
            num,
            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: Colors.white),
          ),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.textDim, letterSpacing: 1),
        ),
      ],
    );
  }

  Widget _buildButton(String label, IconData icon, bool primary) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: primary ? const LinearGradient(colors: [AppColors.c1, AppColors.c2]) : null,
        boxShadow: primary ? [const BoxShadow(color: AppColors.c1, blurRadius: 22, offset: Offset(0, 4))] : null,
        border: !primary ? Border.all(color: AppColors.c1.withOpacity(0.45), width: 1.5) : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 13),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 18, color: primary ? Colors.white : AppColors.c1),
                const SizedBox(width: 9),
                Text(
                  label,
                  style: TextStyle(
                    color: primary ? Colors.white : AppColors.c1,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSocialLink(IconData icon, String url) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: AppColors.bgCard,
        borderRadius: BorderRadius.circular(13),
        border: Border.all(color: AppColors.border),
      ),
      child: IconButton(
        icon: Icon(icon, color: AppColors.textMuted, size: 20),
        onPressed: () => launchUrl(Uri.parse(url)),
      ),
    );
  }

  Widget _buildHeroImage(BuildContext context) {
    return SizedBox(
      width: 460,
      height: 460,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          _buildRing(
            size: 480,
            dashed: true,
            color: AppColors.c2.withOpacity(0.38),
            duration: 24.seconds,
          ),
          _buildRing(
            size: 470,
            glow: true,
            duration: 8.seconds,
            reverse: true,
          ),
          _buildRing(
            size: 465,
            pulse: true,
            color: AppColors.c1.withOpacity(0.22),
            duration: 3.seconds,
          ),
          Container(
            width: 320,
            height: 320,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.c2, width: 2),
              boxShadow: [
                BoxShadow(color: AppColors.c2.withOpacity(0.35), blurRadius: 55),
                BoxShadow(color: AppColors.c1.withOpacity(0.15), blurRadius: 110),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(160),
              child: Image.asset('assets/profile2.webp', fit: BoxFit.cover),
            ),
          ),
          ..._buildFloatingBadges(),
        ],
      ),
    );
  }

  Widget _buildRing({
    required double size,
    bool dashed = false,
    bool glow = false,
    bool pulse = false,
    Color? color,
    required Duration duration,
    bool reverse = false,
  }) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(shape: BoxShape.circle),
      child: dashed
          ? CustomPaint(painter: DashedRingPainter(color: color!))
          : glow
              ? Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: SweepGradient(
                      colors: [AppColors.c1, AppColors.c2, AppColors.c3, AppColors.c4, AppColors.c1],
                    ),
                  ),
                ).animate(onPlay: (c) => c.repeat()).rotate(duration: duration, begin: 0, end: reverse ? -1 : 1).blur(begin: const Offset(18, 18), end: const Offset(18, 18))
              : pulse
                  ? Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: color!, width: 2),
                      ),
                    ).animate(onPlay: (c) => c.repeat()).scale(begin: const Offset(1, 1), end: const Offset(1.04, 1.04), duration: duration, curve: Curves.easeInOut).fadeOut(duration: duration)
                  : const SizedBox(),
    ).animate(onPlay: (c) => c.repeat()).rotate(duration: duration, begin: 0, end: reverse ? -1 : 1);
  }

  List<Widget> _buildFloatingBadges() {
    final badges = [
      {'text': 'React.js', 'icon': SiReactIcon(), 'top': -0.12, 'left': 0.34},
      {'text': 'Node.js', 'icon': SiNodedotjsIcon(), 'top': -0.02, 'left': 0.72},
      {'text': 'AWS', 'icon': FaAwsIcon(), 'top': 0.22, 'left': 0.95},
      {'text': 'TypeScript', 'icon': SiTypescriptIcon(), 'top': 0.52, 'left': 1.02},
      {'text': 'C# / .NET', 'icon': SiDotnetIcon(), 'top': 0.82, 'left': 0.82},
      {'text': 'ASP.NET Core', 'icon': SiDotnetIcon(), 'top': 1.02, 'left': 0.54},
      {'text': 'Docker', 'icon': SiDockerIcon(), 'top': 1.02, 'right': 0.54},
      {'text': 'Linux', 'icon': SiLinuxIcon(), 'top': 0.82, 'right': 0.82},
      {'text': 'Git & GitHub', 'icon': SiGithubIcon(), 'top': 0.52, 'right': 1.02},
      {'text': 'Power BI', 'icon': FaChartBarIcon(), 'top': 0.22, 'right': 0.95},
      {'text': 'Python', 'icon': SiPythonIcon(), 'top': -0.02, 'right': 0.72},
    ];

    return badges.map((b) {
      return _buildFloatingBadge(
        b['text'] as String,
        b['icon'] as Widget,
        top: b['top'] as double?,
        left: b['left'] as double?,
        right: b['right'] as double?,
        bottom: b['bottom'] as double?,
      );
    }).toList();
  }

  Widget _buildFloatingBadge(String text, Widget icon, {double? top, double? left, double? right, double? bottom}) {
    return Positioned(
      top: top != null ? 320 * top + 160 : null,
      left: left != null ? 320 * left + 160 : null,
      right: right != null ? 320 * right + 160 : null,
      bottom: bottom != null ? 320 * bottom + 160 : null,
      child: GlassCard(
        blur: 18,
        opacity: 0.82,
        color: const Color(0xD10F0724),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: const Color(0x52AA64FF)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              icon,
              const SizedBox(width: 8),
              Text(
                text,
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ],
          ),
        ),
      ).animate(onPlay: (c) => c.repeat(reverse: true)).moveY(begin: -10, end: 10, duration: (3 + (text.length % 3)).seconds),
    );
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
            border: Border.all(color: const Color(0x73AA50FF)),
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

class DashedRingPainter extends CustomPainter {
  final Color color;
  DashedRingPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    const double dashWidth = 10, dashSpace = 5;
    double currentAngle = 0;
    final double radius = size.width / 2;

    while (currentAngle < 2 * 3.14159) {
      canvas.drawArc(
        Rect.fromCircle(center: Offset(radius, radius), radius: radius),
        currentAngle,
        dashWidth / radius,
        false,
        paint,
      );
      currentAngle += (dashWidth + dashSpace) / radius;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

// --- Icons ---
Widget SiReactIcon() => const Icon(FontAwesomeIcons.react, color: Color(0xFF61DAFB), size: 16);
Widget SiNodedotjsIcon() => const Icon(FontAwesomeIcons.nodeJs, color: Color(0xFF339933), size: 16);
Widget FaAwsIcon() => const Icon(FontAwesomeIcons.aws, color: Color(0xFFFF9900), size: 16);
Widget SiTypescriptIcon() => const Text('TS', style: TextStyle(color: Color(0xFF3178C6), fontWeight: FontWeight.bold, fontSize: 12));
Widget SiDotnetIcon() => const Icon(FontAwesomeIcons.microsoft, color: Color(0xFF512BD4), size: 16);
Widget SiDockerIcon() => const Icon(FontAwesomeIcons.docker, color: Color(0xFF2496ED), size: 16);
Widget SiLinuxIcon() => const Icon(FontAwesomeIcons.linux, color: Color(0xFFFCC624), size: 16);
Widget SiGithubIcon() => const Icon(FontAwesomeIcons.github, color: Colors.white, size: 16);
Widget FaChartBarIcon() => const Icon(FontAwesomeIcons.chartBar, color: Color(0xFFF2C811), size: 16);
Widget SiPythonIcon() => const Icon(FontAwesomeIcons.python, color: Color(0xFF3776AB), size: 16);

// --- About Section ---
class AboutSection extends StatelessWidget {
  const AboutSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 900;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 24.0 : 100.0, vertical: 80.0),
      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.border))),
      child: Column(
        children: [
          const SectionHeader(title: 'About Me'),
          const SizedBox(height: 40),
          if (isMobile)
            Column(children: [_buildText(), const SizedBox(height: 40), _buildGrid(context)])
          else
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _buildText()),
                const SizedBox(width: 72),
                Expanded(child: _buildGrid(context)),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'I\'m a passionate Full-Stack Software Engineer based in Pakistan, specialising in building exceptional digital experiences.',
          style: TextStyle(fontSize: 17, height: 1.88, color: AppColors.textMuted),
        ),
        const SizedBox(height: 20),
        const Text(
          'When I\'m not coding, I\'m exploring new cloud technologies, contributing to open-source projects, or writing technical articles.',
          style: TextStyle(fontSize: 17, height: 1.88, color: AppColors.textMuted),
        ),
        const SizedBox(height: 28),
        Row(
          children: [
            _buildButtonSmall('Hire Me', true),
            const SizedBox(width: 16),
            _buildButtonSmall('Download CV', false),
          ],
        ),
      ],
    );
  }

  Widget _buildButtonSmall(String label, bool primary) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: primary ? const LinearGradient(colors: [AppColors.c1, AppColors.c2]) : null,
        border: !primary ? Border.all(color: AppColors.c1.withOpacity(0.45)) : null,
      ),
      child: Text(
        label,
        style: TextStyle(color: primary ? Colors.white : AppColors.c1, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildGrid(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 18,
      crossAxisSpacing: 18,
      childAspectRatio: 1.2,
      children: [
        _buildAboutCard('Clean Code', 'Readable, maintainable, and well-structured code is a priority.', Icons.code, AppColors.c1),
        _buildAboutCard('Modern Stack', 'Proficient in MERN, ASP.NET Core, and cloud technologies.', Icons.laptop, AppColors.c3),
        _buildAboutCard('Security First', 'JWT auth, data encryption, and secure REST APIs.', Icons.shield, AppColors.c4),
        _buildAboutCard('Adaptable', 'Adapting seamlessly to unique project requirements.', Icons.sync, AppColors.c5),
      ],
    );
  }

  Widget _buildAboutCard(String title, String desc, IconData icon, Color accent) {
    return GlassCard(
      opacity: 0.05,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: accent, size: 28),
            const SizedBox(height: 12),
            Text(title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
            const SizedBox(height: 8),
            Text(desc, style: const TextStyle(color: AppColors.textMuted, fontSize: 12, height: 1.6)),
          ],
        ),
      ),
    );
  }
}

// --- Skills Section ---
class SkillsSection extends StatelessWidget {
  const SkillsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80.0),
      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.border))),
      child: Column(
        children: [
          const SectionHeader(title: 'Technical Skills'),
          const SizedBox(height: 40),
          _buildMarquee(),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Wrap(
              spacing: 22,
              runSpacing: 22,
              alignment: WrapAlignment.center,
              children: [
                _buildSkillCategory('Frontend', AppColors.c1, ['React.js', 'TypeScript', 'Tailwind CSS', 'Framer Motion', 'Flutter']),
                _buildSkillCategory('Backend', AppColors.c2, ['Node.js', 'Express.js', 'ASP.NET Core', 'C#', 'REST APIs', 'Socket.io']),
                _buildSkillCategory('Database & Cloud', AppColors.c3, ['MongoDB', 'SQL Server', 'AWS EC2 / EB', 'Docker', 'Linux', 'Firebase']),
                _buildSkillCategory('Tools & Other', AppColors.c5, ['Git & GitHub', 'Power BI', 'Python', 'Figma', 'Postman', 'Unit Testing']),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMarquee() {
    final skills = [
      {'name': 'React', 'icon': FontAwesomeIcons.react},
      {'name': 'Node.js', 'icon': FontAwesomeIcons.nodeJs},
      {'name': 'AWS', 'icon': FontAwesomeIcons.aws},
      {'name': 'Flutter', 'icon': Icons.flutter_dash},
      {'name': 'Docker', 'icon': FontAwesomeIcons.docker},
      {'name': 'Python', 'icon': FontAwesomeIcons.python},
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(20, (index) {
          final skill = skills[index % skills.length];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                Icon(skill['icon'] as IconData, size: 60, color: AppColors.c1),
                const SizedBox(height: 10),
                Text(skill['name'] as String, style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          );
        }),
      ),
    ).animate(onPlay: (c) => c.repeat()).moveX(begin: 0, end: -200, duration: 10.seconds);
  }

  Widget _buildSkillCategory(String title, Color color, List<String> skills) {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.bgCard,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(width: 11, height: 11, decoration: BoxDecoration(color: color, shape: BoxShape.circle, boxShadow: [BoxShadow(color: color, blurRadius: 10)])),
              const SizedBox(width: 10),
              Text(title, style: TextStyle(color: color, fontWeight: FontWeight.w800)),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: skills.map((s) => _buildSkillPill(s, color)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillPill(String name, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
      decoration: BoxDecoration(
        color: color.withOpacity(0.04),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(name, style: const TextStyle(color: AppColors.textMuted, fontSize: 13, fontWeight: FontWeight.w600)),
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

  @override
  Widget build(BuildContext context) {
    final filteredProjects = _filter == 'All' 
        ? ContentData.projects 
        : ContentData.projects.where((p) => p.category == _filter).toList();

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80.0, horizontal: 24),
      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.border))),
      child: Column(
        children: [
          const SectionHeader(title: 'Featured Projects'),
          const SizedBox(height: 44),
          _buildFilterRow(),
          const SizedBox(height: 44),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: filteredProjects.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 26),
                child: _buildProjectCard(filteredProjects[index]),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFilterRow() {
    final filters = ['All', 'MERN Stack', 'ASP.NET Core', 'React'];
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: filters.map((f) => _buildFilterBtn(f, _filter == f)).toList(),
    );
  }

  Widget _buildFilterBtn(String label, bool active) {
    return GestureDetector(
      onTap: () => setState(() => _filter = label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
        decoration: BoxDecoration(
          gradient: active ? const LinearGradient(colors: [AppColors.c1, AppColors.c2]) : null,
          border: !active ? Border.all(color: const Color(0x59AA64FF)) : null,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(label, style: TextStyle(color: active ? Colors.white : AppColors.textDim, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildProjectCard(Project p) {
    return GlassCard(
      opacity: 0.1,
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (p.featured)
              Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: AppColors.c1.withOpacity(0.2), borderRadius: BorderRadius.circular(8)),
                child: const Text('Featured Project', style: TextStyle(color: AppColors.c1, fontSize: 10, fontWeight: FontWeight.bold)),
              ),
            Icon(p.icon, size: 32, color: AppColors.c2),
            const SizedBox(height: 16),
            Text(p.title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(p.desc, style: const TextStyle(color: AppColors.textMuted, height: 1.5)),
            const SizedBox(height: 24),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: p.tech.map((t) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: AppColors.c2.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                child: Text(t, style: const TextStyle(color: AppColors.c2, fontSize: 11)),
              )).toList(),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                _buildIconBtn(Icons.open_in_new, () => launchUrl(Uri.parse(p.live))),
                const SizedBox(width: 12),
                _buildIconBtn(FontAwesomeIcons.github, () => launchUrl(Uri.parse(p.code))),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconBtn(IconData icon, VoidCallback onTap) {
    return Container(
      decoration: BoxDecoration(color: AppColors.bgCard, borderRadius: BorderRadius.circular(8), border: Border.all(color: AppColors.border)),
      child: IconButton(icon: Icon(icon, size: 18, color: AppColors.textMuted), onPressed: onTap),
    );
  }
}

// --- Experience Section ---
class ExperienceSection extends StatelessWidget {
  const ExperienceSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80.0, horizontal: 24),
      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.border))),
      child: Column(
        children: [
          const SectionHeader(title: 'Experience & Education'),
          const SizedBox(height: 40),
          ...ContentData.experiences.map((exp) => _buildExperienceItem(exp)).toList(),
        ],
      ),
    );
  }

  Widget _buildExperienceItem(Experience exp) {
    return Container(
      margin: const EdgeInsets.only(bottom: 32),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.c2.withOpacity(0.15),
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.c2.withOpacity(0.4)),
                ),
                child: Icon(
                  exp.type == 'work' ? FontAwesomeIcons.briefcase : FontAwesomeIcons.graduationCap,
                  color: AppColors.c2,
                  size: 18,
                ),
              ),
              Container(width: 2, height: 100, color: AppColors.border),
            ],
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(exp.date, style: const TextStyle(color: AppColors.textDim, fontSize: 13, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text(exp.title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                Text(exp.company, style: const TextStyle(color: AppColors.c1, fontSize: 16, fontWeight: FontWeight.w600)),
                const SizedBox(height: 12),
                ...exp.bullets.map((b) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(padding: EdgeInsets.only(top: 6), child: Icon(Icons.circle, size: 6, color: AppColors.textDim)),
                      const SizedBox(width: 10),
                      Expanded(child: Text(b, style: const TextStyle(color: AppColors.textMuted, height: 1.5))),
                    ],
                  ),
                )).toList(),
              ],
            ),
          ),
        ],
      ),
    );
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

  @override
  Widget build(BuildContext context) {
    final filteredCerts = _filter == 'All' 
        ? ContentData.certs 
        : ContentData.certs.where((c) => c.category == _filter).toList();

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80.0, horizontal: 24),
      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.border))),
      child: Column(
        children: [
          const SectionHeader(title: 'Licenses & Certifications'),
          const SizedBox(height: 40),
          _buildFilterRow(),
          const SizedBox(height: 40),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: filteredCerts.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              mainAxisSpacing: 20,
              childAspectRatio: 1.8,
            ),
            itemBuilder: (context, index) => _buildCertCard(filteredCerts[index]),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterRow() {
    final filters = ['All', '.NET', 'React', 'DevOps', 'AI', 'Other'];
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: filters.map((f) => _buildFilterBtn(f, _filter == f)).toList(),
    );
  }

  Widget _buildFilterBtn(String label, bool active) {
    return GestureDetector(
      onTap: () => setState(() => _filter = label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
        decoration: BoxDecoration(
          gradient: active ? const LinearGradient(colors: [AppColors.c1, AppColors.c2]) : null,
          border: !active ? Border.all(color: const Color(0x59AA64FF)) : null,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(label, style: TextStyle(color: active ? Colors.white : AppColors.textDim, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildCertCard(Certification c) {
    return GlassCard(
      opacity: 0.1,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(FontAwesomeIcons.award, color: c.color, size: 32),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(color: c.color.withOpacity(0.15), borderRadius: BorderRadius.circular(8), border: Border.all(color: c.color.withOpacity(0.4))),
                  child: Text(c.category, style: TextStyle(color: c.color, fontSize: 10, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(c.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text('${c.issuer} • ${c.date}', style: const TextStyle(color: AppColors.textMuted, fontSize: 14)),
            const Spacer(),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: c.skills.map((s) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: c.color.withOpacity(0.1), borderRadius: BorderRadius.circular(8), border: Border.all(color: c.color.withOpacity(0.3))),
                child: Text(s, style: TextStyle(color: c.color, fontSize: 10)),
              )).toList(),
            ),
            const SizedBox(height: 16),
            TextButton.icon(
              onPressed: () => launchUrl(Uri.parse(c.link)),
              icon: const Icon(Icons.open_in_new, size: 16),
              label: const Text('Show Credential', style: TextStyle(fontSize: 12)),
              style: TextButton.styleFrom(foregroundColor: AppColors.c3),
            ),
          ],
        ),
      ),
    );
  }
}

// --- Why Me Section ---
class WhyMeSection extends StatelessWidget {
  const WhyMeSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80.0, horizontal: 24),
      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.border))),
      child: Column(
        children: [
          const SectionHeader(title: 'Why Work With Me?', subtitle: 'I bring more than just code — I bring commitment, craftsmanship, and a genuine passion for building things that matter.'),
          const SizedBox(height: 40),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: ContentData.whyMeFeatures.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              mainAxisSpacing: 16,
              childAspectRatio: 2.2,
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
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(f.icon, color: f.color, size: 28),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: f.color.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                  child: Text(f.tag, style: TextStyle(color: f.color, fontSize: 10, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(f.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 8),
            Expanded(child: Text(f.desc, style: const TextStyle(color: AppColors.textMuted, fontSize: 13, height: 1.4))),
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
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80.0, horizontal: 24),
      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.border))),
      child: Column(
        children: [
          const SectionHeader(title: 'Insights & Articles'),
          const SizedBox(height: 32),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: ContentData.articles.length,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: _buildBlogCard(ContentData.articles[index]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBlogCard(BlogArticle a) {
    return GlassCard(
      opacity: 0.1,
      border: Border(top: BorderSide(color: a.color, width: 4)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(color: a.color.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
              child: Text(a.tag, style: TextStyle(color: a.color, fontSize: 10, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 16),
            Text(a.title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(a.desc, style: const TextStyle(color: AppColors.textMuted, height: 1.5)),
            const SizedBox(height: 20),
            Row(
              children: [
                const Icon(Icons.access_time, size: 14, color: AppColors.textDim),
                const SizedBox(width: 4),
                Text(a.readTime, style: const TextStyle(color: AppColors.textDim, fontSize: 12)),
                const Spacer(),
                TextButton(onPressed: () => launchUrl(Uri.parse(a.link)), child: const Text('Read More →')),
              ],
            )
          ],
        ),
      ),
    );
  }
}

// --- Contact Section ---
class ContactSection extends StatelessWidget {
  const ContactSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80.0, horizontal: 24),
      child: Column(
        children: [
          const SectionHeader(title: 'Get In Touch', subtitle: 'I\'m currently open to new opportunities. Drop a message!'),
          const SizedBox(height: 40),
          GlassCard(
            opacity: 0.08,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  _buildTextField('Your Name'),
                  const SizedBox(height: 16),
                  _buildTextField('Email Address'),
                  const SizedBox(height: 16),
                  _buildTextField('Message', maxLines: 4),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: _buildSubmitButton(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, {int maxLines = 1}) {
    return TextField(
      maxLines: maxLines,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: AppColors.textDim),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.white.withOpacity(0.1))),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.c1)),
        filled: true,
        fillColor: Colors.white.withOpacity(0.02),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [AppColors.c1, AppColors.c2]),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: AppColors.c1.withOpacity(0.3), blurRadius: 15, offset: const Offset(0, 5))],
      ),
      child: ElevatedButton.icon(
        onPressed: () {},
        icon: const Icon(Icons.send, size: 18),
        label: const Text('Send Message', style: TextStyle(fontWeight: FontWeight.bold)),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
      ),
    );
  }
}

// --- Footer Section ---
class FooterSection extends StatelessWidget {
  const FooterSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(60),
      color: Colors.transparent,
      width: double.infinity,
      child: Column(
        children: [
          const Text('Farmanullah.', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900, letterSpacing: -1)),
          const SizedBox(height: 8),
          const Text('Building the web, one line at a time.', style: TextStyle(color: AppColors.textDim)),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildSocialCircle(FontAwesomeIcons.github, 'https://github.com/farmanullah1'),
              const SizedBox(width: 16),
              _buildSocialCircle(FontAwesomeIcons.linkedin, 'https://www.linkedin.com/in/farmanullah-ansari'),
            ],
          ),
          const SizedBox(height: 40),
          const Divider(color: AppColors.border),
          const SizedBox(height: 40),
          const Text('farmanullahansari999@gmail.com', style: TextStyle(color: AppColors.textMuted)),
          const Text('Sindh, Pakistan', style: TextStyle(color: AppColors.textMuted)),
          const SizedBox(height: 24),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('© 2026 Farmanullah Ansari. Built with ', style: TextStyle(color: AppColors.textDim, fontSize: 12)),
              Icon(Icons.favorite, color: Colors.red, size: 12),
              Text(' using Flutter.', style: TextStyle(color: AppColors.textDim, fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSocialCircle(IconData icon, String url) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: AppColors.bgCard,
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.border),
      ),
      child: IconButton(
        icon: Icon(icon, color: AppColors.textMuted, size: 20),
        onPressed: () => launchUrl(Uri.parse(url)),
      ),
    );
  }
}
