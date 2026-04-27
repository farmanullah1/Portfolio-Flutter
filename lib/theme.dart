import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: const Color(0xFF7c3aed),
    scaffoldBackgroundColor: const Color(0xFFf8fafc),
    textTheme: GoogleFonts.interTextTheme(ThemeData.light().textTheme),
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF7c3aed),
      secondary: Color(0xFF00e5ff),
      surface: Colors.white,
      background: Color(0xFFf8fafc),
      onPrimary: Colors.white,
    ),
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: const Color(0xFF7c3aed),
    scaffoldBackgroundColor: const Color(0xFF0f172a),
    textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF7c3aed),
      secondary: Color(0xFF00e5ff),
      surface: Color(0xFF1e293b),
      background: Color(0xFF0f172a),
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
