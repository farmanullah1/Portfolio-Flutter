import 'package:flutter/material.dart';
import '../theme.dart';

class TypingCursor extends StatelessWidget {
  const TypingCursor({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 2,
      height: 24,
      margin: const EdgeInsets.only(left: 4),
      color: AppColors.c1,
    );
  }
}
