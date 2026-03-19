import 'package:flutter/material.dart';

import 'app.dart';
import '../features/splash/presentation/screens/splash_screen.dart';

class AppRoutes {
  static const splash = '/splash';
  static const home = '/';

  static final Map<String, WidgetBuilder> routes = {
    splash: (_) => const SplashScreen(),
    home: (_) => const HomeScreen(),
  };
}
