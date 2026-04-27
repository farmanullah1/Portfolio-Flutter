import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Project {
  final String title;
  final String desc;
  final List<String> tech;
  final String live;
  final String code;
  final IconData icon;
  final bool featured;
  final String category;

  const Project({
    required this.title,
    required this.desc,
    required this.tech,
    required this.live,
    required this.code,
    required this.icon,
    this.featured = false,
    required this.category,
  });
}

class Experience {
  final String title;
  final String company;
  final String date;
  final String type;
  final List<String> bullets;

  const Experience({
    required this.title,
    required this.company,
    required this.date,
    required this.type,
    required this.bullets,
  });
}

class Certification {
  final String title;
  final String issuer;
  final String date;
  final String category;
  final String credentialId;
  final String link;
  final List<String> skills;
  final Color color;

  const Certification({
    required this.title,
    required this.issuer,
    required this.date,
    required this.category,
    required this.credentialId,
    required this.link,
    required this.skills,
    required this.color,
  });
}

class BlogArticle {
  final String title;
  final String date;
  final String readTime;
  final String desc;
  final String tag;
  final String link;
  final Color color;

  const BlogArticle({
    required this.title,
    required this.date,
    required this.readTime,
    required this.desc,
    required this.tag,
    required this.link,
    required this.color,
  });
}

class WhyMeFeature {
  final IconData icon;
  final String title;
  final String desc;
  final Color color;
  final String tag;

  const WhyMeFeature({
    required this.icon,
    required this.title,
    required this.desc,
    required this.color,
    required this.tag,
  });
}

class ContentData {
  static const List<Project> projects = [
    Project(
      title: 'Gadd Kaam — SkillSwap Pakistan -MERN Stack',
      desc: 'Final Year Project: A secure, cashless skill-trading platform allowing users to swap services like web dev for graphics. Features JWT, CNIC verification, and rating systems.',
      tech: ['MongoDB', 'Express', 'React', 'Node.js', 'Socket.io'],
      live: 'https://gaddkaam.com',
      code: 'https://github.com/farmanullah1/gadd-kaam',
      icon: FontAwesomeIcons.arrowsRotate,
      featured: true,
      category: 'MERN Stack',
    ),
    Project(
      title: 'SkyCast — Weather Dashboard',
      desc: 'Sophisticated weather dashboard using OpenWeatherMap API. Features location-based search, 7-day forecast, and dynamic background shifts based on weather conditions.',
      tech: ['React', 'Framer Motion', 'REST API'],
      live: 'https://farmanullah1.github.io/SkyCast/',
      code: 'https://github.com/farmanullah1/SkyCast',
      icon: FontAwesomeIcons.cloudSun,
      featured: true,
      category: 'React',
    ),
    Project(
      title: 'InventoryPro — ASP.NET Core ERP',
      desc: 'Robust ERP system for small businesses. Features role-based access control, real-time inventory tracking, and automated PDF invoice generation.',
      tech: ['ASP.NET Core', 'SQL Server', 'Entity Framework'],
      live: 'https://github.com/farmanullah1',
      code: 'https://github.com/farmanullah1/InventoryPro',
      icon: FontAwesomeIcons.boxesStacked,
      featured: false,
      category: 'ASP.NET Core',
    ),
    Project(
      title: 'BalanceWave — Budget Tracker',
      desc: 'Visual expense tracker with Power BI integration. Allows users to categorize spending and visualize financial health over time.',
      tech: ['React', 'Power BI', 'Chart.js'],
      live: 'https://farmanullah1.github.io/BalanceWave/',
      code: 'https://github.com/farmanullah1/BalanceWave',
      icon: FontAwesomeIcons.chartLine,
      featured: false,
      category: 'React',
    ),
  ];

