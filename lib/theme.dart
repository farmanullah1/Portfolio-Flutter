import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // Backgrounds
  static const Color bg = Color(0xFF05010E);
  static const Color bg2 = Color(0xFF090117);
  static const Color bgCard = Color(0xAD0F0724); // 0.68 opacity
  static const Color bgCardLight = Color(0xD1FFFFFF); // 0.82 opacity
  static const Color navbarBg = Color(0xE005010E); // 0.88 opacity
  static const Color navbarBgLight = Color(0xEBFAF5FF); // 0.92 opacity

  // Text
  static const Color text = Color(0xFFF0ECFF);
  static const Color textMuted = Color(0xFFBFB4E0);
  static const Color textDim = Color(0xFF7F72AA);

  static const Color textLight = Color(0xFF150933);
  static const Color textMutedLight = Color(0xFF4A2E7C);
  static const Color textDimLight = Color(0xFF7B55A8);

  // Borders
  static const Color border = Color(0x11FFFFFF); // 0.065 opacity
  static const Color borderLight = Color(0x1A7C3AED); // 0.1 opacity
  static const Color borderGlow = Color(0x73AA64FF); // 0.45 opacity

  // Accent Colors
  static const Color c1 = Color(0xFFE040FB); // magenta-pink
  static const Color c2 = Color(0xFF7C3AED); // violet
  static const Color c3 = Color(0xFF00E5FF); // electric cyan
  static const Color c4 = Color(0xFF00E676); // neon green
  static const Color c5 = Color(0xFFFFAB40); // amber
  static const Color c6 = Color(0xFFFF4081); // hot rose
  static const Color c7 = Color(0xFF40C4FF); // sky blue

  // Glows
  static const Color glow1 = Color(0x80E040FB);
  static const Color glow2 = Color(0x807C3AED);
  static const Color glow3 = Color(0x7300E5FF);
}

class AppTheme {
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.bg,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.c1,
      secondary: AppColors.c2,
      surface: AppColors.bgCard,
    ),
    textTheme: GoogleFonts.outfitTextTheme(ThemeData.dark().textTheme).copyWith(
      bodyLarge: GoogleFonts.outfit(color: AppColors.text),
      bodyMedium: GoogleFonts.outfit(color: AppColors.textMuted),
    ),
  );

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: const Color(0xFFFAF5FF),
    colorScheme: const ColorScheme.light(
      primary: AppColors.c2,
      secondary: AppColors.c1,
      surface: Colors.white,
    ),
    textTheme: GoogleFonts.outfitTextTheme(ThemeData.light().textTheme).copyWith(
      bodyLarge: GoogleFonts.outfit(color: AppColors.textLight),
      bodyMedium: GoogleFonts.outfit(color: AppColors.textMutedLight),
    ),
  );
}

class ThemeProvider with ChangeNotifier {
  bool _isDark = true;
  bool get isDark => _isDark;

  void toggleTheme() {
    _isDark = !_isDark;
    notifyListeners();
  }
}
