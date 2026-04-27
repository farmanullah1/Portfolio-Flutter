import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import 'models.dart';

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
    'Software Engineer',
  ];

  int _roleIndex = 0;
  String _currentText = '';
  bool _isDeleting = false;
  late Duration _typingSpeed;

  @override
  void initState() {
    super.initState();
    _typingSpeed = const Duration(milliseconds: 100);
    _type();
  }

  void _type() {
    if (!mounted) return;

    final fullText = _roles[_roleIndex];

    setState(() {
      if (_isDeleting) {
        _currentText = fullText.substring(0, _currentText.length - 1);
        _typingSpeed = const Duration(milliseconds: 50);
      } else {
        _currentText = fullText.substring(0, _currentText.length + 1);
        _typingSpeed = const Duration(milliseconds: 100);
      }
    });

    if (!_isDeleting && _currentText == fullText) {
      _typingSpeed = const Duration(milliseconds: 2000);
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
    final screenHeight = MediaQuery.of(context).size.height;
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      constraints: BoxConstraints(minHeight: screenHeight),
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 80.0),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Profile Image
          Center(
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: colorScheme.primary, width: 4),
                boxShadow: [
                  BoxShadow(
                    color: colorScheme.primary.withOpacity(0.3),
                    blurRadius: 30,
                    spreadRadius: 10,
                  )
                ],
                image: const DecorationImage(
                  image: AssetImage('assets/profile2.webp'),
                  fit: BoxFit.cover,
                ),
              ),
            ).animate().scale(duration: 800.ms, curve: Curves.elasticOut),
          ),
          const SizedBox(height: 40),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: colorScheme.primary.withOpacity(0.3)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 8, height: 8,
                      decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle),
                    ),
                    const SizedBox(width: 8),
                    Text('Available for new opportunities', 
                      style: TextStyle(color: colorScheme.primary, fontSize: 12)),
                  ],
                ),
              ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.5, end: 0),
              const SizedBox(height: 24),
              const Text('Hi, I\'m', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w300))
                  .animate().fadeIn(delay: 200.ms),
              Text('Farmanullah Ansari', 
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, height: 1.1, color: colorScheme.onBackground))
                  .animate().fadeIn(delay: 400.ms).slideY(),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('I\'m a ', style: TextStyle(fontSize: 20, color: Colors.grey)),
                  Text(_currentText, 
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: colorScheme.primary)),
                  const Text('|', style: TextStyle(fontSize: 20, color: Colors.grey)),
                ],
              ),
              const SizedBox(height: 24),
              const Text(
                'I engineer dynamic, user-friendly, and scalable web applications. Passionate about the MERN stack, ASP.NET Core, cloud computing, and building seamless digital experiences.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, height: 1.5, color: Colors.grey),
              ).animate().fadeIn(delay: 800.ms),
              const SizedBox(height: 40),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 16,
                runSpacing: 16,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {}, 
                    icon: const Icon(Icons.mail), 
                    label: const Text('Hire Me'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                  ),
                  OutlinedButton.icon(
                    onPressed: () {}, 
                    icon: const Icon(Icons.download), 
                    label: const Text('Download CV'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: colorScheme.primary,
                      side: BorderSide(color: colorScheme.primary),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                  ),
                ],
              ).animate().fadeIn(delay: 1000.ms),
            ],
          ),
        ],
      ),
    );
  }
}

// --- About Section ---
class AboutSection extends StatelessWidget {
  const AboutSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 80.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('About Me', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          const Text(
            'I\'m a passionate Full-Stack Software Engineer based in Pakistan, specialising in building exceptional digital experiences.',
            style: TextStyle(fontSize: 16, height: 1.6, color: Colors.grey),
          ),
          const SizedBox(height: 16),
          const Text(
            'When I\'m not coding, I\'m exploring new cloud technologies, contributing to open-source projects, or writing technical articles.',
            style: TextStyle(fontSize: 16, height: 1.6, color: Colors.grey),
          ),
          const SizedBox(height: 32),
          // Highlights Grid
          GridView.count(
            crossAxisCount: MediaQuery.of(context).size.width > 600 ? 2 : 1,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 2.5,
            children: [
              _buildHighlightCard(context, Icons.code, 'Clean Code', 'Readable, maintainable, and well-structured code is a priority in every project.', const Color(0xFFe040fb)),
              _buildHighlightCard(context, Icons.laptop, 'Modern Stack', 'Proficient in MERN, ASP.NET Core, and cloud-native technologies.', const Color(0xFF00e5ff)),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildHighlightCard(BuildContext context, IconData icon, String title, String desc, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: color.withOpacity(0.1), shape: BoxShape.circle),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                const SizedBox(height: 4),
                Text(desc, style: const TextStyle(color: Colors.grey, fontSize: 14)),
              ],
            ),
          )
        ],
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
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 80.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Technical Skills', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
          const SizedBox(height: 32),
          // Wrap categories
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              _buildSkillCategory(context, 'Frontend', const Color(0xFFe040fb), ['React.js', 'TypeScript', 'Tailwind CSS', 'Framer Motion']),
              _buildSkillCategory(context, 'Backend', const Color(0xFF7c3aed), ['Node.js', 'Express.js', 'ASP.NET Core', 'C#', 'REST APIs']),
              _buildSkillCategory(context, 'Database & Cloud', const Color(0xFF00e5ff), ['MongoDB', 'SQL Server', 'AWS EC2 / EB', 'Docker', 'Linux']),
              _buildSkillCategory(context, 'Tools & Other', const Color(0xFFffab40), ['Git & GitHub', 'Power BI', 'Python', 'Figma', 'Postman']),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildSkillCategory(BuildContext context, String title, Color color, List<String> skills) {
    return Container(
      width: MediaQuery.of(context).size.width > 600 ? MediaQuery.of(context).size.width / 2 - 40 : double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border(left: BorderSide(color: color, width: 4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: skills.map((s) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: color.withOpacity(0.3)),
              ),
              child: Text(s, style: TextStyle(color: color)),
            )).toList(),
          )
        ],
      ),
    );
  }
}

