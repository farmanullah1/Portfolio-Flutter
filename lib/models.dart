import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Project {
  final String title;
  final String desc;
  final List<String> tech;
  final String live;
  final String code;
  final bool featured;
  final IconData icon;

  const Project({
    required this.title,
    required this.desc,
    required this.tech,
    required this.live,
    required this.code,
    this.featured = false,
    required this.icon,
  });
}

class ExperienceData {
  final String title;
  final String company;
  final String date;
  final String type;
  final List<String> bullets;

  const ExperienceData({
    required this.title,
    required this.company,
    required this.date,
    required this.type,
    required this.bullets,
  });
}

class CertificationData {
  final String title;
  final String issuer;
  final String date;
  final String category;
  final String credentialId;
  final String link;
  final List<String> skills;
  final Color color;

  const CertificationData({
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
  ];

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
      desc: 'Nexa Habit is a modern, high-performance habit tracking web application designed with a Glassmorphism aesthetic.',
      tech: ['React.js', 'Framer Motion', 'OpenWeatherMap', 'WeatherAPI'],
      live: 'https://farmanullah1.github.io/Nexa-Habit-Habit-Tracker-App/',
      code: 'https://github.com/farmanullah1/Nexa-Habit-Habit-Tracker-App',
    ),
    Project(
      title: 'SkyCast - Weather Dashboard',
      icon: FontAwesomeIcons.cloudSun,
      desc: 'A fully functional, modern, and animated Weather Dashboard built with React, Vite, Framer Motion.',
      tech: ['React.js', 'Framer Motion', 'Tailwind CSS'],
      live: 'https://farmanullah1.github.io/SkyCast--Weather-Dashboard/',
      code: 'https://github.com/farmanullah1/SkyCast--Weather-Dashboard',
    ),
    // Additional projects omitted for brevity, adding a few key ones
    Project(
      title: 'Taskly - Modern Todo Task Manager App',
      icon: FontAwesomeIcons.listCheck,
      desc: 'A sleek and efficient task management application with a beautiful glassmorphism UI.',
      tech: ['React.js', 'Framer Motion', 'Tailwind CSS'],
      live: 'https://farmanullah1.github.io/Taskly---Modern-Todo-Task-Manager-App/',
      code: 'https://github.com/farmanullah1/Taskly---Modern-Todo-Task-Manager-App',
    ),
  ];

  static const List<ExperienceData> experiences = [
    ExperienceData(
      title: 'Web Development Intern',
      company: 'PS CODERS',
      date: 'Jul 2024 – Oct 2024',
      type: 'work',
      bullets: [
        'Engineered dynamic and responsive front-end interfaces.',
        'Collaborated with cross-functional teams to optimise UI/UX.',
        'Ensured cross-browser compatibility and clean architecture.'
      ],
    ),
    ExperienceData(
      title: 'Cloud Computing Fellow',
      company: 'ACM UET Lahore',
      date: 'Jun 2024 – Aug 2024',
      type: 'work',
      bullets: [
        'Gained hands-on experience in cloud infrastructure, DevOps practices.',
        'Deployed scalable web applications leveraging AWS services.',
        'Implemented containerised environments using Docker.'
      ],
    ),
    ExperienceData(
      title: 'BS Software Engineering',
      company: 'University of Sindh',
      date: 'Jan 2022 – Dec 2025',
      type: 'education',
      bullets: [
        'Mastered core computer science principles.',
        'Developed Gadd Kaam – SkillSwap Pakistan as Final Year Project.',
        'Earned multiple certifications in .NET, React.js, Docker.'
      ],
    ),
  ];

  static const List<CertificationData> certs = [
    CertificationData(
      title: 'React Crash Course: From Zero to Hero',
      issuer: 'Udemy',
      date: 'Mar 2026',
      category: 'React',
      credentialId: 'UC-a83ae4f4...',
      link: 'https://www.udemy.com/certificate/UC-a83ae4f4...',
      skills: ['React.js'],
      color: Color(0xFF61DAFB),
    ),
    CertificationData(
      title: 'Microsoft Power BI – Complete Beginner to Advanced 2026',
      issuer: 'Udemy',
      date: 'Mar 2026',
      category: 'Other',
      credentialId: 'UC-53b26ea4...',
      link: 'https://www.udemy.com/certificate/UC-53b26ea4...',
      skills: ['Power BI'],
      color: Color(0xFFF2C811),
    ),
    CertificationData(
      title: 'Complete ASP.NET Core MVC 6 with Real-World Projects',
      issuer: 'Udemy',
      date: 'Jan 2026',
      category: '.NET',
      credentialId: 'UC-0d9450f9...',
      link: 'https://www.udemy.com/certificate/UC-0d9450f9...',
      skills: ['ASP.NET', 'ASP.NET MVC', 'C#'],
      color: Color(0xFF512BD4),
    ),
  ];
}
