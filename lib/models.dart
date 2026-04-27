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

  const Project({
    required this.title,
    required this.desc,
    required this.tech,
    required this.live,
    required this.code,
    required this.icon,
    this.featured = false,
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
      icon: FontAwesomeIcons.sun,
      desc: 'A fully functional, modern, and animated Weather Dashboard featuring real-time weather data, 5-day forecast, hourly forecast, and stunning dynamic backgrounds.',
      tech: ['React.js', 'Framer Motion', 'Tailwind CSS'],
      live: 'https://farmanullah1.github.io/SkyCast--Weather-Dashboard/',
      code: 'https://github.com/farmanullah1/SkyCast--Weather-Dashboard',
    ),
    Project(
      title: 'Taskly - Modern Todo Task Manager App - React.js',
      icon: FontAwesomeIcons.clipboardList,
      desc: 'A sleek and efficient task management application with a beautiful glassmorphism UI, task persistence, and smooth Framer Motion animations.',
      tech: ['React.js', 'Framer Motion', 'Tailwind CSS'],
      live: 'https://farmanullah1.github.io/Taskly---Modern-Todo-Task-Manager-App/',
      code: 'https://github.com/farmanullah1/Taskly---Modern-Todo-Task-Manager-App',
    ),
    Project(
      title: 'BalanceByte - ASP.NET Core',
      icon: FontAwesomeIcons.dollarSign,
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
      desc: 'A beautiful, fully responsive memory card matching game built with React, TypeScript, and Vite featuring smooth animations and high score tracking.',
      tech: ['React.js', 'TypeScript', 'Vite'],
      live: 'https://farmanullah1.github.io/Memory-Card-Matching-Game/',
      code: 'https://github.com/farmanullah1/Memory-Card-Matching-Game',
    ),
    Project(
      title: 'TextRepeat Studio',
      icon: FontAwesomeIcons.copy,
      desc: 'Highly efficient text manipulation and repetition tool built with React for rapid content generation and formatting.',
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
      icon: FontAwesomeIcons.tabletScreenButton,
      desc: 'Mobile balance checker with smooth transitions that calculates total balance after loading a specific amount.',
      tech: ['React.js', 'Framer Motion', 'Tailwind CSS'],
      live: 'https://farmanullah1.github.io/BalanceWave-React/',
      code: 'https://github.com/farmanullah1/BalanceWave-React',
    ),
    Project(
      title: 'Stone, Paper, Scissors',
      icon: FontAwesomeIcons.handBackFist,
      desc: 'Interactive browser game featuring dynamic UI updates and classic game logic.',
      tech: ['HTML', 'CSS', 'JavaScript'],
      live: 'https://farmanullah1.github.io/Stone-Paper-Scissors-Game-HTML-CSS-JS/',
      code: 'https://github.com/farmanullah1/Stone-Paper-Scissors-Game-HTML-CSS-JS',
    ),
    Project(
      title: 'TextUtils Studio',
      icon: FontAwesomeIcons.penToSquare,
      desc: 'Premium text manipulation toolkit with 100+ formatting, extraction, and cryptography tools.',
      tech: ['React.js', 'Bootstrap'],
      live: 'https://farmanullah1.github.io/TextUtils-React.js/',
      code: 'https://github.com/farmanullah1/TextUtils-React.js',
    ),
    Project(
      title: 'Tic-Tac-Toe',
      icon: FontAwesomeIcons.xmark,
      desc: 'A classic Tic-Tac-Toe web game featuring responsive design and state management.',
      tech: ['HTML', 'CSS', 'JavaScript'],
      live: 'https://farmanullah1.github.io/Tic-Tac-Toe-HTML-CSS-JS/',
      code: 'https://github.com/farmanullah1/Tic-Tac-Toe-HTML-CSS-JS',
    ),
    Project(
      title: 'Modern Tetris',
      icon: FontAwesomeIcons.tableCells,
      desc: 'A sleek, TypeScript-powered rendition of Tetris featuring fluid animations and progressive difficulty.',
      tech: ['TypeScript', 'HTML5 Canvas', 'CSS3'],
      live: 'https://farmanullah1.github.io/Modern-Tetris/',
      code: 'https://github.com/farmanullah1/Modern-Tetris',
    ),
    Project(
      title: 'Classic Snake Game',
      icon: FontAwesomeIcons.circleUp,
      desc: 'High-performance Snake game built with TypeScript, emphasizing clean code architecture.',
      tech: ['TypeScript', 'CSS', 'JavaScript'],
      live: 'https://farmanullah1.github.io/Snake-Game/',
      code: 'https://github.com/farmanullah1/Snake-Game',
    ),
    Project(
      title: 'Old Portfolio - (2024)',
      icon: FontAwesomeIcons.terminal,
      desc: 'My 2024 Portfolio Website built with HTML, CSS and JavaScript.',
      tech: ['HTML', 'CSS', 'JavaScript', 'Web Basics'],
      live: 'https://farmanullah1.github.io/Portfolio-2024/',
      code: 'https://github.com/farmanullah1/Portfolio-2024',
    ),
    Project(
      title: 'Portfolio - HTML CSS JS (2025)',
      icon: FontAwesomeIcons.terminal,
      desc: 'My Old portfolio website made with HTML, CSS and JavaScript.',
      tech: ['HTML', 'CSS', 'JavaScript', 'GSAP'],
      live: 'https://farmanullah1.github.io/Portfolio-HTML-CSS-JS/',
      code: 'https://github.com/farmanullah1/Portfolio-HTML-CSS-JS',
    ),
    Project(
      title: 'MyPortfolio - (Latest - 2026)',
      icon: FontAwesomeIcons.code,
      desc: 'My Portfolio Website built with React.js, emphasizing clean code architecture and responsive controls.',
      tech: ['React.js', 'CSS', 'JavaScript', 'GSAP'],
      live: 'https://farmanullah1.github.io/My-Portfolio/',
      code: 'https://github.com/farmanullah1/My-Portfolio',
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
        "Developed 'Gadd Kaam – SkillSwap Pakistan' as Final Year Project: a secure MERN-stack platform for cashless skill trading.",
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
