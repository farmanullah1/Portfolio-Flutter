import 'package:flutter/material.dart';

class Project {
  final String title;
  final IconData icon;
  final String desc;
  final List<String> tech;
  final String live;
  final String code;
  final bool featured;

  const Project({
    required this.title,
    required this.icon,
    required this.desc,
    required this.tech,
    required this.live,
    required this.code,
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

class SkillCategory {
  final String title;
  final IconData icon;
  final Color color;
  final List<String> skills;

  const SkillCategory({
    required this.title,
    required this.icon,
    required this.color,
    required this.skills,
  });
}

class SkillMarqueeItem {
  final String name;
  final IconData icon;
  const SkillMarqueeItem({required this.name, required this.icon});
}

class HeroStat {
  final String num;
  final String label;
  const HeroStat({required this.num, required this.label});
}
