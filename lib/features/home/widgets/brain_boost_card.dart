import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/custom_cards.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/providers/learning_provider.dart';

class BrainBoostCard extends StatelessWidget {
  const BrainBoostCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LearningProvider>(
      builder: (context, learningProvider, child) {
        final reviewWords = learningProvider.getWordsForReview();
        final hasReviewWords = reviewWords.isNotEmpty;
        
        return BaseCard(
          padding: const EdgeInsets.all(20),
          backgroundColor: hasReviewWords 
              ? AppColors.accent.withOpacity(0.05)
              : AppColors.surfaceVariant,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with Brain Icon
              Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: hasReviewWords 
                          ? AppColors.accent.withOpacity(0.2)
                          : AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.psychology,
                      color: hasReviewWords ? AppColors.accent : AppColors.primary,
                      size: 24,
                    ),
                  )
                    .animate(target: hasReviewWords ? 1 : 0)
                    .shimmer(duration: 2000.ms, color: AppColors.accent.withOpacity(0.3)),
                  
                  const SizedBox(width: 12),
                  
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Brain Boost',
                          style: AppTypography.titleLarge.copyWith(
                            fontWeight: FontWeight.bold,
                            color: hasReviewWords ? AppColors.accent : AppColors.primary,
                          ),
                        ),
                        Text(
                          'Spaced Repetition System',
                          style: AppTypography.bodySmall.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  if (hasReviewWords)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.accent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${reviewWords.length}',
                        style: AppTypography.labelSmall.copyWith(
                          color: AppColors.textOnPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                      .animate()
                      .scale(duration: 400.ms, curve: Curves.elasticOut)
                      .then()
                      .shake(duration: 200.ms, hz: 2),
                ],
              ),
              
              const SizedBox(height: 16),
              
              // Content based on review status
              if (hasReviewWords) ...[
                Text(
                  'Time to review ${reviewWords.length} words you might forget!',
                  style: AppTypography.bodyLarge.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Research shows that reviewing words at optimal intervals improves retention by up to 90%.',
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 16),
                PrimaryButton(
                  text: 'Start Review Session',
                  onPressed: () => _startReviewSession(context, reviewWords),
                  width: double.infinity,
                  backgroundColor: AppColors.accent,
                  icon: Icons.refresh,
                ),
              ] else ...[
                Text(
                  'Great job! No words need review right now.',
                  style: AppTypography.bodyLarge.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.success,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Keep learning new words and they\'ll appear here when it\'s time to review.',
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: AppColors.success,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Your brain is optimally boosted!',
                      style: AppTypography.labelMedium.copyWith(
                        color: AppColors.success,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        );
      },
    );
  }
  
  void _startReviewSession(BuildContext context, List<Word> reviewWords) {
    // Start a review session with the words that need review
    context.read<LearningProvider>().startLearningSession(reviewWords);
    
    // TODO: Navigate to learning session screen
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Starting review session with ${reviewWords.length} words...',
          style: AppTypography.bodyMedium.copyWith(
            color: AppColors.textOnPrimary,
          ),
        ),
        backgroundColor: AppColors.accent,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
