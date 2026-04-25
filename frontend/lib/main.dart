import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ratip/screens/splash_screen.dart';

void main() {
  runApp(
    const ProviderScope(
      child: RatipApp(),
    ),
  );
}

class RatipApp extends StatelessWidget {
  const RatipApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ratip',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF070235),
          primary: const Color(0xFF070235),
          secondary: const Color(0xFF006A61),
          surface: const Color(0xFFF8F9FF),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
