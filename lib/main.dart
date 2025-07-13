import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import 'core/theme/app_theme.dart';
import 'core/providers/app_state_provider.dart';
import 'core/providers/user_provider.dart';
import 'core/providers/learning_provider.dart';
import 'features/onboarding/screens/splash_screen.dart';
import 'features/home/screens/home_screen.dart';
import 'core/services/navigation_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
  
  runApp(const VocabHeroApp());
}

class VocabHeroApp extends StatelessWidget {
  const VocabHeroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppStateProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => LearningProvider()),
      ],
      child: MaterialApp(
        title: 'Vocab Hero',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.light,
        navigatorKey: NavigationService.navigatorKey,
        home: const SplashScreen(),
        routes: {
          '/home': (context) => const HomeScreen(),
          '/splash': (context) => const SplashScreen(),
        },
      ),
    );
  }
}
