import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../theme.dart';
import '../widgets/premium_button.dart';
import '../widgets/typing_cursor.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({super.key});

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
        _typingTimer = Timer(const Duration(milliseconds: 2000), () {
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
    final screenHeight = MediaQuery.of(context).size.height;
    final isMobile = screenWidth < 1000;

    return Container(
      width: double.infinity,
      height: isMobile ? null : screenHeight,
      constraints: BoxConstraints(minHeight: isMobile ? 800 : 900),
      child: Stack(
        alignment: Alignment.center,
        children: [
          _buildAnimatedMeshBackground(screenWidth, screenHeight),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 24 : 100, 
              vertical: isMobile ? 80 : 0
            ),
            child: isMobile ? _buildMobileLayout(screenWidth) : _buildDesktopLayout(screenWidth),
          ),
          if (!isMobile)
            Positioned(
              bottom: 40,
              child: _buildScrollCue(),
            ),
        ],
      ),
    );
  }

  Widget _buildAnimatedMeshBackground(double width, double height) {
    return Positioned.fill(
      child: RepaintBoundary(
        child: Stack(
          children: [
            // Deep Background Mesh
            ...List.generate(3, (i) {
              final color = i == 0 ? AppColors.c1 : (i == 1 ? AppColors.c2 : AppColors.c3);
              return Positioned(
                top: i == 0 ? -100 : (i == 1 ? height * 0.4 : -200),
                left: i == 0 ? -100 : (i == 1 ? width * 0.6 : width * 0.2),
                child: Container(
                  width: 600,
                  height: 600,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [color.withValues(alpha: 0.1), color.withValues(alpha: 0)],
                    ),
                  ),
                ).animate(onPlay: (c) => c.repeat(reverse: true))
                 .move(begin: const Offset(-50, -50), end: const Offset(50, 50), duration: (10 + i * 5).seconds, curve: Curves.easeInOut),
              );
            }),
            
            // Noise Overlay
            Positioned.fill(
              child: Opacity(
                opacity: 0.02,
                child: Image.asset('assets/noise.png', repeat: ImageRepeat.repeat, errorBuilder: (c, e, s) => const SizedBox()),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(double screenWidth) {
    return Row(
      children: [
        Expanded(
          flex: 6,
          child: _buildTextContent(false),
        ),
        const SizedBox(width: 60),
        Expanded(
          flex: 4,
          child: _buildOrbitalImage(screenWidth, false),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(double screenWidth) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildOrbitalImage(screenWidth, true),
        const SizedBox(height: 80),
        _buildTextContent(true),
      ],
    );
  }

  Widget _buildTextContent(bool isMobile) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        _buildBadge(),
        const SizedBox(height: 40),
        Text(
          "GREETINGS, I AM",
          style: TextStyle(
            fontSize: isMobile ? 14 : 18, 
            fontWeight: FontWeight.w900, 
            color: isDark ? AppColors.c1.withValues(alpha: 0.8) : AppColors.c2,
            letterSpacing: 4.0,
            fontFamily: 'Fira Code',
          ),
        ).animate().fadeIn(duration: 800.ms).slideX(begin: -0.2, end: 0),
        const SizedBox(height: 16),
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Colors.white, Color(0xFFAAAAAA)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ).createShader(bounds),
          child: Text(
            "Farmanullah\nAnsari.",
            textAlign: isMobile ? TextAlign.center : TextAlign.start,
            style: TextStyle(
              fontSize: isMobile ? 64 : 130,
              fontWeight: FontWeight.w900,
              height: 0.9,
              letterSpacing: -6,
              color: Colors.white,
            ),
          ),
        ).animate().fadeIn(delay: 200.ms, duration: 1.seconds).scale(begin: const Offset(0.95, 0.95), end: const Offset(1, 1), curve: Curves.easeOutCubic),
        const SizedBox(height: 40),
        
        // Premium Role Display
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          decoration: BoxDecoration(
            color: AppColors.c1.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.c1.withValues(alpha: 0.1)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _displayedRole,
                style: TextStyle(
                  fontSize: isMobile ? 16 : 24,
                  fontWeight: FontWeight.w800,
                  color: isDark ? Colors.white : AppColors.textLight,
                  fontFamily: 'Fira Code',
                  letterSpacing: -0.5,
                ),
              ),
              const TypingCursor(),
            ],
          ),
        ).animate().fadeIn(delay: 400.ms),
        
        const SizedBox(height: 40),
        SizedBox(
          width: 600,
          child: Text(
            "I engineer high-performance digital solutions with the MERN stack and ASP.NET Core. My work bridges the gap between complex architectural logic and fluid human-centric design.",
            textAlign: isMobile ? TextAlign.center : TextAlign.start,
            style: TextStyle(
              fontSize: isMobile ? 16 : 20,
              color: isDark ? AppColors.textMuted : AppColors.textMutedLight,
              height: 1.8,
              letterSpacing: 0.2,
            ),
          ),
        ).animate().fadeIn(delay: 600.ms, duration: 800.ms),
        const SizedBox(height: 56),
        Wrap(
          spacing: 24,
          runSpacing: 24,
          alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
          children: [
            PremiumButton(label: "EXPLORE PROJECTS", icon: FontAwesomeIcons.bolt, isPrimary: true),
            PremiumButton(label: "GET IN TOUCH", icon: FontAwesomeIcons.paperPlane, isPrimary: false),
          ],
        ).animate().fadeIn(delay: 800.ms, duration: 800.ms).slideY(begin: 0.2, end: 0),
      ],
    );
  }

  Widget _buildBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.c4.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.c4.withValues(alpha: 0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8, height: 8,
            decoration: const BoxDecoration(color: AppColors.c4, shape: BoxShape.circle),
          ).animate(onPlay: (c) => c.repeat()).scale(begin: const Offset(1, 1), end: const Offset(1.5, 1.5), duration: 1.seconds).fadeOut(),
          const SizedBox(width: 10),
          const Text(
            "AVAILABLE FOR FREELANCE",
            style: TextStyle(color: AppColors.c4, fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 1.5),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 800.ms).slideX(begin: -0.1, end: 0);
  }

  Widget _buildOrbitalImage(double screenWidth, bool isMobile) {
    final size = isMobile ? 280.0 : 480.0;
    return Center(
      child: SizedBox(
        width: size,
        height: size,
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            // Rotating Rings
            ...List.generate(3, (i) => _buildAnimatedRing(i, size)),
            
            // Background Glow
            Container(
              width: size * 0.8,
              height: size * 0.8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [AppColors.c1.withValues(alpha: 0.15), Colors.transparent],
                ),
              ),
            ),
            
            // Main Profile Image
            Container(
              width: size * 0.75,
              height: size * 0.75,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white.withValues(alpha: 0.1), width: 2),
                boxShadow: [
                  BoxShadow(color: Colors.black.withValues(alpha: 0.5), blurRadius: 40, spreadRadius: -10),
                ],
              ),
              child: ClipOval(
                child: Image.asset(
                  'assets/profile2.webp',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: AppColors.bgCard,
                    child: const Icon(Icons.person, size: 100, color: AppColors.c1),
                  ),
                ),
              ),
            ).animate().fadeIn(duration: 1.seconds).scale(begin: const Offset(0.9, 0.9), end: const Offset(1, 1), curve: Curves.easeOutBack),
            
            // Orbiting Tech Spheres
            _buildOrbitingSpheres(size),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedRing(int index, double baseSize) {
    final size = baseSize * (0.8 + (index * 0.1));
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.03 * (3 - index)), 
          width: 1.0
        ),
      ),
    ).animate(onPlay: (c) => c.repeat())
     .rotate(begin: 0, end: index.isEven ? 1 : -1, duration: (20 + (index * 10)).seconds);
  }

  Widget _buildOrbitingSpheres(double size) {
    final tech = [
      {'icon': FontAwesomeIcons.react, 'color': AppColors.c3, 'angle': 0.0},
      {'icon': FontAwesomeIcons.nodeJs, 'color': AppColors.c4, 'angle': 2.0},
      {'icon': FontAwesomeIcons.code, 'color': AppColors.c1, 'angle': 4.0},
    ];

    return Stack(
      children: tech.map((t) {
        return _OrbitingWidget(
          radius: size * 0.5,
          angle: t['angle'] as double,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.bgCard,
              shape: BoxShape.circle,
              border: Border.all(color: (t['color'] as Color).withValues(alpha: 0.3), width: 1.5),
              boxShadow: [
                BoxShadow(color: (t['color'] as Color).withValues(alpha: 0.2), blurRadius: 10)
              ],
            ),
            child: Icon(t['icon'] as IconData, color: t['color'] as Color, size: 18),
          ).animate(onPlay: (c) => c.repeat(reverse: true)).moveY(begin: -10, end: 10, duration: 2.seconds, curve: Curves.easeInOut),
        );
      }).toList(),
    );
  }

  Widget _buildScrollCue() {
    return Column(
      children: [
        const Text("SCROLL DOWN", style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 4, color: AppColors.textDim)),
        const SizedBox(height: 16),
        Container(
          width: 1, height: 60,
          color: AppColors.border,
          child: Stack(
            children: [
              Positioned(
                top: 0, left: 0, right: 0,
                child: Container(
                  height: 20,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [AppColors.c1, Colors.transparent],
                    ),
                  ),
                ).animate(onPlay: (c) => c.repeat()).moveY(begin: 0, end: 40, duration: 1.5.seconds),
              ),
            ],
          ),
        ),
      ],
    ).animate().fadeIn(delay: 1.seconds);
  }
}

class _OrbitingWidget extends StatefulWidget {
  final double radius;
  final double angle;
  final Widget child;

  const _OrbitingWidget({required this.radius, required this.angle, required this.child});

  @override
  State<_OrbitingWidget> createState() => _OrbitingWidgetState();
}

class _OrbitingWidgetState extends State<_OrbitingWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: 30.seconds)..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final angle = (_controller.value * 2 * math.pi) + widget.angle;
        final x = widget.radius * math.cos(angle);
        final y = widget.radius * math.sin(angle);
        return Transform.translate(
          offset: Offset(x, y),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}

class ParticlePainter extends CustomPainter {
  final Color color;
  final int particleCount;
  ParticlePainter({required this.color, required this.particleCount});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final random = math.Random(42);
    
    for (int i = 0; i < particleCount; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;
      final radius = random.nextDouble() * 2.0 + 0.5;
      canvas.drawCircle(Offset(x, y), radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
