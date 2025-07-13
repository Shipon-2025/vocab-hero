import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/custom_cards.dart';
import '../../../core/widgets/progress_indicators.dart';
import '../../../core/providers/user_provider.dart';
import '../../../core/providers/learning_provider.dart';
import '../widgets/home_header.dart';
import '../widgets/current_path_card.dart';
import '../widgets/quick_actions_grid.dart';
import '../widgets/brain_boost_card.dart';
import '../widgets/motivational_quote_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    _initializeHomeData();
  }

  void _initializeHomeData() {
    // Initialize user streak and daily data
    final userProvider = context.read<UserProvider>();
    userProvider.updateStreak();
    
    // Load today's words and review words
    final learningProvider = context.read<LearningProvider>();
    // TODO: Load actual words from database/API
    _loadTodaysWords();
  }

  void _loadTodaysWords() {
    // Mock data for demonstration
    final mockWords = [
      Word(
        id: '1',
        english: 'Serendipity',
        bangla: 'আকস্মিক সুখকর আবিষ্কার',
        partOfSpeech: 'noun',
        examples: [
          'Finding this book was pure serendipity.',
          'Their meeting was a beautiful serendipity.',
        ],
        synonyms: ['chance', 'fortune', 'luck'],
        difficulty: 'intermediate',
      ),
      Word(
        id: '2',
        english: 'Ephemeral',
        bangla: 'ক্ষণস্থায়ী',
        partOfSpeech: 'adjective',
        examples: [
          'The beauty of cherry blossoms is ephemeral.',
          'Fame can be ephemeral.',
        ],
        synonyms: ['temporary', 'fleeting', 'transient'],
        difficulty: 'advanced',
      ),
      // Add more mock words...
    ];
    
    context.read<LearningProvider>().startLearningSession(mockWords);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _refreshHomeData,
          color: AppColors.primary,
          child: CustomScrollView(
            slivers: [
              // Home Header with user info and XP
              const SliverToBoxAdapter(
                child: HomeHeader(),
              ),
              
              // Current Learning Path Card
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: const CurrentPathCard()
                    .animate()
                    .fadeIn(delay: 200.ms, duration: 600.ms)
                    .slideY(begin: 0.3, end: 0),
                ),
              ),
              
              // Quick Actions Grid
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: const QuickActionsGrid()
                    .animate()
                    .fadeIn(delay: 400.ms, duration: 600.ms)
                    .slideY(begin: 0.3, end: 0),
                ),
              ),
              
              // Brain Boost Section (Spaced Repetition)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: const BrainBoostCard()
                    .animate()
                    .fadeIn(delay: 600.ms, duration: 600.ms)
                    .slideY(begin: 0.3, end: 0),
                ),
              ),
              
              // Motivational Quote
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: const MotivationalQuoteCard()
                    .animate()
                    .fadeIn(delay: 800.ms, duration: 600.ms)
                    .slideY(begin: 0.3, end: 0),
                ),
              ),
              
              // Bottom spacing for navigation
              const SliverToBoxAdapter(
                child: SizedBox(height: 100),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }
  
  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: AppColors.textPrimary.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.surface,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textTertiary,
        currentIndex: 0,
        elevation: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Learn',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.quiz),
            label: 'Practice',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.leaderboard),
            label: 'Leaderboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        onTap: _onBottomNavTap,
      ),
    );
  }
  
  void _onBottomNavTap(int index) {
    // TODO: Implement navigation to different screens
    switch (index) {
      case 0:
        // Already on home
        break;
      case 1:
        // Navigate to learning paths
        break;
      case 2:
        // Navigate to practice/quiz
        break;
      case 3:
        // Navigate to leaderboard
        break;
      case 4:
        // Navigate to profile
        break;
    }
  }
  
  Future<void> _refreshHomeData() async {
    // Simulate refresh delay
    await Future.delayed(const Duration(seconds: 1));
    
    // Refresh user data
    final userProvider = context.read<UserProvider>();
    userProvider.updateStreak();
    
    // Reload today's words
    _loadTodaysWords();
    
    // Show success message
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Home refreshed successfully!',
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.textOnPrimary,
            ),
          ),
          backgroundColor: AppColors.success,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      );
    }
  }
}
