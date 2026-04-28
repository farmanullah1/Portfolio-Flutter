import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HeroData {
  static const List<String> roles = [
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

  static const List<Map<String, dynamic>> socials = [
    { 'icon': FontAwesomeIcons.github, 'url': 'https://github.com/farmanullah1', 'label': 'GitHub' },
    { 'icon': FontAwesomeIcons.linkedin, 'url': 'https://www.linkedin.com/in/farmanullah-ansari', 'label': 'LinkedIn' },
  ];

  static const List<Map<String, String>> stats = [
    { 'num': '3+', 'label': 'Years Coding' },
    { 'num': '10+', 'label': 'Projects Built' },
    { 'num': '10+', 'label': 'Certifications' },
  ];
}

class Skill {
  final String name;
  final IconData icon;
  final Color? color;
  Skill({required this.name, required this.icon, this.color});
}

class SkillCategory {
  final String title;
  final Color color;
  final List<String> skills;
  SkillCategory({required this.title, required this.color, required this.skills});
}

class SkillsData {
  static List<Skill> marquee = [
    Skill(name: 'C#', icon: FontAwesomeIcons.code),
    Skill(name: 'ASP.NET Core', icon: FontAwesomeIcons.networkWired),
    Skill(name: 'React.js', icon: FontAwesomeIcons.react),
    Skill(name: 'Node.js', icon: FontAwesomeIcons.nodeJs),
    Skill(name: 'MongoDB', icon: FontAwesomeIcons.database),
    Skill(name: 'Express.js', icon: FontAwesomeIcons.server),
    Skill(name: 'Docker', icon: FontAwesomeIcons.docker),
    Skill(name: 'AWS', icon: FontAwesomeIcons.aws),
    Skill(name: 'Python', icon: FontAwesomeIcons.python),
    Skill(name: 'Linux', icon: FontAwesomeIcons.linux),
    Skill(name: 'Git & GitHub', icon: FontAwesomeIcons.github),
    Skill(name: 'Power BI', icon: FontAwesomeIcons.chartBar),
    Skill(name: 'TypeScript', icon: FontAwesomeIcons.code),
    Skill(name: 'Tailwind', icon: FontAwesomeIcons.wind),
  ];

  static List<SkillCategory> categories = [
    SkillCategory(title: 'Frontend', color: Color(0xFFE040FB), skills: ['React.js', 'TypeScript', 'Tailwind CSS', 'HTML5 / CSS3', 'Framer Motion']),
    SkillCategory(title: 'Backend', color: Color(0xFF7C3AED), skills: ['Node.js', 'Express.js', 'ASP.NET Core', 'C#', 'REST APIs']),
    SkillCategory(title: 'Database & Cloud', color: Color(0xFF00E5FF), skills: ['MongoDB', 'SQL Server', 'AWS EC2 / EB', 'Docker', 'Linux']),
    SkillCategory(title: 'Tools & Other', color: Color(0xFFFFAB40), skills: ['Git & GitHub', 'Power BI', 'Python', 'Figma', 'Postman']),
  ];
}

class Project {
  final String title;
  final IconData icon;
  final String desc;
  final List<String> tech;
  final String live;
  final String code;
  final bool featured;
  Project({required this.title, required this.icon, required this.desc, required this.tech, required this.live, required this.code, this.featured = false});
}

class ProjectsData {
  static List<Project> projects = [
    Project(
      title: 'Gadd Kaam — SkillSwap Pakistan -MERN Stack',
      icon: FontAwesomeIcons.users,
      desc: 'A secure, MERN-stack platform for cashless skill exchanging featuring CNIC verification and real-time trading.',
      tech: ['MongoDB', 'Express.js', 'React.js', 'Node.js'],
      live: 'https://gadd-kaam-skillswap-pakistan.netlify.app/',
      code: 'https://github.com/farmanullah1/Gadd-Kaam-SkillSwap-Pakistan',
      featured: true,
    ),
    Project(
      title: 'Nexa-Habit-Habit-Tracker-App',
      icon: FontAwesomeIcons.sun,
      desc: 'Nexa Habit is a modern, high-performance habit tracking web application designed with a Glassmorphism aesthetic. It features soft gradients, deep blur effects, and smooth animations.',
      tech: ['React.js', 'Framer Motion', 'OpenWeatherMap', 'WeatherAPI'],
      live: 'https://farmanullah1.github.io/Nexa-Habit-Habit-Tracker-App/',
      code: 'https://github.com/farmanullah1/Nexa-Habit-Habit-Tracker-App',
    ),
    Project(
      title: 'SkyCast - Weather Dashboard - React.js',
      icon: FontAwesomeIcons.cloudSun,
      desc: 'A fully functional, modern, and animated Weather Dashboard built with React, Vite, Framer Motion. Features include real-time weather data, a 5-day forecast, and geolocation support.',
      tech: ['React.js', 'Framer Motion', 'Tailwind CSS'],
      live: 'https://farmanullah1.github.io/SkyCast--Weather-Dashboard/',
      code: 'https://github.com/farmanullah1/SkyCast--Weather-Dashboard',
    ),
    Project(
      title: 'Taskly - Modern Todo Task Manager App - React.js',
      icon: FontAwesomeIcons.clipboardList,
      desc: 'A sleek and efficient task management application with a beautiful glassmorphism UI, task persistence, and smooth animations.',
      tech: ['React.js', 'Framer Motion', 'Tailwind CSS'],
      live: 'https://farmanullah1.github.io/Taskly---Modern-Todo-Task-Manager-App/',
      code: 'https://github.com/farmanullah1/Taskly---Modern-Todo-Task-Manager-App',
    ),
    Project(
      title: 'BalanceByte - ASP.NET Core',
      icon: FontAwesomeIcons.moneyBillWave,
      desc: 'Simple mobile balance checker with smooth UI transitions that tells you how much total balance you will get if you load a specific amount.',
      tech: ['C#', 'ASP.NET Core', 'MVC', 'SQL Server'],
      live: '',
      code: 'https://github.com/farmanullah1/BalanceByte-ASP.NET-Core-MVC-App',
    ),
    Project(
      title: 'iNotebook - Cloud Notes',
      icon: FontAwesomeIcons.bookOpen,
      desc: 'Secure MERN stack application for managing notes on the cloud, featuring JWT authentication and persistent storage.',
      tech: ['Node.js', 'React.js', 'MongoDB', 'Express'],
      live: 'https://farmanullah1.github.io/iNotebook/',
      code: 'https://github.com/farmanullah1/iNotebook',
    ),
    Project(
      title: 'Kurrent News',
      icon: FontAwesomeIcons.globe,
      desc: 'A global news SPA featuring a Triple-API fallback architecture, infinite scrolling, and dark mode.',
      tech: ['React.js', 'NewsAPI', 'Bootstrap'],
      live: 'https://farmanullah1.github.io/Kurrent-News-Top-Headlines-Tech-Politics-Sports/',
      code: 'https://github.com/farmanullah1/Kurrent-News-Top-Headlines-Tech-Politics-Sports',
    ),
    Project(
      title: 'Memory Card Matching Game',
      icon: FontAwesomeIcons.puzzlePiece,
      desc: 'A beautiful, fully responsive memory card matching game built with React, TypeScript, and Vite.',
      tech: ['React.js', 'TypeScript', 'Vite'],
      live: 'https://farmanullah1.github.io/Memory-Card-Matching-Game/',
      code: 'https://github.com/farmanullah1/Memory-Card-Matching-Game',
    ),
    Project(
      title: 'TextRepeat Studio',
      icon: FontAwesomeIcons.copy,
      desc: 'Highly efficient text manipulation and repetition tool built with React for rapid content generation.',
      tech: ['React.js', 'JavaScript'],
      live: 'https://farmanullah1.github.io/TextRepeat---React/',
      code: 'https://github.com/farmanullah1/TextRepeat---React',
    ),
    Project(
      title: 'ASP.NET Core CRUD API',
      icon: FontAwesomeIcons.server,
      desc: 'Robust REST API demonstrating repository patterns, efficient CRUD operations, and modern .NET backend practices.',
      tech: ['C#', 'ASP.NET Core', 'Web API'],
      live: '',
      code: 'https://github.com/farmanullah1/CRUD-App-Using-ASP-Core-Web-API',
    ),
    Project(
      title: 'BalanceWave - React',
      icon: FontAwesomeIcons.mobileScreen,
      desc: 'Mobile balance checker that shows how much total balance you will get after loading a specific amount. Modern UI with smooth transitions.',
      tech: ['React.js', 'Framer Motion', 'Tailwind CSS'],
      live: 'https://farmanullah1.github.io/BalanceWave-React/',
      code: 'https://github.com/farmanullah1/BalanceWave-React',
    ),
    Project(
      title: 'Modern Tetris',
      icon: FontAwesomeIcons.grip,
      desc: 'A sleek, TypeScript-powered rendition of the classic arcade game featuring fluid animations and score tracking.',
      tech: ['TypeScript', 'HTML5 Canvas', 'CSS3'],
      live: 'https://farmanullah1.github.io/Modern-Tetris/',
      code: 'https://github.com/farmanullah1/Modern-Tetris',
    ),
  ];
}

class Experience {
  final String title;
  final String company;
  final String date;
  final String type;
  final List<String> bullets;
  Experience({required this.title, required this.company, required this.date, required this.type, required this.bullets});
}

class ExperienceData {
  static List<Experience> items = [
    Experience(
      title: 'Web Development Intern',
      company: 'PS CODERS',
      date: 'Jul 2024 – Oct 2024',
      type: 'work',
      bullets: [
        'Engineered dynamic and responsive front-end interfaces using modern web technologies.',
        'Collaborated with cross-functional teams to optimise UI/UX and improve performance.',
        'Ensured cross-browser compatibility and adhered to clean code architecture.'
      ],
    ),
    Experience(
      title: 'Cloud Computing Fellow',
      company: 'ACM UET Lahore',
      date: 'Jun 2024 – Aug 2024',
      type: 'work',
      bullets: [
        'Gained hands-on experience in cloud infrastructure, DevOps practices, and server management.',
        'Deployed scalable web applications leveraging AWS services including Elastic Beanstalk and EC2.',
        'Implemented containerised environments using Docker and multi-container NGINX.'
      ],
    ),
    Experience(
      title: 'BS Software Engineering',
      company: 'University of Sindh',
      date: 'Jan 2022 – Dec 2025',
      type: 'education',
      bullets: [
        'Mastered core computer science principles including Data Structures, OOP, and full-stack methodologies.',
        "Developed 'Gadd Kaam – SkillSwap Pakistan' as Final Year Project: a secure MERN-stack platform.",
        'Earned multiple certifications in .NET, React.js, Docker, and Cloud Fundamentals.'
      ],
    ),
  ];
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
  Certification({required this.title, required this.issuer, required this.date, required this.category, required this.credentialId, required this.link, required this.skills, required this.color});
}

class CertificationsData {
  static List<Certification> items = [
    Certification(title: 'React Crash Course: From Zero to Hero', issuer: 'Udemy', date: 'Mar 2026', category: 'React', credentialId: 'UC-a83ae4f4-9639-4595-a11e-abc632404393', link: 'https://www.udemy.com/certificate/UC-a83ae4f4-9639-4595-a11e-abc632404393/', skills: ['React.js'], color: Color(0xFF61DAFB)),
    Certification(title: 'Microsoft Power BI – Complete Beginner to Advanced 2026', issuer: 'Udemy', date: 'Mar 2026', category: 'Other', credentialId: 'UC-53b26ea4-79f3-4e29-8e53-9883cb4b01fa', link: 'https://www.udemy.com/certificate/UC-53b26ea4-79f3-4e29-8e53-9883cb4b01fa/', skills: ['Power BI'], color: Color(0xFFF2C811)),
    Certification(title: 'Complete ASP.NET Core MVC 6 with Real-World Projects', issuer: 'Udemy', date: 'Jan 2026', category: '.NET', credentialId: 'UC-0d9450f9-88c2-47c6-b833-2b4fb97af3c7', link: 'https://www.udemy.com/certificate/UC-0d9450f9-88c2-47c6-b833-2b4fb97af3c7/', skills: ['ASP.NET', 'ASP.NET MVC', 'C#'], color: Color(0xFF512BD4)),
    Certification(title: 'Docker MasterClass: Docker – Compose – SWARM – DevOps', issuer: 'Udemy', date: 'Dec 2025', category: 'DevOps', credentialId: 'UC-d45dbc33-c208-44e9-a9c4-655c96912424', link: 'https://www.udemy.com/certificate/UC-d45dbc33-c208-44e9-a9c4-655c96912424/', skills: ['Docker', 'DevOps'], color: Color(0xFF2496ED)),
    Certification(title: 'Google Prompting Essentials', issuer: 'Google', date: 'Jul 2025', category: 'AI', credentialId: 'FFFUSE07WB3E', link: 'https://www.coursera.org/account/accomplishments/verify/FFFUSE07WB3E', skills: ['Prompt Engineering', 'Generative AI'], color: Color(0xFF4285F4)),
  ];
}

class Feature {
  final IconData icon;
  final String title;
  final String desc;
  final Color color;
  final String tag;
  Feature({required this.icon, required this.title, required this.desc, required this.color, required this.tag});
}

class WhyMeData {
  static List<Feature> features = [
    Feature(icon: FontAwesomeIcons.headset, title: '24/7 Support', desc: 'Available round the clock for any development needs. Your project gets the attention it deserves.', color: Color(0xFFE040FB), tag: 'Reliable'),
    Feature(icon: FontAwesomeIcons.bolt, title: 'Fast & Reliable', desc: 'Delivering high-performance web solutions with speed and precision — efficiency without compromise.', color: Color(0xFF7C3AED), tag: 'Efficient'),
    Feature(icon: FontAwesomeIcons.shieldHalved, title: 'Security-First', desc: 'Security baked in from day one — JWT auth, data encryption, and secure REST APIs.', color: Color(0xFFF59E0B), tag: 'Secure'),
    Feature(icon: FontAwesomeIcons.mobileScreen, title: 'Fully Responsive', desc: 'Every interface is crafted to work flawlessly across all devices — mobile, tablet, and desktop.', color: Color(0xFF00E676), tag: 'Cross-Device'),
  ];
}

class Article {
  final String title;
  final String date;
  final String readTime;
  final String desc;
  final String tag;
  final String link;
  final Color color;
  Article({required this.title, required this.date, required this.readTime, required this.desc, required this.tag, required this.link, required this.color});
}

class BlogData {
  static List<Article> articles = [
    Article(title: 'Deploying Dual NGINX Servers on AWS EC2 with Docker', date: 'September 2025', readTime: '8 min read', desc: 'A deep dive into container isolation and volume mounting using Docker on EC2.', tag: 'DevOps', link: 'https://www.linkedin.com/in/farmanullah-ansari', color: Color(0xFF7C3AED)),
    Article(title: 'The Future of Cashless Bartering in Pakistan', date: 'March 2026', readTime: '6 min read', desc: 'How we built Gadd Kaam using the MERN stack to digitise traditional skill swapping.', tag: 'MERN Stack', link: 'https://www.linkedin.com/in/farmanullah-ansari', color: Color(0xFFE040FB)),
  ];
}
