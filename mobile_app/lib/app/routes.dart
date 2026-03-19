import 'package:flutter/material.dart';

import 'app.dart';

class AppRoutes {
  static const home = '/';

  static final Map<String, WidgetBuilder> routes = {
    home: (_) => const HomeScreen(),
  };
}
