import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

/// Base card widget with consistent styling
class BaseCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? backgroundColor;
  final double? elevation;
  final BorderRadius? borderRadius;
  final VoidCallback? onTap;
  final bool enableHapticFeedback;
  final bool animated;
  
  const BaseCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.elevation,
    this.borderRadius,
    this.onTap,
    this.enableHapticFeedback = true,
    this.animated = false,
  });

  @override
  Widget build(BuildContext context) {
    Widget card = Card(
      color: backgroundColor ?? AppColors.surface,
      elevation: elevation ?? 2,
      shadowColor: AppColors.textPrimary.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ?? BorderRadius.circular(16),
      ),
      margin: margin ?? const EdgeInsets.all(8),
      child: InkWell(
        onTap: onTap != null ? _handleTap : null,
        borderRadius: borderRadius ?? BorderRadius.circular(16),
        child: Padding(
          padding: padding ?? const EdgeInsets.all(16),
          child: child,
        ),
      ),
    );
    
    if (animated) {
      return card.animate()
        .fadeIn(duration: 300.ms)
        .slideY(begin: 0.1, duration: 300.ms, curve: Curves.easeOut);
    }
    
    return card;
  }
  
  void _handleTap() {
    if (enableHapticFeedback) {
      HapticFeedback.lightImpact();
    }
    onTap?.call();
  }
}

/// Learning Path Card
class LearningPathCard extends StatelessWidget {
  final String title;
  final String description;
  final double progress;
  final int totalModules;
  final int completedModules;
  final bool isLocked;
  final VoidCallback? onTap;
  final String? iconPath;
  final Color? accentColor;
  
  const LearningPathCard({
    super.key,
    required this.title,
    required this.description,
    required this.progress,
    required this.totalModules,
    required this.completedModules,
    this.isLocked = false,
    this.onTap,
    this.iconPath,
    this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      onTap: isLocked ? null : onTap,
      animated: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: (accentColor ?? AppColors.primary).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  isLocked ? Icons.lock : Icons.school,
                  color: isLocked ? AppColors.textTertiary : (accentColor ?? AppColors.primary),
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTypography.titleLarge.copyWith(
                        color: isLocked ? AppColors.textTertiary : AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '$completedModules / $totalModules modules',
                      style: AppTypography.bodySmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: AppTypography.bodyMedium.copyWith(
              color: isLocked ? AppColors.textTertiary : AppColors.textSecondary,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 16),
          if (!isLocked) ...[
            LinearProgressIndicator(
              value: progress,
              backgroundColor: AppColors.xpBarBackground,
              valueColor: AlwaysStoppedAnimation<Color>(
                accentColor ?? AppColors.primary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${(progress * 100).round()}% Complete',
              style: AppTypography.labelSmall.copyWith(
                color: accentColor ?? AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Word Card for learning sessions
class WordCard extends StatelessWidget {
  final String word;
  final String meaning;
  final String partOfSpeech;
  final List<String> examples;
  final bool showMeaning;
  final VoidCallback? onTap;
  final VoidCallback? onPronounce;
  final bool isBookmarked;
  final VoidCallback? onBookmark;
  
  const WordCard({
    super.key,
    required this.word,
    required this.meaning,
    required this.partOfSpeech,
    required this.examples,
    this.showMeaning = false,
    this.onTap,
    this.onPronounce,
    this.isBookmarked = false,
    this.onBookmark,
  });

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      onTap: onTap,
      animated: true,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      word,
                      style: AppTypography.wordDisplay,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      partOfSpeech,
                      style: AppTypography.labelMedium.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: onPronounce,
                    icon: const Icon(Icons.volume_up),
                    color: AppColors.primary,
                    style: IconButton.styleFrom(
                      backgroundColor: AppColors.primary.withOpacity(0.1),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: onBookmark,
                    icon: Icon(
                      isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                    ),
                    color: isBookmarked ? AppColors.secondary : AppColors.textTertiary,
                  ),
                ],
              ),
            ],
          ),
          if (showMeaning) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.surfaceVariant,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    meaning,
                    style: AppTypography.banglaBodyLarge,
                  ),
                  if (examples.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    Text(
                      'Examples:',
                      style: AppTypography.labelMedium.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    ...examples.take(2).map((example) => Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        '• $example',
                        style: AppTypography.bodySmall.copyWith(
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    )),
                  ],
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Quick Action Card for home dashboard
class QuickActionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  final VoidCallback? onTap;
  final String? badge;
  
  const QuickActionCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
    required this.backgroundColor,
    this.onTap,
    this.badge,
  });

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      onTap: onTap,
      animated: true,
      backgroundColor: backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 20,
                ),
              ),
              const Spacer(),
              if (badge != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.accent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    badge!,
                    style: AppTypography.labelSmall.copyWith(
                      color: AppColors.textOnPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: AppTypography.titleMedium.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: AppTypography.bodySmall,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