  static const List<Experience> experiences = [
    Experience(
      title: 'Web Development Intern',
      company: 'PS CODERS',
      date: 'Jul 2024 – Oct 2024',
      type: 'work',
      bullets: [
        'Engineered dynamic and responsive front-end interfaces using modern web technologies.',
        'Collaborated with cross-functional teams to optimise UI/UX and improve overall application performance.',
        'Ensured cross-browser compatibility and adhered to clean code architecture and standard development workflows.'
      ],
    ),
    Experience(
      title: 'Cloud Computing Fellow',
      company: 'ACM UET Lahore',
      date: 'Jun 2024 – Aug 2024',
      type: 'work',
      bullets: [
        'Gained hands-on experience in cloud infrastructure, DevOps practices, and server management.',
        'Deployed scalable web applications leveraging AWS services, including Elastic Beanstalk and EC2.',
        'Implemented containerised environments using Docker, focusing on port mapping, volume mounting, and multi-container NGINX architectures.'
      ],
    ),
    Experience(
      title: 'BS Software Engineering',
      company: 'University of Sindh',
      date: 'Jan 2022 – Dec 2025',
      type: 'education',
      bullets: [
        'Mastered core computer science principles including Data Structures, OOP, and full-stack methodologies.',
        'Developed \'Gadd Kaam – SkillSwap Pakistan\' as Final Year Project: a secure MERN-stack platform for cashless skill trading.',
        'Earned multiple certifications in .NET, React.js, Docker, and Cloud Fundamentals throughout the degree.'
      ],
    ),
  ];

  static const List<Certification> certs = [
    Certification(
      title: 'React Crash Course: From Zero to Hero',
      issuer: 'Udemy',
      date: 'Mar 2026',
      category: 'React',
      credentialId: 'UC-a83ae4f4-9639-4595-a11e-abc632404393',
      link: 'https://www.udemy.com/certificate/UC-a83ae4f4-9639-4595-a11e-abc632404393/',
      skills: ['React.js'],
      color: Color(0xFF61DAFB),
    ),
    Certification(
      title: 'Microsoft Power BI – Complete Beginner to Advanced 2026',
      issuer: 'Udemy',
      date: 'Mar 2026',
      category: 'Other',
      credentialId: 'UC-53b26ea4-79f3-4e29-8e53-9883cb4b01fa',
      link: 'https://www.udemy.com/certificate/UC-53b26ea4-79f3-4e29-8e53-9883cb4b01fa/',
      skills: ['Power BI'],
      color: Color(0xFFF2C811),
    ),
    Certification(
      title: 'Complete ASP.NET Core MVC 6 with Real-World Projects',
      issuer: 'Udemy',
      date: 'Jan 2026',
      category: '.NET',
      credentialId: 'UC-0d9450f9-88c2-47c6-b833-2b4fb97af3c7',
      link: 'https://www.udemy.com/certificate/UC-0d9450f9-88c2-47c6-b833-2b4fb97af3c7/',
      skills: ['ASP.NET', 'ASP.NET MVC', 'C#'],
      color: Color(0xFF512BD4),
    ),
    Certification(
      title: 'C# 12 Mastery: From Console Apps to Web Development',
      issuer: 'Udemy',
      date: 'Jan 2026',
      category: '.NET',
      credentialId: 'UC-028be2e6-316d-4352-9562-b1de9bedelde',
      link: 'https://www.udemy.com/certificate/UC-028be2e6-316d-4352-9562-b1de9bedelde/',
      skills: ['C#'],
      color: Color(0xFF512BD4),
    ),
    Certification(
      title: 'Docker MasterClass: Docker – Compose – SWARM – DevOps',
      issuer: 'Udemy',
      date: 'Dec 2025',
      category: 'DevOps',
      credentialId: 'UC-d45dbc33-c208-44e9-a9c4-655c96912424',
      link: 'https://www.udemy.com/certificate/UC-d45dbc33-c208-44e9-a9c4-655c96912424/',
      skills: ['Docker', 'DevOps'],
      color: Color(0xFF2496ED),
    ),
    Certification(
      title: 'Google Prompting Essentials',
      issuer: 'Google',
      date: 'Jul 2025',
      category: 'AI',
      credentialId: 'FFFUSE07WB3E',
      link: 'https://www.coursera.org/account/accomplishments/verify/FFFUSE07WB3E',
      skills: ['Prompt Engineering', 'Generative AI'],
      color: Color(0xFF4285F4),
    ),
    Certification(
      title: 'Introduction to Git and GitHub',
      issuer: 'Google',
      date: 'Jul 2025',
      category: 'DevOps',
      credentialId: 'VC6GFRYN0SA6',
      link: 'https://www.coursera.org/account/accomplishments/verify/VC6GFRYN0SA6',
      skills: ['Git', 'GitHub'],
      color: Color(0xFFF05032),
    ),
    Certification(
      title: 'Crash Course on Python',
      issuer: 'Google',
      date: 'Jul 2025',
      category: 'Other',
      credentialId: 'DEKIOCTCC9HK',
      link: 'https://www.coursera.org/account/accomplishments/verify/DEKIOCTCC9HK',
      skills: ['Python'],
      color: Color(0xFF3776AB),
    ),
    Certification(
      title: 'Ultimate YAML Course: YAML JSON JSONPath Zero to Master',
      issuer: 'Udemy',
      date: 'Jul 2025',
      category: 'DevOps',
      credentialId: 'UC-e8109738-fdc3-4650-8093-7780e2ad975b',
      link: 'https://www.udemy.com/certificate/UC-e8109738-fdc3-4650-8093-7780e2ad975b/',
      skills: ['YAML', 'JSON', 'DevOps'],
      color: Color(0xFFCB171E),
    ),
    Certification(
      title: 'Computer Networks Fundamentals',
      issuer: 'Udemy',
      date: 'Jul 2025',
      category: 'Other',
      credentialId: 'UC-0af79858-5858-40c3-ae89-48f7223f008c',
      link: 'https://www.udemy.com/certificate/UC-0af79858-5858-40c3-ae89-48f7223f008c/',
      skills: ['Networking'],
      color: Color(0xFF00b4d8),
    ),
  ];

