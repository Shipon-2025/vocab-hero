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
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.primary,
              AppColors.primaryLight,
              Color(0xFF4DD0E1),
            ],
            stops: [0.0, 0.6, 1.0],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // App Logo/Mascot
                Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.textOnPrimary,
                        AppColors.textOnPrimary.withOpacity(0.95),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(35),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primaryDark.withOpacity(0.4),
                        blurRadius: 30,
                        offset: const Offset(0, 15),
                      ),
                      BoxShadow(
                        color: AppColors.textOnPrimary.withOpacity(0.3),
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      ),
                    ],
                    border: Border.all(
                      color: AppColors.textOnPrimary.withOpacity(0.2),
                      width: 2,
                    ),
                  ),
                  child: const Icon(
                    Icons.school,
                    size: 70,
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
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: AppColors.textOnPrimary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppColors.textOnPrimary.withOpacity(0.9),
                    ),
                  ),
                ),
              )
                .animate()
                .fadeIn(delay: 1200.ms, duration: 400.ms)
                .scale(delay: 1200.ms, duration: 600.ms, curve: Curves.elasticOut),
            ],
          ),
        ),
      ),
    );
  }
}
