import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/providers/learning_provider.dart';
import '../../../core/providers/user_provider.dart';

class WordDetailScreen extends StatefulWidget {
  final Word word;
  
  const WordDetailScreen({
    super.key,
    required this.word,
  });

  @override
  State<WordDetailScreen> createState() => _WordDetailScreenState();
}

class _WordDetailScreenState extends State<WordDetailScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  bool _showMeaning = false;
  bool _isBookmarked = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'Word Details',
          style: AppTypography.headlineSmall,
        ),
        backgroundColor: AppColors.background,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: _toggleBookmark,
            icon: Icon(
              _isBookmarked ? Icons.bookmark : Icons.bookmark_border,
            ),
            color: _isBookmarked ? AppColors.secondary : AppColors.textTertiary,
          ),
        ],
      ),
      body: Column(
        children: [
          // Word Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.surface,
              boxShadow: [
                BoxShadow(
                  color: AppColors.textPrimary.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                // Word and Pronunciation
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.word.english,
                            style: AppTypography.wordDisplay,
                          )
                            .animate()
                            .fadeIn(duration: 600.ms)
                            .slideY(begin: 0.3, end: 0),
                          
                          const SizedBox(height: 8),
                          
                          Text(
                            widget.word.partOfSpeech,
                            style: AppTypography.labelLarge.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                            .animate()
                            .fadeIn(delay: 200.ms, duration: 600.ms)
                            .slideY(begin: 0.3, end: 0),
                        ],
                      ),
                    ),
                    
                    // Pronunciation Button
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(28),
                      ),
                      child: IconButton(
                        onPressed: _playPronunciation,
                        icon: const Icon(Icons.volume_up),
                        color: AppColors.primary,
                        iconSize: 28,
                      ),
                    )
                      .animate()
                      .scale(delay: 400.ms, duration: 600.ms, curve: Curves.elasticOut),
                  ],
                ),
                
                const SizedBox(height: 20),
                
                // Meaning Toggle
                GestureDetector(
                  onTap: _toggleMeaning,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: _showMeaning 
                          ? AppColors.primary.withOpacity(0.1)
                          : AppColors.surfaceVariant,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: _showMeaning 
                            ? AppColors.primary.withOpacity(0.3)
                            : AppColors.border,
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: _showMeaning
                              ? Text(
                                  widget.word.bangla,
                                  style: AppTypography.banglaBodyLarge.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                              : Text(
                                  'Tap to reveal meaning',
                                  style: AppTypography.bodyLarge.copyWith(
                                    color: AppColors.textSecondary,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                        ),
                        Icon(
                          _showMeaning ? Icons.visibility : Icons.visibility_off,
                          color: _showMeaning ? AppColors.primary : AppColors.textTertiary,
                        ),
                      ],
                    ),
                  ),
                )
                  .animate()
                  .fadeIn(delay: 600.ms, duration: 600.ms)
                  .slideY(begin: 0.3, end: 0),
              ],
            ),
          ),
          
          // Tab Bar
          Container(
            color: AppColors.surface,
            child: TabBar(
              controller: _tabController,
              labelColor: AppColors.primary,
              unselectedLabelColor: AppColors.textTertiary,
              indicatorColor: AppColors.primary,
              labelStyle: AppTypography.labelMedium.copyWith(
                fontWeight: FontWeight.w600,
              ),
              unselectedLabelStyle: AppTypography.labelMedium,
              tabs: const [
                Tab(text: 'Examples'),
                Tab(text: 'Synonyms'),
                Tab(text: 'Etymology'),
                Tab(text: 'Mnemonics'),
              ],
            ),
          ),
          
          // Tab Content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildExamplesTab(),
                _buildSynonymsTab(),
                _buildEtymologyTab(),
                _buildMnemonicsTab(),
              ],
            ),
          ),
          
          // Bottom Action
          Container(
            padding: const EdgeInsets.all(24),
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
            child: PrimaryButton(
              text: 'Got It! Next Word',
              onPressed: _markAsLearned,
              width: double.infinity,
              icon: Icons.check,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExamplesTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: widget.word.examples.length,
      itemBuilder: (context, index) {
        final example = widget.word.examples[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                example,
                style: AppTypography.bodyLarge.copyWith(
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    Icons.translate,
                    size: 16,
                    color: AppColors.textTertiary,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Tap to see translation',
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.textTertiary,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
          .animate()
          .fadeIn(delay: (index * 100).ms, duration: 400.ms)
          .slideX(begin: 0.3, end: 0);
      },
    );
  }

  Widget _buildSynonymsTab() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.word.synonyms.isNotEmpty) ...[
            Text(
              'Synonyms',
              style: AppTypography.titleLarge.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.success,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: widget.word.synonyms.map((synonym) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.success.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppColors.success.withOpacity(0.3),
                  ),
                ),
                child: Text(
                  synonym,
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.success,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )).toList(),
            ),
            const SizedBox(height: 24),
          ],

          if (widget.word.antonyms.isNotEmpty) ...[
            Text(
              'Antonyms',
              style: AppTypography.titleLarge.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.accent,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: widget.word.antonyms.map((antonym) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.accent.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppColors.accent.withOpacity(0.3),
                  ),
                ),
                child: Text(
                  antonym,
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.accent,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )).toList(),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildEtymologyTab() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.05),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.primary.withOpacity(0.2),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.history_edu,
                      color: AppColors.primary,
                      size: 24,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Word Origin',
                      style: AppTypography.titleMedium.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  widget.word.etymology ?? 'Etymology information not available for this word.',
                  style: AppTypography.bodyLarge.copyWith(
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMnemonicsTab() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.secondary.withOpacity(0.05),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.secondary.withOpacity(0.2),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.lightbulb,
                      color: AppColors.secondary,
                      size: 24,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Memory Trick',
                      style: AppTypography.titleMedium.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.secondary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  widget.word.mnemonic ?? 'No memory trick available yet. Create one to help remember this word!',
                  style: AppTypography.bodyLarge.copyWith(
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Community mnemonics section
          Text(
            'Community Tips',
            style: AppTypography.titleMedium.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Share your own memory tricks and see what others have created!',
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  void _toggleMeaning() {
    setState(() {
      _showMeaning = !_showMeaning;
    });
  }

  void _toggleBookmark() {
    setState(() {
      _isBookmarked = !_isBookmarked;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _isBookmarked ? 'Word bookmarked!' : 'Bookmark removed',
          style: AppTypography.bodyMedium.copyWith(
            color: AppColors.textOnPrimary,
          ),
        ),
        backgroundColor: _isBookmarked ? AppColors.success : AppColors.textSecondary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  void _playPronunciation() {
    // TODO: Implement audio playback
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Playing pronunciation...',
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

  void _markAsLearned() {
    // Mark word as learned and add XP
    context.read<LearningProvider>().markWordAsLearned(widget.word);
    context.read<UserProvider>().addXP(10);
    context.read<UserProvider>().incrementWordsLearned();

    Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Great! You earned 10 XP for learning "${widget.word.english}"',
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
