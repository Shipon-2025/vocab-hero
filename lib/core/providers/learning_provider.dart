import 'package:flutter/material.dart';

/// Learning session and vocabulary management
class LearningProvider extends ChangeNotifier {
  List<Word> _todaysWords = [];
  List<Word> _reviewWords = [];
  List<Word> _masteredWords = [];
  Word? _currentWord;
  int _currentWordIndex = 0;
  bool _isLearningSession = false;
  bool _isQuizSession = false;
  bool _isPronunciationSession = false;
  
  // Quiz state
  int _quizScore = 0;
  int _quizTotal = 0;
  List<QuizQuestion> _currentQuiz = [];
  int _currentQuestionIndex = 0;
  
  // Pronunciation state
  double _pronunciationAccuracy = 0.0;
  String _pronunciationFeedback = '';
  
  // Getters
  List<Word> get todaysWords => _todaysWords;
  List<Word> get reviewWords => _reviewWords;
  List<Word> get masteredWords => _masteredWords;
  Word? get currentWord => _currentWord;
  int get currentWordIndex => _currentWordIndex;
  bool get isLearningSession => _isLearningSession;
  bool get isQuizSession => _isQuizSession;
  bool get isPronunciationSession => _isPronunciationSession;
  int get quizScore => _quizScore;
  int get quizTotal => _quizTotal;
  List<QuizQuestion> get currentQuiz => _currentQuiz;
  int get currentQuestionIndex => _currentQuestionIndex;
  double get pronunciationAccuracy => _pronunciationAccuracy;
  String get pronunciationFeedback => _pronunciationFeedback;
  
  // Calculated properties
  double get quizProgress => _quizTotal > 0 ? _quizScore / _quizTotal : 0.0;
  bool get hasMoreWords => _currentWordIndex < _todaysWords.length - 1;
  bool get hasMoreQuestions => _currentQuestionIndex < _currentQuiz.length - 1;
  
  // Learning session management
  void startLearningSession(List<Word> words) {
    _todaysWords = words;
    _currentWordIndex = 0;
    _currentWord = words.isNotEmpty ? words[0] : null;
    _isLearningSession = true;
    notifyListeners();
  }
  
  void nextWord() {
    if (hasMoreWords) {
      _currentWordIndex++;
      _currentWord = _todaysWords[_currentWordIndex];
      notifyListeners();
    }
  }
  
  void previousWord() {
    if (_currentWordIndex > 0) {
      _currentWordIndex--;
      _currentWord = _todaysWords[_currentWordIndex];
      notifyListeners();
    }
  }
  
  void markWordAsLearned(Word word) {
    word.isLearned = true;
    word.lastReviewDate = DateTime.now();
    notifyListeners();
  }
  
  void markWordAsMastered(Word word) {
    word.isMastered = true;
    word.masteryDate = DateTime.now();
    _masteredWords.add(word);
    notifyListeners();
  }
  
  void endLearningSession() {
    _isLearningSession = false;
    _currentWord = null;
    _currentWordIndex = 0;
    notifyListeners();
  }
  
  // Quiz management
  void startQuiz(List<QuizQuestion> questions) {
    _currentQuiz = questions;
    _currentQuestionIndex = 0;
    _quizScore = 0;
    _quizTotal = questions.length;
    _isQuizSession = true;
    notifyListeners();
  }
  
  void answerQuestion(bool isCorrect) {
    if (isCorrect) {
      _quizScore++;
    }
    
    if (hasMoreQuestions) {
      _currentQuestionIndex++;
    }
    
    notifyListeners();
  }
  
  void endQuiz() {
    _isQuizSession = false;
    _currentQuestionIndex = 0;
    notifyListeners();
  }
  
  // Pronunciation management
  void startPronunciationSession(Word word) {
    _currentWord = word;
    _isPronunciationSession = true;
    _pronunciationAccuracy = 0.0;
    _pronunciationFeedback = '';
    notifyListeners();
  }
  
  void updatePronunciationResult(double accuracy, String feedback) {
    _pronunciationAccuracy = accuracy;
    _pronunciationFeedback = feedback;
    notifyListeners();
  }
  
  void endPronunciationSession() {
    _isPronunciationSession = false;
    _currentWord = null;
    _pronunciationAccuracy = 0.0;
    _pronunciationFeedback = '';
    notifyListeners();
  }
  
  // Review system (Spaced Repetition)
  void addWordToReview(Word word) {
    if (!_reviewWords.contains(word)) {
      _reviewWords.add(word);
      notifyListeners();
    }
  }
  
  void removeWordFromReview(Word word) {
    _reviewWords.remove(word);
    notifyListeners();
  }
  
  List<Word> getWordsForReview() {
    final now = DateTime.now();
    return _reviewWords.where((word) {
      if (word.lastReviewDate == null) return true;
      final daysSinceReview = now.difference(word.lastReviewDate!).inDays;
      return daysSinceReview >= word.reviewInterval;
    }).toList();
  }
}

class Word {
  final String id;
  final String english;
  final String bangla;
  final String partOfSpeech;
  final List<String> examples;
  final List<String> synonyms;
  final List<String> antonyms;
  final String? etymology;
  final String? mnemonic;
  final String? audioUrl;
  final String difficulty;
  final List<String> tags;
  
  bool isLearned;
  bool isMastered;
  DateTime? lastReviewDate;
  DateTime? masteryDate;
  int reviewInterval;
  double pronunciationScore;
  
  Word({
    required this.id,
    required this.english,
    required this.bangla,
    required this.partOfSpeech,
    required this.examples,
    this.synonyms = const [],
    this.antonyms = const [],
    this.etymology,
    this.mnemonic,
    this.audioUrl,
    this.difficulty = 'medium',
    this.tags = const [],
    this.isLearned = false,
    this.isMastered = false,
    this.lastReviewDate,
    this.masteryDate,
    this.reviewInterval = 1,
    this.pronunciationScore = 0.0,
  });
}

class QuizQuestion {
  final String id;
  final String question;
  final List<String> options;
  final int correctAnswerIndex;
  final QuizType type;
  final Word relatedWord;
  
  QuizQuestion({
    required this.id,
    required this.question,
    required this.options,
    required this.correctAnswerIndex,
    required this.type,
    required this.relatedWord,
  });
}

enum QuizType {
  multipleChoice,
  fillInTheBlank,
  matching,
  imageQuiz,
}
