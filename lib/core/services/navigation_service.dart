import 'package:flutter/material.dart';

/// Navigation service for managing app navigation
class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  
  static NavigatorState? get navigator => navigatorKey.currentState;
  static BuildContext? get context => navigatorKey.currentContext;
  
  // Navigation methods
  static Future<T?> pushNamed<T>(String routeName, {Object? arguments}) {
    return navigator!.pushNamed<T>(routeName, arguments: arguments);
  }
  
  static Future<T?> pushReplacementNamed<T, TO>(String routeName, {Object? arguments}) {
    return navigator!.pushReplacementNamed<T, TO>(routeName, arguments: arguments);
  }
  
  static Future<T?> pushNamedAndClearStack<T>(String routeName, {Object? arguments}) {
    return navigator!.pushNamedAndRemoveUntil<T>(
      routeName,
      (route) => false,
      arguments: arguments,
    );
  }
  
  static void pop<T>([T? result]) {
    return navigator!.pop<T>(result);
  }
  
  static void popUntil(String routeName) {
    return navigator!.popUntil(ModalRoute.withName(routeName));
  }
  
  static Future<T?> push<T>(Widget page) {
    return navigator!.push<T>(
      MaterialPageRoute(builder: (context) => page),
    );
  }
  
  static Future<T?> pushReplacement<T, TO>(Widget page) {
    return navigator!.pushReplacement<T, TO>(
      MaterialPageRoute(builder: (context) => page),
    );
  }
  
  // Custom transitions
  static Future<T?> pushWithSlideTransition<T>(
    Widget page, {
    Offset begin = const Offset(1.0, 0.0),
    Offset end = Offset.zero,
    Duration duration = const Duration(milliseconds: 300),
  }) {
    return navigator!.push<T>(
      PageRouteBuilder<T>(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionDuration: duration,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: begin,
              end: end,
            ).animate(CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOut,
            )),
            child: child,
          );
        },
      ),
    );
  }
  
  static Future<T?> pushWithFadeTransition<T>(
    Widget page, {
    Duration duration = const Duration(milliseconds: 300),
  }) {
    return navigator!.push<T>(
      PageRouteBuilder<T>(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionDuration: duration,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    );
  }
  
  static Future<T?> pushWithScaleTransition<T>(
    Widget page, {
    Duration duration = const Duration(milliseconds: 300),
  }) {
    return navigator!.push<T>(
      PageRouteBuilder<T>(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionDuration: duration,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return ScaleTransition(
            scale: Tween<double>(
              begin: 0.0,
              end: 1.0,
            ).animate(CurvedAnimation(
              parent: animation,
              curve: Curves.elasticOut,
            )),
            child: child,
          );
        },
      ),
    );
  }
}
