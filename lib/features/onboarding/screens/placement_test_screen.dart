import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/progress_indicators.dart';
import '../../../core/providers/user_provider.dart';
import '../../../core/providers/app_state_provider.dart';
import '../../../core/services/navigation_service.dart';
import '../../home/screens/home_screen.dart';

class PlacementTestScreen extends StatefulWidget {
  const PlacementTestScreen({super.key});

  @override
  State<PlacementTestScreen> createState() => _PlacementTestScreenState();
}

class _PlacementTestScreenState extends State<PlacementTestScreen> {
  int _currentQuestionIndex = 0;
  int _correctAnswers = 0;
  bool _isTestStarted = false;
  bool _isTestCompleted = false;
  String? _selectedAnswer;
  
  final List<PlacementQuestion> _questions = [
    PlacementQuestion(
      question: 'What does "abundant" mean?',
      options: ['Scarce', 'Plentiful', 'Difficult', 'Simple'],
      correctAnswer: 1,
      difficulty: 'beginner',
    ),
    PlacementQuestion(
      question: 'Choose the correct synonym for "meticulous":',
      options: ['Careless', 'Quick', 'Careful', 'Lazy'],
      correctAnswer: 2,
      difficulty: 'beginner',
    ),
    PlacementQuestion(
      question: 'What does "ubiquitous" mean?',
      options: ['Rare', 'Present everywhere', 'Ancient', 'Expensive'],
      correctAnswer: 1,
      difficulty: 'intermediate',
    ),
    PlacementQuestion(
      question: 'Choose the best meaning for "ephemeral":',
      options: ['Permanent', 'Short-lived', 'Beautiful', 'Dangerous'],
      correctAnswer: 1,
      difficulty: 'intermediate',
    ),
    PlacementQuestion(
      question: 'What does "perspicacious" mean?',
      options: ['Confused', 'Having keen insight', 'Talkative', 'Wealthy'],
      correctAnswer: 1,
      difficulty: 'advanced',
    ),
    PlacementQuestion(
      question: 'Choose the correct meaning of "obfuscate":',
      options: ['To clarify', 'To confuse deliberately', 'To celebrate', 'To organize'],
      correctAnswer: 1,
      difficulty: 'advanced',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    if (!_isTestStarted) {
      return _buildTestIntroduction();
    } else if (_isTestCompleted) {
      return _buildTestResults();
    } else {
      return _buildTestQuestion();
    }
  }
  
  Widget _buildTestIntroduction() {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'Placement Test',
          style: AppTypography.headlineSmall,
        ),
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: const Icon(
                  Icons.quiz,
                  size: 50,
                  color: AppColors.primary,
                ),
              )
                .animate()
                .scale(duration: 600.ms, curve: Curves.elasticOut),
              
              const SizedBox(height: 32),
              
              Text(
                'Quick Vocabulary Assessment',
                style: AppTypography.displaySmall,
                textAlign: TextAlign.center,
              )
                .animate()
                .fadeIn(delay: 200.ms, duration: 600.ms)
                .slideY(begin: 0.3, end: 0),
              
              const SizedBox(height: 16),
              
