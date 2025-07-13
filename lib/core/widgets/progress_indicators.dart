import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

/// XP Progress Bar with level information
class XPProgressBar extends StatelessWidget {
  final int currentXP;
  final int xpToNextLevel;
  final int currentLevel;
  final bool showLevel;
  final bool animated;
  final double height;
  final Color? backgroundColor;
  final Color? fillColor;
  
  const XPProgressBar({
    super.key,
    required this.currentXP,
    required this.xpToNextLevel,
    required this.currentLevel,
    this.showLevel = true,
    this.animated = true,
    this.height = 8,
    this.backgroundColor,
    this.fillColor,
  });

  @override
  Widget build(BuildContext context) {
    final progress = currentXP / xpToNextLevel;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showLevel) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Level $currentLevel',
                style: AppTypography.labelMedium.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
              Text(
                '$currentXP / $xpToNextLevel XP',
                style: AppTypography.labelSmall,
              ),
            ],
          ),
          const SizedBox(height: 8),
        ],
        Container(
          height: height,
          decoration: BoxDecoration(
            color: backgroundColor ?? AppColors.xpBarBackground,
            borderRadius: BorderRadius.circular(height / 2),
            boxShadow: [
              BoxShadow(
                color: AppColors.textPrimary.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(height / 2),
            child: Stack(
              children: [
                LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.transparent,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    fillColor ?? AppColors.xpBarFill,
                  ),
                ),
                // Shimmer effect
                if (animated)
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: AppColors.shimmerGradient,
                        borderRadius: BorderRadius.circular(height / 2),
                      ),
                    ).animate(onPlay: (controller) => controller.repeat())
                      .slideX(duration: 1500.ms, begin: -1, end: 1),
                  ),
              ],
            ),
          ),
        ).animate(target: animated ? 1 : 0)
          .scaleX(duration: 800.ms, curve: Curves.easeOutBack)
          .then()
          .shimmer(duration: 2000.ms, color: (fillColor ?? AppColors.xpBarFill).withOpacity(0.3)),
      ],
    );
  }
}

/// Circular Progress Indicator for modules/lessons
class CircularProgressWidget extends StatelessWidget {
  final double progress;
  final double size;
  final double strokeWidth;
  final Color? backgroundColor;
  final Color? progressColor;
  final Widget? child;
  final bool showPercentage;
  final bool animated;
  
  const CircularProgressWidget({
    super.key,
    required this.progress,
    this.size = 80,
    this.strokeWidth = 6,
    this.backgroundColor,
    this.progressColor,
    this.child,
    this.showPercentage = false,
    this.animated = true,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircularProgressIndicator(
            value: progress,
            strokeWidth: strokeWidth,
            backgroundColor: backgroundColor ?? AppColors.xpBarBackground,
            valueColor: AlwaysStoppedAnimation<Color>(
              progressColor ?? AppColors.primary,
            ),
          ),
          if (child != null)
            child!
          else if (showPercentage)
            Text(
              '${(progress * 100).round()}%',
              style: AppTypography.labelMedium.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
        ],
      ),
    ).animate(target: animated ? 1 : 0)
      .scale(duration: 400.ms, curve: Curves.elasticOut);
  }
}

/// Streak Flame Indicator
class StreakIndicator extends StatelessWidget {
  final int streakCount;
  final bool isActive;
  final double size;
  final bool animated;
  
  const StreakIndicator({
    super.key,
    required this.streakCount,
    required this.isActive,
    this.size = 32,
    this.animated = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isActive 
            ? AppColors.streakBackground 
            : AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isActive 
              ? AppColors.streakFlame.withOpacity(0.3) 
              : AppColors.border,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.local_fire_department,
            size: size,
            color: isActive 
                ? AppColors.streakFlame 
                : AppColors.textTertiary,
          ),
          const SizedBox(width: 4),
          Text(
            '$streakCount',
            style: AppTypography.labelMedium.copyWith(
              fontWeight: FontWeight.w600,
              color: isActive 
                  ? AppColors.streakFlame 
                  : AppColors.textTertiary,
            ),
          ),
        ],
      ),
    ).animate(target: animated && isActive ? 1 : 0)
      .shimmer(duration: 2000.ms, color: AppColors.secondary.withOpacity(0.3))
      .then()
      .shake(duration: 200.ms, hz: 2);
  }
}

/// Quiz Progress Indicator
class QuizProgressIndicator extends StatelessWidget {
  final int currentQuestion;
  final int totalQuestions;
  final int correctAnswers;
  final bool animated;
  
  const QuizProgressIndicator({
    super.key,
    required this.currentQuestion,
    required this.totalQuestions,
    required this.correctAnswers,
    this.animated = true,
  });

  @override
  Widget build(BuildContext context) {
    final progress = currentQuestion / totalQuestions;
    final accuracy = currentQuestion > 0 ? correctAnswers / currentQuestion : 0.0;
    
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Question $currentQuestion of $totalQuestions',
              style: AppTypography.labelMedium,
            ),
            Text(
              '${(accuracy * 100).round()}% Correct',
              style: AppTypography.labelMedium.copyWith(
                color: AppColors.success,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: progress,
          backgroundColor: AppColors.xpBarBackground,
          valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
        ),
      ],
    ).animate(target: animated ? 1 : 0)
      .fadeIn(duration: 300.ms);
  }
}

/// Pronunciation Accuracy Indicator
class PronunciationAccuracyIndicator extends StatelessWidget {
  final double accuracy;
  final String feedback;
  final bool animated;
  
  const PronunciationAccuracyIndicator({
    super.key,
    required this.accuracy,
    required this.feedback,
    this.animated = true,
  });

  @override
  Widget build(BuildContext context) {
    Color getAccuracyColor() {
      if (accuracy >= 0.75) return AppColors.pronunciationExcellent;
      if (accuracy >= 0.5) return AppColors.pronunciationGood;
      return AppColors.pronunciationPoor;
    }
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: getAccuracyColor().withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: getAccuracyColor().withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          CircularProgressWidget(
            progress: accuracy,
            size: 60,
            progressColor: getAccuracyColor(),
            showPercentage: true,
            animated: animated,
          ),
          const SizedBox(height: 12),
          Text(
            feedback,
            style: AppTypography.labelLarge.copyWith(
              color: getAccuracyColor(),
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ).animate(target: animated ? 1 : 0)
      .scale(duration: 500.ms, curve: Curves.elasticOut)
      .then()
      .shimmer(duration: 1000.ms, color: getAccuracyColor().withOpacity(0.3));
  }
}
