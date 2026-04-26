// Web stub: local_auth is not supported on Web platform.
// This file is used only when compiling for Web.
class AuthService {
  Future<bool> checkBiometrics() async => false;

  Future<bool> authenticate() async => false;
}
