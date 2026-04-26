// Web stub: local_auth is not supported on Web platform.
// This file is used only when compiling for Web.
class AuthService {
  Future<bool> checkBiometrics() async => true;

  Future<bool> authenticate() async {
    // 웹에서는 생체 인식을 지원하지 않으므로, 테스트를 위해 1초 대기 후 무조건 성공(true)을 반환합니다.
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }
}
