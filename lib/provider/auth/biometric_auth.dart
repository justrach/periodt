import 'package:local_auth/local_auth.dart';

class BiometricAuth {
  final LocalAuthentication _auth = LocalAuthentication();

  Future<bool> isBiometricAvailable() async {
    bool canCheckBiometrics = await _auth.canCheckBiometrics;
    return canCheckBiometrics;
  }

  Future<bool> authenticateWithBiometrics() async {
    bool isAuthenticated = await _auth.authenticate(
      localizedReason: 'Authenticate to access your account',
      // useErrorDialogs: true,
      // stickyAuth: true,
    );
    return isAuthenticated;
  }
}