// --- Projects Section ---
class ProjectsSection extends StatelessWidget {
  const ProjectsSection({Key? key}) : super(key: key);

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 80.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Featured Projects', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
          const SizedBox(height: 32),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: ContentData.projects.length,
            itemBuilder: (context, index) {
              final project = ContentData.projects[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 24),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: project.featured ? Border.all(color: Colors.amber, width: 1) : null,
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4)),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (project.featured)
                      Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.amber.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.star, color: Colors.amber, size: 16),
                            SizedBox(width: 4),
                            Text('Featured', style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    Icon(project.icon, size: 32, color: Theme.of(context).primaryColor),
                    const SizedBox(height: 16),
                    Text(project.title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text(project.desc, style: const TextStyle(color: Colors.grey, height: 1.5)),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: project.tech.map((t) => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(t, style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 12)),
                      )).toList(),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        if (project.live.isNotEmpty)
                          ElevatedButton.icon(
                            onPressed: () => _launchUrl(project.live),
                            icon: const Icon(Icons.open_in_new, size: 18),
                            label: const Text('Live Demo'),
                          ),
                        const SizedBox(width: 16),
                        if (project.code.isNotEmpty)
                          TextButton.icon(
                            onPressed: () => _launchUrl(project.code),
                            icon: const Icon(FontAwesomeIcons.github, size: 18),
                            label: const Text('Source Code'),
                          ),
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

// --- Experience Section ---
class ExperienceSection extends StatelessWidget {
  const ExperienceSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 80.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Experience & Education', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
          const SizedBox(height: 32),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: ContentData.experiences.length,
            itemBuilder: (context, index) {
              final exp = ContentData.experiences[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 24),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border(left: BorderSide(color: Theme.of(context).primaryColor, width: 4)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(exp.date, style: const TextStyle(color: Colors.grey, fontSize: 14)),
                    const SizedBox(height: 8),
                    Text(exp.title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    Text(exp.company, style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 12),
                    ...exp.bullets.map((b) => Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(padding: EdgeInsets.only(top: 6), child: Icon(Icons.circle, size: 6, color: Colors.grey)),
                          const SizedBox(width: 8),
                          Expanded(child: Text(b, style: const TextStyle(color: Colors.grey, height: 1.5))),
                        ],
                      ),
                    )),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

// --- Certifications Section ---
class CertificationsSection extends StatelessWidget {
  const CertificationsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 80.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Certifications', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
          const SizedBox(height: 32),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: ContentData.certs.length,
            itemBuilder: (context, index) {
              final cert = ContentData.certs[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Icon(FontAwesomeIcons.certificate, color: cert.color, size: 32),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(cert.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          const SizedBox(height: 4),
                          Text('${cert.issuer} • ${cert.date}', style: const TextStyle(color: Colors.grey, fontSize: 14)),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 80.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Why Work With Me?', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          const Text(
            'I bring more than just code — I bring commitment, craftsmanship, and a genuine passion for building things that matter.',
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
          const SizedBox(height: 40),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: ContentData.whyMeFeatures.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: MediaQuery.of(context).size.width > 600 ? 2 : 1,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 1.8,
            ),
            itemBuilder: (context, index) {
              final feature = ContentData.whyMeFeatures[index];
              return Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(feature.icon, color: feature.color, size: 28),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: feature.color.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(feature.tag, style: TextStyle(color: feature.color, fontSize: 10)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(feature.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    const SizedBox(height: 8),
                    Expanded(child: Text(feature.desc, style: const TextStyle(color: Colors.grey, fontSize: 13, height: 1.4))),
                  ],
                ),
              );
            },
          ),
        ],
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
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 80.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Insights & Articles', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
          const SizedBox(height: 32),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: ContentData.articles.length,
            itemBuilder: (context, index) {
              final article = ContentData.articles[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 20),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border(top: BorderSide(color: article.color, width: 4)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: article.color.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(article.tag, style: TextStyle(color: article.color, fontSize: 10, fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(height: 16),
                    Text(article.title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text(article.desc, style: const TextStyle(color: Colors.grey, height: 1.5)),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const Icon(Icons.access_time, size: 14, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(article.readTime, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                        const Spacer(),
                        TextButton(onPressed: () {}, child: const Text('Read More →')),
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        ],
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
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 80.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Get In Touch', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          const Text('I\'m currently open to new opportunities. Drop a message!', style: TextStyle(color: Colors.grey, fontSize: 16)),
          const SizedBox(height: 32),
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Your Name',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Email Address',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  maxLines: 4,
                  decoration: InputDecoration(
                    labelText: 'Message',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.send),
                    label: const Text('Send Message'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
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
      padding: const EdgeInsets.all(40),
      color: Theme.of(context).colorScheme.surface,
      width: double.infinity,
      child: Column(
        children: [
          const Text('Farmanullah Ansari', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(icon: const Icon(FontAwesomeIcons.github), onPressed: () {}),
              IconButton(icon: const Icon(FontAwesomeIcons.linkedin), onPressed: () {}),
              IconButton(icon: const Icon(FontAwesomeIcons.twitter), onPressed: () {}),
            ],
          ),
          const SizedBox(height: 24),
          const Text('© 2026 Farmanullah Ansari. Built with Flutter.', style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}
