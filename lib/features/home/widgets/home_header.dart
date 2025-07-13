import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/progress_indicators.dart';
import '../../../core/providers/user_provider.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.primary,
                AppColors.primary.withOpacity(0.8),
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Row: User Info and Gems
              Row(
                children: [
                  // User Avatar
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: AppColors.textOnPrimary,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primaryDark.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.person,
                      color: AppColors.primary,
                      size: 28,
                    ),
                  )
                    .animate()
                    .scale(duration: 600.ms, curve: Curves.elasticOut),
                  
                  const SizedBox(width: 12),
                  
                  // User Name and Greeting
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _getGreeting(),
                          style: AppTypography.bodyMedium.copyWith(
                            color: AppColors.textOnPrimary.withOpacity(0.9),
                          ),
                        ),
                        Text(
                          userProvider.userName.isEmpty 
                              ? 'Vocab Hero' 
                              : userProvider.userName,
                          style: AppTypography.titleLarge.copyWith(
                            color: AppColors.textOnPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  )
                    .animate()
                    .fadeIn(delay: 200.ms, duration: 600.ms)
                    .slideX(begin: 0.3, end: 0),
                  
                  // Gems and Streak
                  Column(
                    children: [
                      // Gems
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColors.secondary,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.diamond,
                              color: AppColors.textPrimary,
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${userProvider.gemsCount}',
                              style: AppTypography.labelMedium.copyWith(
                                color: AppColors.textPrimary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      const SizedBox(height: 8),
                      
                      // Streak
                      StreakIndicator(
                        streakCount: userProvider.currentStreak,
                        isActive: userProvider.isStreakActive,
                        size: 20,
                        animated: true,
                      ),
                    ],
                  )
                    .animate()
                    .fadeIn(delay: 400.ms, duration: 600.ms)
                    .slideX(begin: -0.3, end: 0),
                ],
              ),
              
              const SizedBox(height: 20),
              
              // XP Progress Bar
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.textOnPrimary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.textOnPrimary.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: XPProgressBar(
                  currentXP: userProvider.currentXP,
                  xpToNextLevel: userProvider.xpToNextLevel,
                  currentLevel: userProvider.currentLevel,
                  showLevel: true,
                  animated: true,
                  backgroundColor: AppColors.textOnPrimary.withOpacity(0.2),
                  fillColor: AppColors.secondary,
                ),
              )
                .animate()
                .fadeIn(delay: 600.ms, duration: 600.ms)
                .slideY(begin: 0.3, end: 0),
            ],
          ),
        );
      },
    );
  }
  
  String _getGreeting() {
    final hour = DateTime.now().hour;
    
    if (hour < 12) {
      return 'Good Morning!';
    } else if (hour < 17) {
      return 'Good Afternoon!';
    } else {
      return 'Good Evening!';
    }
  }
}
