import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/custom_cards.dart';
import '../../../core/providers/user_provider.dart';
import '../../../core/services/navigation_service.dart';
import 'placement_test_screen.dart';

class GoalSelectionScreen extends StatefulWidget {
  const GoalSelectionScreen({super.key});

  @override
  State<GoalSelectionScreen> createState() => _GoalSelectionScreenState();
}

class _GoalSelectionScreenState extends State<GoalSelectionScreen> {
  LearningGoal? _selectedGoal;
  
  final List<GoalOption> _goalOptions = [
    GoalOption(
      goal: LearningGoal.spokenEnglish,
      title: 'Spoken English Power-Up',
      description: 'Master conversational English with everyday words, idioms, and phrasal verbs for confident speaking.',
      icon: Icons.record_voice_over,
      color: AppColors.primary,
      features: [
        'Daily conversation vocabulary',
        'Common idioms & expressions',
        'Pronunciation practice',
        'Speaking confidence building',
      ],
    ),
    GoalOption(
      goal: LearningGoal.academicWriting,
      title: 'Academic & Professional Writing',
      description: 'Build sophisticated vocabulary for essays, reports, and formal communication in academic and professional settings.',
      icon: Icons.edit_note,
      color: AppColors.success,
      features: [
        'Academic word lists',
        'Formal writing vocabulary',
        'Professional terminology',
        'Essay & report writing',
      ],
    ),
    GoalOption(
      goal: LearningGoal.ieltsExcellence,
      title: 'IELTS Excellence',
      description: 'Achieve your target IELTS score with high-frequency academic vocabulary and topic-specific word lists.',
      icon: Icons.school,
      color: AppColors.accent,
      features: [
        'IELTS Academic Word List',
        'Topic-specific vocabulary',
        'Band 7+ vocabulary',
        'Test-taking strategies',
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'Choose Your Goal',
          style: AppTypography.headlineSmall,
        ),
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Text(
                    'What\'s your English learning goal?',
                    style: AppTypography.displaySmall,
                    textAlign: TextAlign.center,
                  )
                    .animate()
                    .fadeIn(duration: 600.ms)
                    .slideY(begin: 0.3, end: 0),
                  
                  const SizedBox(height: 12),
                  
                  Text(
                    'Choose the path that best matches your learning objectives. You can always change this later.',
                    style: AppTypography.bodyLarge.copyWith(
                      color: AppColors.textSecondary,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  )
                    .animate()
                    .fadeIn(delay: 200.ms, duration: 600.ms)
                    .slideY(begin: 0.3, end: 0),
                ],
              ),
            ),
            
            // Goal Options
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _goalOptions.length,
                itemBuilder: (context, index) {
                  final option = _goalOptions[index];
                  final isSelected = _selectedGoal == option.goal;
                  
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: _buildGoalCard(option, isSelected),
                  )
                    .animate()
                    .fadeIn(delay: (300 + index * 100).ms, duration: 600.ms)
                    .slideX(begin: 0.3, end: 0);
                },
              ),
            ),
            
            // Continue Button
            Padding(
              padding: const EdgeInsets.all(24),
              child: PrimaryButton(
                text: 'Continue',
                onPressed: _selectedGoal != null ? _continueToPlacementTest : null,
                width: double.infinity,
                isEnabled: _selectedGoal != null,
                icon: Icons.arrow_forward,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGoalCard(GoalOption option, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedGoal = option.goal;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? option.color : AppColors.border,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? option.color.withOpacity(0.2)
                  : AppColors.textPrimary.withOpacity(0.05),
              blurRadius: isSelected ? 12 : 4,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: option.color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      option.icon,
                      color: option.color,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      option.title,
                      style: AppTypography.titleLarge.copyWith(
                        color: isSelected ? option.color : AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  if (isSelected)
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: option.color,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.check,
                        color: AppColors.textOnPrimary,
                        size: 16,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                option.description,
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: option.features.map((feature) => Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: option.color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    feature,
                    style: AppTypography.labelSmall.copyWith(
                      color: option.color,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _continueToPlacementTest() {
    if (_selectedGoal != null) {
      context.read<UserProvider>().setPrimaryGoal(_selectedGoal!);
      NavigationService.pushReplacement(const PlacementTestScreen());
    }
  }
}

class GoalOption {
  final LearningGoal goal;
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final List<String> features;

  GoalOption({
    required this.goal,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.features,
  });
}
