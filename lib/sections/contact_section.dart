import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme.dart';
import '../widgets/section_header.dart';
import '../widgets/glass_card.dart';
import '../widgets/premium_button.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 800;

    return Column(
      children: [
        const SectionHeader(title: "Get In Touch"),
        const SizedBox(height: 20),
        if (isMobile)
          Column(children: [
            _buildContactInfo(context),
            const SizedBox(height: 40),
            _buildContactForm(context),
          ])
        else
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _buildContactInfo(context)),
              const SizedBox(width: 60),
              Expanded(child: _buildContactForm(context)),
            ],
          ),
      ],
    );
  }

  Widget _buildContactInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Let's Build Something Great",
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        const Text(
          "Whether you have a question, a project idea, or just want to say hi, my inbox is always open.",
          style: TextStyle(fontSize: 16, color: AppColors.textDim, height: 1.6),
        ),
        const SizedBox(height: 40),
        _buildInfoTile(FontAwesomeIcons.envelope, "Email Me", "ansarifarmaanullah@gmail.com"),
        const SizedBox(height: 20),
        _buildInfoTile(FontAwesomeIcons.locationDot, "Location", "Pakistan"),
        const SizedBox(height: 40),
        const Text("Connect with me", style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        Row(
          children: [
            _buildSocialCircle(FontAwesomeIcons.github, 'https://github.com/farmanullah1'),
            const SizedBox(width: 12),
            _buildSocialCircle(FontAwesomeIcons.linkedin, 'https://www.linkedin.com/in/farmanullah-ansari'),
          ],
        ),
      ],
    );
  }

  Widget _buildInfoTile(IconData icon, String label, String value) {
    return Row(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: AppColors.c2.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: AppColors.c2, size: 20),
        ),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(fontSize: 12, color: AppColors.textDim)),
            Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
      ],
    );
  }

  Widget _buildSocialCircle(IconData icon, String url) {
    return InkWell(
      onTap: () => launchUrl(Uri.parse(url)),
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.border),
          shape: BoxShape.circle,
        ),
        child: Center(child: Icon(icon, size: 18, color: AppColors.textDim)),
      ),
    );
  }

  Widget _buildContactForm(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          _buildTextField("Your Name"),
          const SizedBox(height: 20),
          _buildTextField("Your Email"),
          const SizedBox(height: 20),
          _buildTextField("Message", maxLines: 5),
          const SizedBox(height: 32),
          const PremiumButton(label: "Send Message", icon: Icons.send, isPrimary: true),
        ],
      ),
    );
  }

  Widget _buildTextField(String hint, {int maxLines = 1}) {
    return TextField(
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: AppColors.textDim, fontSize: 14),
        filled: true,
        fillColor: Colors.black.withOpacity(0.2),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
        contentPadding: const EdgeInsets.all(20),
      ),
    );
  }
}
