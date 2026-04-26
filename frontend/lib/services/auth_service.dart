import 'package:flutter/foundation.dart';
// Conditional import to prevent web build from crashing on local_auth
import 'auth_service_stub.dart' if (dart.library.io) 'package:local_auth/local_auth.dart' as auth;

class AuthService {
  // Use dynamic to avoid type errors on web
  final dynamic _localAuth = kIsWeb ? null : auth.LocalAuthentication();

  Future<bool> checkBiometrics() async {
    if (kIsWeb) return false;
    try {
      return await _localAuth.canCheckBiometrics;
    } catch (e) {
      return false;
    }
  }

  Future<bool> authenticate() async {
    if (kIsWeb) return false;
    try {
      return await _localAuth.authenticate(
        localizedReason: 'Please authenticate to access your account',
        options: const auth.AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
        ),
      );
    } catch (e) {
      return false;
    }
  }
}
