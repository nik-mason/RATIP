import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ratip/theme/app_theme.dart';
import 'package:ratip/screens/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    await dotenv.load(fileName: "assets/.env");
  } catch (e) {
    debugPrint("Error loading .env file: $e");
  }
  
  try {
    await Supabase.initialize(
      url: dotenv.env['SUPABASE_URL'] ?? '',
      anonKey: dotenv.env['SUPABASE_ANON_KEY'] ?? '',
    );
  } catch (e) {
    debugPrint("Error initializing Supabase: $e");
  }

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
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
    );
  }
}
