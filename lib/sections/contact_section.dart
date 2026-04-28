import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme.dart';
import '../widgets/glass_card.dart';
import '../widgets/section_header.dart';
import '../widgets/premium_button.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});
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
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 100),
      child: Column(
        children: [
          const SectionHeader(
            title: 'Get In Touch', 
            index: '07',
            subtitle: "Let's collaborate on your next big project. I'm always open to discussing new ideas and opportunities."
          ),
          const SizedBox(height: 80),
          if (isMobile)
            Column(
              children: [
                _buildContactInfo(context, isMobile), 
                const SizedBox(height: 80), 
                _buildContactForm(context, isMobile)
              ]
            )
          else
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 5, child: _buildContactInfo(context, false)),
                const SizedBox(width: 100),
                Expanded(flex: 6, child: _buildContactForm(context, false)),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildContactInfo(BuildContext context, bool isMobile) {
    final socials = [
      {'label': 'EMAIL', 'text': 'farmanullahansari999@gmail.com', 'icon': FontAwesomeIcons.envelope, 'url': 'mailto:farmanullahansari999@gmail.com', 'color': AppColors.c1},
      {'label': 'LINKEDIN', 'text': 'linkedin.com/in/farmanullah-ansari', 'icon': FontAwesomeIcons.linkedin, 'url': 'https://www.linkedin.com/in/farmanullah-ansari', 'color': AppColors.c2},
      {'label': 'GITHUB', 'text': 'github.com/farmanullah1', 'icon': FontAwesomeIcons.github, 'url': 'https://github.com/farmanullah1', 'color': AppColors.text},
      {'label': 'TWITTER', 'text': '@farmanullah9088', 'icon': FontAwesomeIcons.twitter, 'url': 'https://x.com/farmanullah9088', 'color': AppColors.c3},
    ];

    return Column(
      crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Text(
          "Ready to start\nyour project?", 
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
          style: TextStyle(
            fontSize: isMobile ? 32 : 56, 
            fontWeight: FontWeight.w900, 
            height: 1.0, 
            color: Colors.white,
            letterSpacing: -2,
          )
        ),
        const SizedBox(height: 32),
        Text(
          "I'm specialized in large-scale MERN and ASP.NET architectures. Whether it's a startup idea or an enterprise solution, I'm here to help you scale.", 
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
          style: const TextStyle(color: AppColors.textMuted, fontSize: 16, height: 1.8)
        ),
        const SizedBox(height: 56),
        ...socials.map((s) => _buildSocialRow(context, s, isMobile)),
        const SizedBox(height: 56),
        Wrap(
          spacing: 20,
          runSpacing: 20,
          alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
          children: [
            PremiumButton(label: "Download CV", icon: FontAwesomeIcons.filePdf, isPrimary: true),
            PremiumButton(label: "Copy Email", icon: FontAwesomeIcons.copy, isPrimary: false),
          ],
        ),
      ],
    );
  }

  Widget _buildSocialRow(BuildContext context, Map<String, dynamic> s, bool isMobile) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: InkWell(
        onTap: () => launchUrl(Uri.parse(s['url'])),
        borderRadius: BorderRadius.circular(16),
        child: Row(
          mainAxisSize: isMobile ? MainAxisSize.min : MainAxisSize.max,
          children: [
            Container(
              width: 52, height: 52, 
              decoration: BoxDecoration(
                color: (s['color'] as Color).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: (s['color'] as Color).withValues(alpha: 0.2))
              ), 
              child: Icon(s['icon'] as IconData, color: s['color'] as Color, size: 20)
            ),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start, 
              children: [
                Text(
                  s['label'] as String, 
                  style: const TextStyle(color: AppColors.textDim, fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 2)
                ), 
                const SizedBox(height: 4), 
                Text(
                  s['text'] as String, 
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Colors.white)
                )
              ]
            ),
          ],
        ),
      ),
    ).animate().fadeIn(delay: 200.ms).slideX(begin: -0.02, end: 0);
  }

  Widget _buildContactForm(BuildContext context, bool isMobile) {
    return Form(
      key: _formKey,
      child: GlassCard(
        hasGlow: true,
        glowColor: AppColors.c1,
        child: Padding(
          padding: EdgeInsets.all(isMobile ? 28 : 48),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("SEND A MESSAGE", style: TextStyle(color: AppColors.c1, fontWeight: FontWeight.w900, fontSize: 12, letterSpacing: 3)),
              const SizedBox(height: 40),
              _buildField(context, "Full Name", "Farmanullah Ansari", FontAwesomeIcons.user),
              const SizedBox(height: 24),
              _buildField(context, "Email Address", "hello@example.com", FontAwesomeIcons.envelope),
              const SizedBox(height: 24),
              _buildField(context, "Project Brief", "Tell me about your vision...", FontAwesomeIcons.penNib, maxLines: 5),
              const SizedBox(height: 48),
              _buildSubmitBtn(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField(BuildContext context, String label, String hint, IconData icon, {int maxLines = 1}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 12, color: AppColors.textDim),
            const SizedBox(width: 10),
            Text(label.toUpperCase(), style: TextStyle(color: isDark ? AppColors.textDim : AppColors.textDimLight, fontWeight: FontWeight.w900, fontSize: 10, letterSpacing: 1.5)),
          ],
        ),
        const SizedBox(height: 12),
        TextFormField(
          maxLines: maxLines,
          style: TextStyle(fontSize: 15, color: isDark ? Colors.white : AppColors.textLight, fontWeight: FontWeight.w600),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: (isDark ? Colors.white : Colors.black).withValues(alpha: 0.15)),
            filled: true, 
            fillColor: (isDark ? Colors.white : Colors.black).withValues(alpha: 0.03),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16), 
              borderSide: BorderSide(color: (isDark ? Colors.white : Colors.black).withValues(alpha: 0.08))
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16), 
              borderSide: const BorderSide(color: AppColors.c1, width: 2)
            ),
            contentPadding: const EdgeInsets.all(24),
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitBtn() {
    return PremiumButton(
      label: _isSending ? "Sending..." : "Transmit Message", 
      icon: _isSending ? Icons.sync : FontAwesomeIcons.paperPlane, 
      isPrimary: true,
      onPressed: () {
        HapticFeedback.heavyImpact();
        setState(() => _isSending = true);
        Future.delayed(const Duration(seconds: 2), () {
          if (mounted) {
            setState(() => _isSending = false);
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Message transmitted successfully!")));
          }
        });
      },
    );
  }
}
