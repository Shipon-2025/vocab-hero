import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/custom_cards.dart';
import '../../../core/providers/learning_provider.dart';

class QuickActionsGrid extends StatelessWidget {
  const QuickActionsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LearningProvider>(
      builder: (context, learningProvider, child) {
        final reviewWordsCount = learningProvider.getWordsForReview().length;
        
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Quick Access',
              style: AppTypography.headlineSmall.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.1,
              children: [
                QuickActionCard(
                  title: 'Practice',
                  subtitle: 'Smart Review',
                  icon: Icons.psychology,
                  iconColor: AppColors.primary,
                  backgroundColor: AppColors.primary.withOpacity(0.05),
                  badge: reviewWordsCount > 0 ? '$reviewWordsCount' : null,
                  onTap: () => _navigateToPractice(context),
                )
                  .animate()
                  .fadeIn(delay: 100.ms, duration: 400.ms)
                  .slideY(begin: 0.3, end: 0),
                
                QuickActionCard(
                  title: 'Take Quiz',
                  subtitle: 'Test Knowledge',
                  icon: Icons.quiz,
                  iconColor: AppColors.success,
                  backgroundColor: AppColors.success.withOpacity(0.05),
                  onTap: () => _navigateToQuiz(context),
                )
                  .animate()
                  .fadeIn(delay: 200.ms, duration: 400.ms)
                  .slideY(begin: 0.3, end: 0),
                
                QuickActionCard(
                  title: 'Leaderboard',
                  subtitle: 'See Rankings',
                  icon: Icons.leaderboard,
                  iconColor: AppColors.accent,
                  backgroundColor: AppColors.accent.withOpacity(0.05),
                  onTap: () => _navigateToLeaderboard(context),
                )
                  .animate()
                  .fadeIn(delay: 300.ms, duration: 400.ms)
                  .slideY(begin: 0.3, end: 0),
                
                QuickActionCard(
                  title: 'Dictionary',
                  subtitle: 'Search Words',
                  icon: Icons.menu_book,
                  iconColor: AppColors.secondary,
                  backgroundColor: AppColors.secondary.withOpacity(0.05),
                  onTap: () => _navigateToDictionary(context),
                )
                  .animate()
                  .fadeIn(delay: 400.ms, duration: 400.ms)
                  .slideY(begin: 0.3, end: 0),
              ],
            ),
          ],
        );
      },
    );
  }
  
  void _navigateToPractice(BuildContext context) {
    // TODO: Navigate to practice screen
    _showComingSoonSnackBar(context, 'Practice');
  }
  
  void _navigateToQuiz(BuildContext context) {
    // TODO: Navigate to quiz screen
    _showComingSoonSnackBar(context, 'Quiz');
  }
  
  void _navigateToLeaderboard(BuildContext context) {
    // TODO: Navigate to leaderboard screen
    _showComingSoonSnackBar(context, 'Leaderboard');
  }
  
  void _navigateToDictionary(BuildContext context) {
    // TODO: Navigate to dictionary screen
    _showComingSoonSnackBar(context, 'Dictionary');
  }
  
  void _showComingSoonSnackBar(BuildContext context, String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '$feature feature coming soon!',
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
