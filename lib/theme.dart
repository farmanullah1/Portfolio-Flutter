import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // Shared
  static const Color c1 = Color(0xFFe040fb); // magenta-pink
  static const Color c2 = Color(0xFF7c3aed); // violet
  static const Color c3 = Color(0xFF00e5ff); // electric cyan
  static const Color c4 = Color(0xFF00e676); // neon green
  static const Color c5 = Color(0xFFffab40); // amber
  static const Color c6 = Color(0xFFff4081); // hot rose
  static const Color c7 = Color(0xFF40c4ff); // sky blue

  // Dark Theme
  static const Color bg = Color(0xFF05010e);
  static const Color bg2 = Color(0xFF090117);
  static const Color bgCard = Color(0xAD0F0724); 
  static const Color bgCardHover = Color(0xD9160B32); 
  static const Color navbarBg = Color(0xE005010E); 
  static const Color text = Color(0xFFf0ecff);
  static const Color textMuted = Color(0xFFbfb4e0);
  static const Color textDim = Color(0xFF7f72aa);
  static const Color border = Color(0x11FFFFFF);
  static const Color borderGlow = Color(0x73AA64FF);

  // Light Theme
  static const Color bgLight = Color(0xFFFDFBFF);
  static const Color bg2Light = Color(0xFFF3EFFF);
  static const Color bgCardLight = Color(0x99FFFFFF);
  static const Color bgCardHoverLight = Color(0xE6F8F3FF);
  static const Color navbarBgLight = Color(0xD9FFFFFF);
  static const Color textLight = Color(0xFF1A132C);
  static const Color textMutedLight = Color(0xFF5D5179);
  static const Color textDimLight = Color(0xFF9185AC);
  static const Color borderLight = Color(0x1A6347D1);
  static const Color borderGlowLight = Color(0x40e040fb);

  // Gradient Tokens
  static const List<Color> primaryGradient = [c1, c2];
  static const List<Color> secondaryGradient = [c3, c7];
  static const List<Color> accentGradient = [c5, c6];
  
  static const LinearGradient borderGradient = LinearGradient(
    colors: [Color(0x33FFFFFF), Color(0x0AFFFFFF), Color(0x33FFFFFF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient premiumGradient = LinearGradient(
    colors: [c1, c2, c3],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

class AppTheme {
  static final darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.bg,
    primaryColor: AppColors.c2,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.c2,
      secondary: AppColors.c3,
      surface: AppColors.bgCard,
      error: Colors.redAccent,
      onPrimary: Colors.white,
    ),
    textTheme: GoogleFonts.outfitTextTheme(ThemeData.dark().textTheme).copyWith(
      bodyLarge: GoogleFonts.outfit(color: AppColors.text),
      bodyMedium: GoogleFonts.outfit(color: AppColors.textMuted),
      displayLarge: GoogleFonts.outfit(color: AppColors.text, fontWeight: FontWeight.w900),
    ),
  );

  static final lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.bgLight,
    primaryColor: AppColors.c2,
    colorScheme: ColorScheme.light(
      primary: AppColors.c2,
      secondary: AppColors.c3,
      surface: AppColors.bgCardLight,
      error: Colors.red,
      onPrimary: Colors.white,
      onSurface: AppColors.textLight,
    ),
    textTheme: GoogleFonts.outfitTextTheme(ThemeData.light().textTheme).copyWith(
      bodyLarge: GoogleFonts.outfit(color: AppColors.textLight),
      bodyMedium: GoogleFonts.outfit(color: AppColors.textMutedLight),
      displayLarge: GoogleFonts.outfit(color: AppColors.textLight, fontWeight: FontWeight.w900),
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
