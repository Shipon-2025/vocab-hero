import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/providers/app_state_provider.dart';
import '../../../core/services/navigation_service.dart';
import 'welcome_screen.dart';
import '../../home/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    final appState = context.read<AppStateProvider>();
    
    // Load app settings
    await appState.loadSettings();
    
    // Wait for splash animation
    await Future.delayed(const Duration(seconds: 3));
    
    // Navigate based on app state
    if (mounted) {
      if (appState.isOnboardingComplete) {
        NavigationService.pushReplacementNamed('/home');
      } else {
        NavigationService.pushReplacement(const WelcomeScreen());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // App Logo/Mascot
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: AppColors.textOnPrimary,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryDark.withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.school,
                  size: 60,
                  color: AppColors.primary,
                ),
              )
                .animate()
                .scale(
                  duration: 800.ms,
                  curve: Curves.elasticOut,
                )
                .then()
                .shimmer(
                  duration: 1500.ms,
                  color: AppColors.secondary.withOpacity(0.3),
                ),
              
              const SizedBox(height: 32),
              
              // App Name
              Text(
                'Vocab Hero',
                style: AppTypography.displayLarge.copyWith(
                  color: AppColors.textOnPrimary,
                  fontWeight: FontWeight.bold,
                ),
              )
                .animate()
                .fadeIn(delay: 400.ms, duration: 600.ms)
                .slideY(begin: 0.3, end: 0),
              
              const SizedBox(height: 8),
              
              // Tagline
              Text(
                'Master English, One Word at a Time',
                style: AppTypography.bodyLarge.copyWith(
                  color: AppColors.textOnPrimary.withOpacity(0.9),
                ),
                textAlign: TextAlign.center,
              )
                .animate()
                .fadeIn(delay: 800.ms, duration: 600.ms)
                .slideY(begin: 0.3, end: 0),
              
              const SizedBox(height: 64),
              
              // Loading Indicator
              SizedBox(
                width: 40,
                height: 40,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AppColors.textOnPrimary.withOpacity(0.8),
                  ),
                ),
              )
                .animate()
                .fadeIn(delay: 1200.ms, duration: 400.ms),
            ],
          ),
        ),
      ),
    );
  }
}
