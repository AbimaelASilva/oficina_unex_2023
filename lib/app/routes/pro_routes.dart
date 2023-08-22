import 'package:flutter/material.dart';

import '../ui/templates/templates.dart';

Map<String, Widget Function(BuildContext)> get proRoutes => {
      '/': (context) => const GetStardedTemplate(),
      '/playerTemplate': (context) => const PlayerTemplate(),
    };
