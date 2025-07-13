import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/custom_cards.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/providers/user_provider.dart';

class CurrentPathCard extends StatelessWidget {
  const CurrentPathCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        final goalInfo = _getGoalInfo(userProvider.primaryGoal);
        
        return BaseCard(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      gradient: goalInfo.gradient,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      goalInfo.icon,
                      color: AppColors.textOnPrimary,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Your Current Path',
                          style: AppTypography.labelMedium.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                        Text(
                          goalInfo.title,
                          style: AppTypography.titleLarge.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 16),
              
              // Current Module Info
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.surfaceVariant,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.book,
                      color: AppColors.primary,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userProvider.currentModule.isEmpty 
                                ? goalInfo.currentModule 
                                : userProvider.currentModule,
                            style: AppTypography.labelMedium.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          LinearProgressIndicator(
                            value: userProvider.moduleProgress,
                            backgroundColor: AppColors.border,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              goalInfo.color,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${(userProvider.moduleProgress * 100).round()}%',
                      style: AppTypography.labelSmall.copyWith(
                        color: goalInfo.color,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Today's Goal
              Row(
                children: [
                  Icon(
                    Icons.today,
                    color: AppColors.secondary,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Today\'s Goal: Learn ${userProvider.dailyWordTarget} new words',
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 20),
              
              // Action Button
              PrimaryButton(
                text: 'Learn Today\'s Words',
                onPressed: () => _startLearningSession(context),
                width: double.infinity,
                backgroundColor: goalInfo.color,
                icon: Icons.play_arrow,
              ),
            ],
          ),
        );
      },
    );
  }
  
  GoalInfo _getGoalInfo(LearningGoal goal) {
    switch (goal) {
      case LearningGoal.spokenEnglish:
        return GoalInfo(
          title: 'Spoken English Power-Up',
          currentModule: 'Daily Conversations',
          icon: Icons.record_voice_over,
          color: AppColors.primary,
          gradient: AppColors.primaryGradient,
        );
      case LearningGoal.academicWriting:
        return GoalInfo(
          title: 'Academic & Professional Writing',
          currentModule: 'Formal Vocabulary',
          icon: Icons.edit_note,
          color: AppColors.success,
          gradient: AppColors.successGradient,
        );
      case LearningGoal.ieltsExcellence:
        return GoalInfo(
          title: 'IELTS Excellence',
          currentModule: 'Academic Word List',
          icon: Icons.school,
          color: AppColors.accent,
          gradient: AppColors.accentGradient,
        );
    }
  }
  
  void _startLearningSession(BuildContext context) {
    // TODO: Navigate to learning session screen
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Starting learning session...',
          style: AppTypography.bodyMedium.copyWith(
            color: AppColors.textOnPrimary,
          ),
        ),
        backgroundColor: AppColors.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}

class GoalInfo {
  final String title;
  final String currentModule;
  final IconData icon;
  final Color color;
  final LinearGradient gradient;
  
  GoalInfo({
    required this.title,
    required this.currentModule,
    required this.icon,
    required this.color,
    required this.gradient,
  });
}
