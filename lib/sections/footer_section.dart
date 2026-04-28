import 'package:flutter/material.dart';
import '../theme.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 40),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: Column(
        children: [
          const Text(
            "Farmanullah Ansari",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.c1),
          ),
          const SizedBox(height: 12),
          Text(
            "Designed and built with ❤️ using Flutter",
            style: TextStyle(fontSize: 14, color: AppColors.textDim),
          ),
          const SizedBox(height: 8),
          const Text(
            "© 2026 All Rights Reserved",
            style: TextStyle(fontSize: 12, color: AppColors.textDim),
          ),
        ],
      ),
    );
  }
}