  static const List<WhyMeFeature> whyMeFeatures = [
    WhyMeFeature(
      icon: FontAwesomeIcons.headset,
      title: '24/7 Support',
      desc: 'Available round the clock for any development needs. Your project gets the attention it deserves, any time of day.',
      color: Color(0xFFe040fb),
      tag: 'Reliable',
    ),
    WhyMeFeature(
      icon: FontAwesomeIcons.bolt,
      title: 'Fast & Reliable',
      desc: 'Delivering high-performance web solutions with speed and precision — efficiency without compromising quality.',
      color: Color(0xFF7c3aed),
      tag: 'Efficient',
    ),
    WhyMeFeature(
      icon: FontAwesomeIcons.arrowsRotate,
      title: 'Adaptable',
      desc: 'Adapting seamlessly to unique project requirements. From startups to enterprises, solutions tailored to fit any scope.',
      color: Color(0xFF00e5ff),
      tag: 'Flexible',
    ),
    WhyMeFeature(
      icon: FontAwesomeIcons.shieldHalved,
      title: 'Security-First',
      desc: 'Security baked in from day one — JWT auth, CNIC verification, data encryption, and secure REST APIs.',
      color: Color(0xFFf59e0b),
      tag: 'Secure',
    ),
    WhyMeFeature(
      icon: FontAwesomeIcons.mobileScreen,
      title: 'Fully Responsive',
      desc: 'Every interface is crafted to look and work flawlessly across all devices — mobile, tablet, and desktop.',
      color: Color(0xFF00e676),
      tag: 'Cross-Device',
    ),
    WhyMeFeature(
      icon: FontAwesomeIcons.rocket,
      title: 'Cloud-Native Scale',
      desc: 'Architecture designed to grow with your product. AWS, Docker, CI/CD pipelines — built for real-world scale.',
      color: Color(0xFF40c4ff),
      tag: 'Scalable',
    ),
    WhyMeFeature(
      icon: FontAwesomeIcons.bullseye,
      title: 'Deadline-Driven',
      desc: 'I treat deadlines as commitments, not suggestions. Projects are delivered on time, tested, and ready to ship.',
      color: Color(0xFFff4081),
      tag: 'Punctual',
    ),
    WhyMeFeature(
      icon: FontAwesomeIcons.comments,
      title: 'Open Communication',
      desc: 'Transparent updates, regular check-ins, and honest feedback throughout the entire project lifecycle.',
      color: Color(0xFFffab40),
      tag: 'Collaborative',
    ),
  ];

  static const List<BlogArticle> articles = [
    BlogArticle(
      title: 'Deploying Dual NGINX Servers on AWS EC2 with Docker',
      date: 'September 2025',
      readTime: '8 min read',
      desc: 'A deep dive into container isolation, volume mounting, and static content serving using Docker on an EC2 instance.',
      tag: 'DevOps',
      link: 'https://www.linkedin.com/in/farmanullah-ansari',
      color: Color(0xFF7c3aed),
    ),
    BlogArticle(
      title: 'The Future of Cashless Bartering in Pakistan',
      date: 'March 2026',
      readTime: '6 min read',
      desc: 'How we built Gadd Kaam using the MERN stack to digitise traditional skill swapping and combat economic inflation.',
      tag: 'MERN Stack',
      link: 'https://www.linkedin.com/in/farmanullah-ansari',
      color: Color(0xFFe040fb),
    ),
  ];
}
