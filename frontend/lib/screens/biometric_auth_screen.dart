import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:ratip/theme/app_theme.dart';
import 'package:ratip/widgets/glass_container.dart';
import 'package:ratip/services/auth_service.dart';

class BiometricAuthScreen extends StatefulWidget {
  const BiometricAuthScreen({super.key});

  @override
  State<BiometricAuthScreen> createState() => _BiometricAuthScreenState();
}

class _BiometricAuthScreenState extends State<BiometricAuthScreen> {
  final AuthService _authService = AuthService();
  bool _isAuthenticating = false;

  Future<void> _handleAuth() async {
    setState(() => _isAuthenticating = true);
    final success = await _authService.authenticate();
    setState(() => _isAuthenticating = false);

    if (success && mounted) {
      // TODO(Phase 3): Navigate to MainMapScreen
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('✅ 인증 성공! 메인 화면으로 이동 예정입니다.'),
          backgroundColor: Color(0xFF4648D4),
        ),
      );
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Authentication Failed'), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Gradient
          Container(
            decoration: BoxDecoration(
              gradient: AppTheme.etherealGradient,
            ),
          ),

          // Blurred Decorative Elements (simulating the design)
          Positioned(
            top: 100,
            left: -50,
            child: _DecorativeCircle(color: AppTheme.primaryColor.withOpacity(0.1), size: 200),
          ),
          Positioned(
            bottom: 100,
            right: -50,
            child: _DecorativeCircle(color: const Color(0xFF6366F1).withOpacity(0.1), size: 250),
          ),

          // Content
          Center(
            child: ZoomIn(
              duration: const Duration(milliseconds: 500),
              child: GlassContainer(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 48),
                borderRadius: 28,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Icon
                    Container(
                      width: 80,
                      height: 80,
                      decoration: const BoxDecoration(
                        color: Color(0xFFE2DFFF),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.face,
                        size: 48,
                        color: AppTheme.primaryColor,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Title
                    const Text(
                      'Face ID',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Description
                    const Text(
                      'Do you want to allow "Ratip" to use Face ID?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: AppTheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 48),

                    // Buttons
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: _isAuthenticating ? null : _handleAuth,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primaryContainer,
                          foregroundColor: AppTheme.onPrimaryContainer,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 4,
                          shadowColor: AppTheme.primaryColor.withOpacity(0.3),
                        ),
                        child: _isAuthenticating
                            ? const CircularProgressIndicator(color: Colors.white)
                            : const Text(
                                'Use Biometrics',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: TextButton(
                        onPressed: () => Navigator.pop(context),
                        style: TextButton.styleFrom(
                          foregroundColor: AppTheme.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DecorativeCircle extends StatelessWidget {
  final Color color;
  final double size;

  const _DecorativeCircle({required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}
