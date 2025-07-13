import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/services/navigation_service.dart';
import 'goal_selection_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  
  final List<WelcomePageData> _pages = [
    WelcomePageData(
      title: 'Meet Your Vocab Hero!',
      subtitle: 'Your personal English vocabulary companion is here to make learning fun and effective.',
      description: 'Join thousands of learners who are mastering English vocabulary through our gamified learning experience.',
      icon: Icons.emoji_people,
      color: AppColors.primary,
    ),
    WelcomePageData(
      title: 'Learn Through Play',
      subtitle: 'Turn vocabulary building into an exciting adventure with levels, streaks, and rewards.',
      description: 'Earn XP, unlock achievements, and compete with friends while building your English vocabulary.',
      icon: Icons.videogame_asset,
      color: AppColors.success,
    ),
    WelcomePageData(
      title: 'Real-World Context',
      subtitle: 'Learn words in context with practical examples and real-life usage scenarios.',
      description: 'Master pronunciation, understand etymology, and remember words with powerful mnemonics.',
      icon: Icons.public,
      color: AppColors.accent,
    ),
    WelcomePageData(
      title: 'Ready to Begin?',
      subtitle: 'Let\'s personalize your learning journey and start building your vocabulary empire!',
      description: 'Choose your goals, take a quick assessment, and begin your path to English mastery.',
      icon: Icons.rocket_launch,
      color: AppColors.secondary,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Top Navigation
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (_currentPage > 0)
                    TextButton(
                      onPressed: _previousPage,
                      child: Text(
                        'Back',
                        style: AppTypography.labelLarge.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    )
                  else
                    const SizedBox(width: 60),
                  
                  // Page Indicators
                  Row(
                    children: List.generate(
                      _pages.length,
                      (index) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: _currentPage == index ? 24 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: _currentPage == index
                              ? AppColors.primary
                              : AppColors.border,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ).animate(target: _currentPage == index ? 1 : 0)
                        .scaleX(duration: 300.ms, curve: Curves.easeInOut),
                    ),
                  ),
                  
                  if (_currentPage < _pages.length - 1)
                    TextButton(
                      onPressed: _nextPage,
                      child: Text(
                        'Skip',
                        style: AppTypography.labelLarge.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    )
                  else
                    const SizedBox(width: 60),
                ],
              ),
            ),
            
            // Page Content
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: _pages.length,
                itemBuilder: (context, index) {
                  return _buildWelcomePage(_pages[index]);
                },
              ),
            ),
            
            // Bottom Navigation
            Padding(
              padding: const EdgeInsets.all(24),
              child: _currentPage == _pages.length - 1
                  ? PrimaryButton(
                      text: 'Get Started',
                      onPressed: _navigateToGoalSelection,
                      width: double.infinity,
                    )
                  : PrimaryButton(
                      text: 'Next',
                      onPressed: _nextPage,
                      width: double.infinity,
                      icon: Icons.arrow_forward,
                    ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildWelcomePage(WelcomePageData page) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Illustration/Icon
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: page.color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Icon(
              page.icon,
              size: 60,
              color: page.color,
            ),
          )
            .animate()
            .scale(duration: 600.ms, curve: Curves.elasticOut)
            .then()
            .shimmer(duration: 2000.ms, color: page.color.withOpacity(0.3)),
          
          const SizedBox(height: 48),
          
          // Title
          Text(
            page.title,
            style: AppTypography.displayMedium.copyWith(
              color: AppColors.textPrimary,
            ),
            textAlign: TextAlign.center,
          )
            .animate()
            .fadeIn(delay: 200.ms, duration: 600.ms)
            .slideY(begin: 0.3, end: 0),
          
          const SizedBox(height: 16),
          
          // Subtitle
          Text(
            page.subtitle,
            style: AppTypography.titleMedium.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          )
            .animate()
            .fadeIn(delay: 400.ms, duration: 600.ms)
            .slideY(begin: 0.3, end: 0),
          
          const SizedBox(height: 24),
          
          // Description
          Text(
            page.description,
            style: AppTypography.bodyLarge.copyWith(
              color: AppColors.textSecondary,
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          )
            .animate()
            .fadeIn(delay: 600.ms, duration: 600.ms)
            .slideY(begin: 0.3, end: 0),
        ],
      ),
    );
  }
  
  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _navigateToGoalSelection();
    }
  }
  
  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }
  
  void _navigateToGoalSelection() {
    NavigationService.pushReplacement(const GoalSelectionScreen());
  }
  
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}

class WelcomePageData {
  final String title;
  final String subtitle;
  final String description;
  final IconData icon;
  final Color color;
  
  WelcomePageData({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.icon,
    required this.color,
  });
}
