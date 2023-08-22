import 'package:flutter/material.dart';

import 'app/ui/colors/colors.dart';
import 'app/routes/pro_routes.dart';

void main() {
  runApp(const OficinaUnexApp());
}

class OficinaUnexApp extends StatelessWidget {
  const OficinaUnexApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: ProColors.black,
        ),
        useMaterial3: true,
      ),
      initialRoute: '/playerTemplate',
      routes: proRoutes,
    );
  }
}
