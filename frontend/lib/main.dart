import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ratip/theme/app_theme.dart';
import 'package:ratip/screens/login_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    await dotenv.load(fileName: "assets/.env");
    debugPrint("Loaded .env: ${dotenv.env.keys.join(', ')}");
  } catch (e) {
    debugPrint("Error loading .env file: $e");
  }
  
  final supabaseUrl = (dotenv.env['SUPABASE_URL'] ?? '').trim().replaceAll('"', '');
  final supabaseAnonKey = (dotenv.env['SUPABASE_ANON_KEY'] ?? '').trim().replaceAll('"', '');

  if (supabaseUrl.isEmpty || supabaseAnonKey.isEmpty) {
    debugPrint("Critical Error: Supabase credentials are missing from .env");
  }

  try {
    await Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseAnonKey,
    );
    debugPrint("Supabase initialized successfully");
  } catch (e) {
    debugPrint("Error initializing Supabase: $e");
    // Show a global error if initialization fails
    runApp(MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text("Supabase 초기화 실패: $e\n.env 파일을 확인해주세요."),
        ),
      ),
    ));
    return;
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
      home: const LoginScreen(),
    );
  }
}
