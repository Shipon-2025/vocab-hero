import 'package:flutter/material.dart';

/// User data and profile management
class UserProvider extends ChangeNotifier {
  String _userName = '';
  String _userAvatar = '';
  int _currentLevel = 1;
  int _currentXP = 0;
  int _xpToNextLevel = 100;
  int _totalXP = 0;
  int _currentStreak = 0;
  int _longestStreak = 0;
  int _gemsCount = 0;
  int _wordsLearned = 0;
  DateTime? _lastActiveDate;
  String _currentLearningPath = '';
  String _currentModule = '';
  double _moduleProgress = 0.0;
  
  // User goals and preferences
  LearningGoal _primaryGoal = LearningGoal.spokenEnglish;
  VocabularyLevel _vocabularyLevel = VocabularyLevel.beginner;
  int _dailyWordTarget = 5;
  bool _reminderEnabled = true;
  TimeOfDay _reminderTime = const TimeOfDay(hour: 19, minute: 0);
  
  // Getters
  String get userName => _userName;
  String get userAvatar => _userAvatar;
  int get currentLevel => _currentLevel;
  int get currentXP => _currentXP;
  int get xpToNextLevel => _xpToNextLevel;
  int get totalXP => _totalXP;
  int get currentStreak => _currentStreak;
  int get longestStreak => _longestStreak;
  int get gemsCount => _gemsCount;
  int get wordsLearned => _wordsLearned;
  DateTime? get lastActiveDate => _lastActiveDate;
  String get currentLearningPath => _currentLearningPath;
  String get currentModule => _currentModule;
  double get moduleProgress => _moduleProgress;
  LearningGoal get primaryGoal => _primaryGoal;
  VocabularyLevel get vocabularyLevel => _vocabularyLevel;
  int get dailyWordTarget => _dailyWordTarget;
  bool get reminderEnabled => _reminderEnabled;
  TimeOfDay get reminderTime => _reminderTime;
  
  // Calculated properties
  double get levelProgress => _currentXP / _xpToNextLevel;
  bool get isStreakActive {
    if (_lastActiveDate == null) return false;
    final now = DateTime.now();
    final difference = now.difference(_lastActiveDate!).inDays;
    return difference <= 1;
  }
  
  // User profile methods
  void setUserName(String name) {
    _userName = name;
    notifyListeners();
  }
  
  void setUserAvatar(String avatar) {
    _userAvatar = avatar;
    notifyListeners();
  }
  
  // XP and Level management
  void addXP(int xp) {
    _currentXP += xp;
    _totalXP += xp;
    
    // Check for level up
    while (_currentXP >= _xpToNextLevel) {
      _currentXP -= _xpToNextLevel;
      _currentLevel++;
      _xpToNextLevel = _calculateXPForNextLevel(_currentLevel);
      // TODO: Trigger level up celebration
    }
    
    notifyListeners();
  }
  
  int _calculateXPForNextLevel(int level) {
    // Progressive XP requirement: 100 + (level * 50)
    return 100 + (level * 50);
  }
  
  // Streak management
  void updateStreak() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    
    if (_lastActiveDate == null) {
      _currentStreak = 1;
    } else {
      final lastActive = DateTime(
        _lastActiveDate!.year,
        _lastActiveDate!.month,
        _lastActiveDate!.day,
      );
      
      final daysDifference = today.difference(lastActive).inDays;
      
      if (daysDifference == 1) {
        // Consecutive day
        _currentStreak++;
      } else if (daysDifference > 1) {
        // Streak broken
        _currentStreak = 1;
      }
      // If daysDifference == 0, same day, no change needed
    }
    
    _lastActiveDate = now;
    
    if (_currentStreak > _longestStreak) {
      _longestStreak = _currentStreak;
    }
    
    notifyListeners();
  }
  
  // Gems management
  void addGems(int gems) {
    _gemsCount += gems;
    notifyListeners();
  }
  
  void spendGems(int gems) {
    if (_gemsCount >= gems) {
      _gemsCount -= gems;
      notifyListeners();
    }
  }
  
  // Learning progress
  void incrementWordsLearned() {
    _wordsLearned++;
    notifyListeners();
  }
  
  void setCurrentLearningPath(String path) {
    _currentLearningPath = path;
    notifyListeners();
  }
  
  void setCurrentModule(String module) {
    _currentModule = module;
    notifyListeners();
  }
  
  void updateModuleProgress(double progress) {
    _moduleProgress = progress.clamp(0.0, 1.0);
    notifyListeners();
  }
  
  // Goal and preferences
  void setPrimaryGoal(LearningGoal goal) {
    _primaryGoal = goal;
    notifyListeners();
  }
  
  void setVocabularyLevel(VocabularyLevel level) {
    _vocabularyLevel = level;
    notifyListeners();
  }
  
  void setDailyWordTarget(int target) {
    _dailyWordTarget = target;
    notifyListeners();
  }
  
  void setReminderEnabled(bool enabled) {
    _reminderEnabled = enabled;
    notifyListeners();
  }
  
  void setReminderTime(TimeOfDay time) {
    _reminderTime = time;
    notifyListeners();
  }
}

enum LearningGoal {
  spokenEnglish,
  academicWriting,
  ieltsExcellence,
}

enum VocabularyLevel {
  beginner,
  intermediate,
  advanced,
}
