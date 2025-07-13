<<<<<<< HEAD
# Vocab Hero - The Ultimate English Vocabulary App

A comprehensive Flutter application designed to help Bangladeshi learners master English vocabulary through gamified learning experiences.

## 🎯 Project Vision

Transform vocabulary building from a chore into a delightful daily habit, empowering users to master English for their daily lives, academic success, and global opportunities like the IELTS exam.

## ✨ Key Features

### 🎮 Gamified Learning
- **XP System**: Earn experience points for every learning activity
- **Level Progression**: Unlock new features and content as you advance
- **Streak System**: Maintain daily learning streaks with visual flame indicators
- **Achievements**: Collect badges for reaching milestones
- **Gems Currency**: Earn and spend gems on cosmetic and functional items

### 📚 Structured Learning Paths
- **Spoken English Power-Up**: Conversational words, idioms, and phrasal verbs
- **Academic & Professional Writing**: Formal vocabulary for essays and reports
- **IELTS Excellence**: High-frequency academic vocabulary and test preparation

### 🧠 Smart Learning Features
- **Spaced Repetition**: Brain Boost system for optimal word retention
- **Contextual Learning**: Real-world examples and practical usage scenarios
- **Pronunciation Practice**: Audio playback and speech recognition
- **Etymology & Mnemonics**: Word origins and memory tricks

### 🌟 User Experience
- **Personalized Onboarding**: Goal selection and placement testing
- **Beautiful UI**: Clean, modern design with smooth animations
- **Bilingual Support**: English and Bangla translations
- **Progress Tracking**: Detailed statistics and learning analytics

## 🏗️ Architecture

### Design System
- **Colors**: Vibrant teal primary, sunshine yellow secondary, warm coral accent
- **Typography**: Poppins for English, Hind Siliguri for Bangla
- **Components**: Reusable widgets with consistent styling
- **Animations**: Smooth transitions using Flutter Animate

### State Management
- **Provider Pattern**: Clean separation of concerns
- **User Provider**: Profile, XP, streaks, and preferences
- **Learning Provider**: Vocabulary sessions and progress
- **App State Provider**: Global app settings and navigation

### Project Structure
```
lib/
├── core/
│   ├── theme/           # Design system and theming
│   ├── widgets/         # Reusable UI components
│   ├── providers/       # State management
│   └── services/        # Navigation and utilities
├── features/
│   ├── onboarding/      # Welcome, goals, placement test
│   ├── home/           # Dashboard and main navigation
│   └── learning/       # Word details and learning sessions
└── main.dart           # App entry point
```

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (>=3.0.0)
- Dart SDK
- Android Studio / VS Code
- Android/iOS device or emulator

### Installation
1. Clone the repository
```bash
git clone https://github.com/your-username/vocab-hero.git
cd vocab-hero
```

2. Install dependencies
```bash
flutter pub get
```

3. Run the app
```bash
flutter run
```

## 📱 Screens Overview

### Onboarding Flow
1. **Splash Screen**: Animated app introduction
2. **Welcome Screens**: Feature highlights with smooth page transitions
3. **Goal Selection**: Choose learning objectives with visual cards
4. **Placement Test**: Adaptive vocabulary assessment

### Main Application
1. **Home Dashboard**: XP progress, current path, quick actions
2. **Word Detail**: Comprehensive word learning with tabs
3. **Learning Sessions**: Interactive vocabulary practice
4. **Quiz System**: Multiple choice, fill-in-the-blank, matching
5. **Pronunciation Practice**: Speech recognition with feedback

## 🎨 Design Highlights

### Color Palette
- **Primary**: Vibrant Teal (#00A99D) - Trust and progress
- **Secondary**: Sunshine Yellow (#FFD100) - Energy and rewards
- **Accent**: Warm Coral (#FF6B6B) - Attention and alerts
- **Success**: Bright Green (#7ED321) - Achievements
- **Background**: Off-white (#F7F8FA) - Clean and spacious

### Typography
- **English**: Poppins - Modern, highly readable sans-serif
- **Bangla**: Hind Siliguri - Clear and aesthetic Bengali font
- **Hierarchy**: Consistent sizing and weights for optimal readability

### Animations
- **Entrance**: Fade-in and slide animations for content
- **Interactions**: Scale and shimmer effects for engagement
- **Progress**: Smooth transitions for XP bars and indicators
- **Celebrations**: Confetti and scale animations for achievements

## 🔧 Technical Features

### Performance
- **Optimized Widgets**: Efficient rendering with const constructors
- **Lazy Loading**: On-demand content loading
- **Memory Management**: Proper disposal of controllers and listeners

### Accessibility
- **Color Contrast**: WCAG compliant color combinations
- **Font Sizes**: Scalable text for different screen sizes
- **Haptic Feedback**: Tactile responses for interactions

### Responsive Design
- **Adaptive Layouts**: Works on various screen sizes
- **Safe Areas**: Proper handling of notches and system UI
- **Orientation**: Portrait-optimized with landscape support

## 🛠️ Development

### Code Quality
- **Linting**: Comprehensive rules for consistent code style
- **Documentation**: Detailed comments and README
- **Error Handling**: Graceful error states and user feedback

### Testing Strategy
- **Unit Tests**: Core logic and provider testing
- **Widget Tests**: UI component verification
- **Integration Tests**: End-to-end user flows

## 📈 Future Enhancements

### Phase 2 Features
- **Social Learning**: Friends, leaderboards, and competitions
- **Offline Mode**: Download content for offline learning
- **Advanced Analytics**: Detailed learning insights and recommendations
- **Custom Word Lists**: User-created vocabulary collections

### Phase 3 Features
- **AI Tutor**: Personalized learning recommendations
- **Voice Assistant**: Conversational practice with AI
- **AR Features**: Augmented reality word recognition
- **Multi-language**: Support for additional languages

## 🤝 Contributing

We welcome contributions! Please read our contributing guidelines and submit pull requests for any improvements.

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Google Fonts for typography resources
- Lottie for beautiful animations
- The Bangladeshi learning community for inspiration

---

**Vocab Hero** - Master English, One Word at a Time! 🚀
