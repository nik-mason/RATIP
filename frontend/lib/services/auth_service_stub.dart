// Stub classes to satisfy the compiler when local_auth is not available (e.g. on Web)
class LocalAuthentication {
  Future<bool> get canCheckBiometrics async => false;
  Future<bool> authenticate({
    required String localizedReason,
    dynamic options,
  }) async => false;
}

class AuthenticationOptions {
  const AuthenticationOptions({
    bool biometricOnly = false,
    bool stickyAuth = false,
  });
}