              Text(
                'This quick test will help us understand your current vocabulary level and personalize your learning experience.',
                style: AppTypography.bodyLarge.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.6,
                ),
                textAlign: TextAlign.center,
              )
                .animate()
                .fadeIn(delay: 400.ms, duration: 600.ms)
                .slideY(begin: 0.3, end: 0),
              
              const SizedBox(height: 32),
              
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.surfaceVariant,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.timer,
                          color: AppColors.primary,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '2-3 minutes',
                          style: AppTypography.labelMedium.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(
                          Icons.quiz,
                          color: AppColors.primary,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${_questions.length} questions',
                          style: AppTypography.labelMedium.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(
                          Icons.psychology,
                          color: AppColors.primary,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Adaptive difficulty',
                          style: AppTypography.labelMedium.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
                .animate()
                .fadeIn(delay: 600.ms, duration: 600.ms)
                .slideY(begin: 0.3, end: 0),
              
              const SizedBox(height: 48),
              
              PrimaryButton(
                text: 'Start Test',
                onPressed: _startTest,
                width: double.infinity,
                icon: Icons.play_arrow,
              ),
              
              const SizedBox(height: 16),
              
              SecondaryButton(
                text: 'Skip for Now',
                onPressed: _skipTest,
                width: double.infinity,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTestQuestion() {
    final question = _questions[_currentQuestionIndex];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'Question ${_currentQuestionIndex + 1} of ${_questions.length}',
          style: AppTypography.headlineSmall,
        ),
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Progress Indicator
            Padding(
              padding: const EdgeInsets.all(16),
              child: QuizProgressIndicator(
                currentQuestion: _currentQuestionIndex + 1,
                totalQuestions: _questions.length,
                correctAnswers: _correctAnswers,
                animated: true,
              ),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Question
                    Text(
                      question.question,
                      style: AppTypography.headlineMedium,
                    )
                      .animate()
                      .fadeIn(duration: 600.ms)
                      .slideY(begin: 0.3, end: 0),

                    const SizedBox(height: 32),

                    // Options
                    Expanded(
                      child: ListView.builder(
                        itemCount: question.options.length,
                        itemBuilder: (context, index) {
                          final option = question.options[index];
                          final isSelected = _selectedAnswer == option;

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedAnswer = option;
                                });
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? AppColors.primary.withOpacity(0.1)
                                      : AppColors.surface,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: isSelected
                                        ? AppColors.primary
                                        : AppColors.border,
                                    width: isSelected ? 2 : 1,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 24,
                                      height: 24,
                                      decoration: BoxDecoration(
                                        color: isSelected
                                            ? AppColors.primary
                                            : Colors.transparent,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: isSelected
                                              ? AppColors.primary
                                              : AppColors.border,
                                          width: 2,
                                        ),
                                      ),
                                      child: isSelected
                                          ? const Icon(
                                              Icons.check,
                                              color: AppColors.textOnPrimary,
                                              size: 16,
                                            )
                                          : null,
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        option,
                                        style: AppTypography.bodyLarge.copyWith(
                                          color: isSelected
                                              ? AppColors.primary
                                              : AppColors.textPrimary,
                                          fontWeight: isSelected
                                              ? FontWeight.w600
                                              : FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                            .animate()
                            .fadeIn(delay: (200 + index * 100).ms, duration: 400.ms)
                            .slideX(begin: 0.3, end: 0);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Next Button
            Padding(
              padding: const EdgeInsets.all(24),
              child: PrimaryButton(
                text: _currentQuestionIndex == _questions.length - 1
                    ? 'Finish Test'
                    : 'Next Question',
                onPressed: _selectedAnswer != null ? _nextQuestion : null,
                width: double.infinity,
                isEnabled: _selectedAnswer != null,
                icon: _currentQuestionIndex == _questions.length - 1
                    ? Icons.check
                    : Icons.arrow_forward,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTestResults() {
    final percentage = (_correctAnswers / _questions.length) * 100;
    VocabularyLevel level;
    String levelDescription;
    Color levelColor;

    if (percentage >= 80) {
      level = VocabularyLevel.advanced;
      levelDescription = 'Advanced - You have excellent vocabulary knowledge!';
      levelColor = AppColors.success;
    } else if (percentage >= 60) {
      level = VocabularyLevel.intermediate;
      levelDescription = 'Intermediate - You have good vocabulary foundation!';
      levelColor = AppColors.primary;
    } else {
      level = VocabularyLevel.beginner;
      levelDescription = 'Beginner - Perfect starting point for your journey!';
      levelColor = AppColors.accent;
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: levelColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Icon(
                  Icons.emoji_events,
                  size: 60,
                  color: levelColor,
                ),
              )
                .animate()
                .scale(duration: 800.ms, curve: Curves.elasticOut)
                .then()
                .shimmer(duration: 1500.ms, color: levelColor.withOpacity(0.3)),

              const SizedBox(height: 32),

              Text(
                'Assessment Complete!',
                style: AppTypography.displayMedium,
                textAlign: TextAlign.center,
              )
                .animate()
                .fadeIn(delay: 200.ms, duration: 600.ms)
                .slideY(begin: 0.3, end: 0),

              const SizedBox(height: 16),

              Text(
                levelDescription,
                style: AppTypography.titleMedium.copyWith(
                  color: levelColor,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              )
                .animate()
                .fadeIn(delay: 400.ms, duration: 600.ms)
                .slideY(begin: 0.3, end: 0),

              const SizedBox(height: 32),

              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.textPrimary.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Score:',
                          style: AppTypography.titleMedium,
                        ),
                        Text(
                          '$_correctAnswers / ${_questions.length}',
                          style: AppTypography.titleMedium.copyWith(
                            color: levelColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Accuracy:',
                          style: AppTypography.titleMedium,
                        ),
                        Text(
                          '${percentage.round()}%',
                          style: AppTypography.titleMedium.copyWith(
                            color: levelColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Level:',
                          style: AppTypography.titleMedium,
                        ),
                        Text(
                          level.name.toUpperCase(),
                          style: AppTypography.titleMedium.copyWith(
                            color: levelColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
                .animate()
                .fadeIn(delay: 600.ms, duration: 600.ms)
                .slideY(begin: 0.3, end: 0),

              const SizedBox(height: 48),

              PrimaryButton(
                text: 'Start Learning Journey',
                onPressed: _completeOnboarding,
                width: double.infinity,
                icon: Icons.rocket_launch,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _startTest() {
    setState(() {
      _isTestStarted = true;
    });
  }

  void _skipTest() {
    context.read<UserProvider>().setVocabularyLevel(VocabularyLevel.beginner);
    _completeOnboarding();
  }

  void _nextQuestion() {
    if (_selectedAnswer != null) {
      final question = _questions[_currentQuestionIndex];
      if (_selectedAnswer == question.options[question.correctAnswer]) {
        _correctAnswers++;
      }

      if (_currentQuestionIndex < _questions.length - 1) {
        setState(() {
          _currentQuestionIndex++;
          _selectedAnswer = null;
        });
      } else {
        _completeTest();
      }
    }
  }

  void _completeTest() {
    final percentage = (_correctAnswers / _questions.length) * 100;
    VocabularyLevel level;

    if (percentage >= 80) {
      level = VocabularyLevel.advanced;
    } else if (percentage >= 60) {
      level = VocabularyLevel.intermediate;
    } else {
      level = VocabularyLevel.beginner;
    }

    context.read<UserProvider>().setVocabularyLevel(level);

    setState(() {
      _isTestCompleted = true;
    });
  }

  void _completeOnboarding() {
    context.read<AppStateProvider>().completeOnboarding();
    NavigationService.pushNamedAndClearStack('/home');
  }
}

class PlacementQuestion {
  final String question;
  final List<String> options;
  final int correctAnswer;
  final String difficulty;

  PlacementQuestion({
    required this.question,
    required this.options,
    required this.correctAnswer,
    required this.difficulty,
  });
}
