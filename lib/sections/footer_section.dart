import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 800;

    return Container(
      decoration: BoxDecoration(
        border: const Border(top: BorderSide(color: AppColors.border)),
        gradient: LinearGradient(
          begin: Alignment.topCenter, 
          end: Alignment.bottomCenter, 
          colors: [
            Colors.black.withValues(alpha: 0), 
            AppColors.bg2.withValues(alpha: 0.5)
          ]
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 100, horizontal: isMobile ? 24 : 100),
            child: isMobile ? _buildMobileFooter() : _buildDesktopFooter(),
          ),
          const Divider(color: AppColors.border, height: 1),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '© ${DateTime.now().year} Farmanullah Ansari. Built with Flutter & Passion.', 
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: AppColors.textDim, fontSize: 13, fontWeight: FontWeight.w600)
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopFooter() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: _buildBranding(),
        ),
        const Spacer(),
        _buildFooterGroup('EXPLORE', ['Home', 'About', 'Skills', 'Projects']),
        const SizedBox(width: 80),
        _buildFooterGroup('LEGAL', ['Privacy', 'Terms', 'License']),
        const SizedBox(width: 80),
        _buildFooterGroup('CONNECT', ['LinkedIn', 'GitHub', 'Twitter']),
      ],
    );
  }

  Widget _buildMobileFooter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildBranding(),
        const SizedBox(height: 60),
        Wrap(
          spacing: 40,
          runSpacing: 40,
          alignment: WrapAlignment.center,
          children: [
            _buildFooterGroup('EXPLORE', ['Home', 'Projects']),
            _buildFooterGroup('CONNECT', ['LinkedIn', 'GitHub']),
          ],
        ),
      ],
    );
  }

  Widget _buildBranding() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(colors: [AppColors.c1, AppColors.c3]).createShader(bounds),
          child: const Text(
            'Farmanullah.', 
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900, color: Colors.white, letterSpacing: -2)
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'Engineering the next generation of digital excellence with precision and creativity.', 
          style: TextStyle(color: AppColors.textMuted, fontSize: 15, height: 1.6), 
          maxLines: 3
        ),
        const SizedBox(height: 32),
        _buildSocialIcons(),
      ],
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
        margin: const EdgeInsets.only(right: 12),
        child: IconButton(
          onPressed: () => launchUrl(Uri.parse(s['url'] as String)),
          icon: Icon(s['icon'] as IconData, size: 18, color: Colors.white.withValues(alpha: 0.6)),
          style: IconButton.styleFrom(
            backgroundColor: AppColors.bgCard,
            padding: const EdgeInsets.all(14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14), 
              side: const BorderSide(color: AppColors.border)
            ),
          ),
        ),
      )).toList(),
    );
  }

  Widget _buildFooterGroup(String t, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(t, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: Colors.white, letterSpacing: 2.5, fontFamily: 'Fira Code')),
        const SizedBox(height: 32),
        ...items.map((i) => Padding(
          padding: const EdgeInsets.only(bottom: 18),
          child: Text(
            i, 
            style: const TextStyle(color: AppColors.textDim, fontSize: 14, fontWeight: FontWeight.w700)
          ),
        )),
      ],
    );
  }
}
