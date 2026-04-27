import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // Dark Theme
  static const Color bg = Color(0xFF05010e);
  static const Color bg2 = Color(0xFF090117);
  static const Color bgCard = Color(0xAD0F0724); // rgba(15, 7, 36, 0.68)
  static const Color bgCardHover = Color(0xD9160B32); // rgba(22, 11, 50, 0.85)
  static const Color navbarBg = Color(0xE005010E); // rgba(5, 1, 14, 0.88)
  
  static const Color text = Color(0xFFf0ecff);
  static const Color textMuted = Color(0xFFbfb4e0);
  static const Color textDim = Color(0xFF7f72aa);

  static const Color border = Color(0x11FFFFFF); // rgba(255,255,255,0.065)
  static const Color borderGlow = Color(0x73AA64FF); // rgba(170,100,255,0.45)

  // Vivid Accents
  static const Color c1 = Color(0xFFe040fb); // magenta-pink
  static const Color c2 = Color(0xFF7c3aed); // violet
  static const Color c3 = Color(0xFF00e5ff); // electric cyan
  static const Color c4 = Color(0xFF00e676); // neon green
  static const Color c5 = Color(0xFFffab40); // amber
  static const Color c6 = Color(0xFFff4081); // hot rose
  static const Color c7 = Color(0xFF40c4ff); // sky blue

  // Light Theme
  static const Color bgLight = Color(0xFFfaf5ff);
  static const Color bg2Light = Color(0xFFf0e6ff);
  static const Color textLight = Color(0xFF150933);
  static const Color textMutedLight = Color(0xFF4a2e7c);
}

class AppTheme {
  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.bg,
    primaryColor: AppColors.c2,
    hintColor: AppColors.c1,
    textTheme: GoogleFonts.outfitTextTheme(ThemeData.dark().textTheme).copyWith(
      bodyLarge: GoogleFonts.outfit(color: AppColors.text),
      bodyMedium: GoogleFonts.outfit(color: AppColors.textMuted),
      displayLarge: GoogleFonts.outfit(color: AppColors.text, fontWeight: FontWeight.w900),
    ),
    colorScheme: const ColorScheme.dark(
      primary: AppColors.c2,
      secondary: AppColors.c3,
      surface: AppColors.bgCard,
      background: AppColors.bg,
      onPrimary: Colors.white,
    ),
  );

  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.bgLight,
    primaryColor: AppColors.c2,
    textTheme: GoogleFonts.outfitTextTheme(ThemeData.light().textTheme),
    colorScheme: const ColorScheme.light(
      primary: AppColors.c2,
      secondary: AppColors.c3,
      surface: Colors.white,
      background: AppColors.bgLight,
      onPrimary: Colors.white,
    ),
  );
}

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.dark;
  ThemeMode get themeMode => _themeMode;
  bool get isDark => _themeMode == ThemeMode.dark;

  void toggleTheme() {
    _themeMode = isDark ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }
}
