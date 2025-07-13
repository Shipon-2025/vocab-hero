import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/custom_cards.dart';

class MotivationalQuoteCard extends StatefulWidget {
  const MotivationalQuoteCard({super.key});

  @override
  State<MotivationalQuoteCard> createState() => _MotivationalQuoteCardState();
}

class _MotivationalQuoteCardState extends State<MotivationalQuoteCard> {
  int _currentQuoteIndex = 0;
  
  final List<MotivationalQuote> _quotes = [
    MotivationalQuote(
      english: '"The limits of my language mean the limits of my world."',
      bangla: '"আমার ভাষার সীমা মানে আমার জগতের সীমা।"',
      author: 'Ludwig Wittgenstein',
    ),
    MotivationalQuote(
      english: '"To have another language is to possess a second soul."',
      bangla: '"অন্য একটি ভাষা জানা মানে দ্বিতীয় একটি আত্মার অধিকারী হওয়া।"',
      author: 'Charlemagne',
    ),
    MotivationalQuote(
      english: '"Language is the road map of a culture."',
      bangla: '"ভাষা হলো একটি সংস্কৃতির রোডম্যাপ।"',
      author: 'Rita Mae Brown',
    ),
    MotivationalQuote(
      english: '"Learning never exhausts the mind."',
      bangla: '"শেখা কখনো মনকে ক্লান্ত করে না।"',
      author: 'Leonardo da Vinci',
    ),
    MotivationalQuote(
      english: '"Words are, of course, the most powerful drug used by mankind."',
      bangla: '"শব্দ অবশ্যই মানবজাতির ব্যবহৃত সবচেয়ে শক্তিশালী ওষুধ।"',
      author: 'Rudyard Kipling',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _selectDailyQuote();
  }

  void _selectDailyQuote() {
    // Select quote based on day of year to ensure same quote per day
    final dayOfYear = DateTime.now().difference(DateTime(DateTime.now().year)).inDays;
    _currentQuoteIndex = dayOfYear % _quotes.length;
  }

  @override
  Widget build(BuildContext context) {
    final quote = _quotes[_currentQuoteIndex];
    
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary.withOpacity(0.08),
            AppColors.primary.withOpacity(0.03),
            AppColors.surface,
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.1),
            blurRadius: 25,
            offset: const Offset(0, 12),
          ),
          BoxShadow(
            color: AppColors.textPrimary.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
        border: Border.all(
          color: AppColors.primary.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.format_quote,
                  color: AppColors.primary,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Daily Inspiration',
                      style: AppTypography.titleMedium.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                    Text(
                      'Quote of the Day',
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: _refreshQuote,
                icon: const Icon(Icons.refresh),
                color: AppColors.primary,
                iconSize: 20,
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // English Quote
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.surface,
                  AppColors.surface.withOpacity(0.8),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: AppColors.primary.withOpacity(0.15),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.08),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  quote.english,
                  style: AppTypography.bodyLarge.copyWith(
                    fontStyle: FontStyle.italic,
                    height: 1.6,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  quote.bangla,
                  style: AppTypography.banglaBodyMedium.copyWith(
                    fontStyle: FontStyle.italic,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '— ${quote.author}',
                    style: AppTypography.labelMedium.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
          )
            .animate()
            .fadeIn(duration: 600.ms)
            .slideY(begin: 0.2, end: 0),
          
          const SizedBox(height: 12),
          
          // Quote indicator dots
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              _quotes.length,
              (index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 2),
                width: _currentQuoteIndex == index ? 16 : 6,
                height: 6,
                decoration: BoxDecoration(
                  color: _currentQuoteIndex == index
                      ? AppColors.primary
                      : AppColors.border,
                  borderRadius: BorderRadius.circular(3),
                ),
              ).animate(target: _currentQuoteIndex == index ? 1 : 0)
                .scaleX(duration: 300.ms, curve: Curves.easeInOut),
            ),
          ),
        ],
      ),
    );
  }
  
  void _refreshQuote() {
    setState(() {
      _currentQuoteIndex = (_currentQuoteIndex + 1) % _quotes.length;
    });
  }
}

class MotivationalQuote {
  final String english;
  final String bangla;
  final String author;
  
  MotivationalQuote({
    required this.english,
    required this.bangla,
    required this.author,
  });
}
