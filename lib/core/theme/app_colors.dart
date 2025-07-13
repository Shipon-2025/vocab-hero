import 'package:flutter/material.dart';

/// App color palette based on the Vocab Hero brand guidelines
class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFF00A99D); // Vibrant Teal
  static const Color primaryLight = Color(0xFF33BBAF);
  static const Color primaryDark = Color(0xFF00877B);
  
  // Secondary Colors
  static const Color secondary = Color(0xFFFFD100); // Sunshine Yellow
  static const Color secondaryLight = Color(0xFFFFDA33);
  static const Color secondaryDark = Color(0xFFCCA700);
  
  // Accent Colors
  static const Color accent = Color(0xFFFF6B6B); // Warm Coral
  static const Color accentLight = Color(0xFFFF8A8A);
  static const Color accentDark = Color(0xFFE55555);
  
  // Success & Achievement
  static const Color success = Color(0xFF7ED321); // Bright Green
  static const Color successLight = Color(0xFF95DC47);
  static const Color successDark = Color(0xFF65A91A);
  
  // Neutral Colors
  static const Color background = Color(0xFFF7F8FA); // Off-white
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF1F3F5);
  
  // Text Colors
  static const Color textPrimary = Color(0xFF2C3E50); // Deep charcoal
  static const Color textSecondary = Color(0xFF6C7B7F);
  static const Color textTertiary = Color(0xFF9AA5AA);
  static const Color textOnPrimary = Color(0xFFFFFFFF);
  
  // Border & Divider
  static const Color border = Color(0xFFD1D8E0); // Light grey
  static const Color divider = Color(0xFFE8EAED);
  
  // Status Colors
  static const Color error = Color(0xFFE74C3C);
  static const Color warning = Color(0xFFF39C12);
  static const Color info = Color(0xFF3498DB);
  
  // Gradient Colors
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, primaryLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient successGradient = LinearGradient(
    colors: [success, successLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient accentGradient = LinearGradient(
    colors: [accent, accentLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  // XP & Level Colors
  static const Color xpBarBackground = Color(0xFFE8F4F8);
  static const Color xpBarFill = primary;
  
  // Streak Colors
  static const Color streakFlame = Color(0xFFFF6B35);
  static const Color streakBackground = Color(0xFFFFF3E0);
  
  // Quiz Colors
  static const Color quizCorrect = success;
  static const Color quizIncorrect = accent;
  static const Color quizNeutral = Color(0xFFF5F7FA);
  
  // Pronunciation Colors
  static const Color pronunciationPoor = accent;
  static const Color pronunciationGood = warning;
  static const Color pronunciationExcellent = success;
  
  // Dark Theme Colors (for future implementation)
  static const Color darkBackground = Color(0xFF1A1A1A);
  static const Color darkSurface = Color(0xFF2D2D2D);
  static const Color darkTextPrimary = Color(0xFFFFFFFF);
  static const Color darkTextSecondary = Color(0xFFB0B0B0);
}
