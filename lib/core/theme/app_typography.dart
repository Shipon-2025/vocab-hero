import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Typography system for Vocab Hero app
class AppTypography {
  // English Typography (Poppins)
  static TextStyle get displayLarge => GoogleFonts.poppins(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    height: 1.2,
  );
  
  static TextStyle get displayMedium => GoogleFonts.poppins(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    height: 1.2,
  );
  
  static TextStyle get displaySmall => GoogleFonts.poppins(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.3,
  );
  
  static TextStyle get headlineLarge => GoogleFonts.poppins(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.3,
  );
  
  static TextStyle get headlineMedium => GoogleFonts.poppins(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.3,
  );
  
  static TextStyle get headlineSmall => GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.4,
  );
  
  static TextStyle get titleLarge => GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.4,
  );
  
  static TextStyle get titleMedium => GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    height: 1.4,
  );
  
  static TextStyle get titleSmall => GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
    height: 1.4,
  );
  
  static TextStyle get bodyLarge => GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
    height: 1.5,
  );
  
  static TextStyle get bodyMedium => GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
    height: 1.5,
  );
  
  static TextStyle get bodySmall => GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
    height: 1.5,
  );
  
  static TextStyle get labelLarge => GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    height: 1.4,
  );
  
  static TextStyle get labelMedium => GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
    height: 1.4,
  );
  
  static TextStyle get labelSmall => GoogleFonts.poppins(
    fontSize: 10,
    fontWeight: FontWeight.w500,
    color: AppColors.textTertiary,
    height: 1.4,
  );
  
  // Bangla Typography (Hind Siliguri)
  static TextStyle get banglaTitleLarge => const TextStyle(
    fontFamily: 'HindSiliguri',
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.6,
  );
  
  static TextStyle get banglaTitleMedium => const TextStyle(
    fontFamily: 'HindSiliguri',
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    height: 1.6,
  );
  
  static TextStyle get banglaBodyLarge => const TextStyle(
    fontFamily: 'HindSiliguri',
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
    height: 1.7,
  );
  
  static TextStyle get banglaBodyMedium => const TextStyle(
    fontFamily: 'HindSiliguri',
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
    height: 1.7,
  );
  
  static TextStyle get banglaBodySmall => const TextStyle(
    fontFamily: 'HindSiliguri',
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
    height: 1.7,
  );
  
  // Special Purpose Styles
  static TextStyle get wordDisplay => GoogleFonts.poppins(
    fontSize: 36,
    fontWeight: FontWeight.bold,
    color: AppColors.primary,
    height: 1.2,
  );
  
  static TextStyle get buttonText => GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textOnPrimary,
    height: 1.2,
  );
  
  static TextStyle get captionText => GoogleFonts.poppins(
    fontSize: 11,
    fontWeight: FontWeight.normal,
    color: AppColors.textTertiary,
    height: 1.3,
  );
  
  static TextStyle get overlineText => GoogleFonts.poppins(
    fontSize: 10,
    fontWeight: FontWeight.w500,
    color: AppColors.textTertiary,
    height: 1.3,
    letterSpacing: 0.5,
  );
}
