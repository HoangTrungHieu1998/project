import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class Authentication{
  static final _auth = LocalAuthentication();

  static Future<bool> hasBiometrics() async {
    try {
      return await _auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      return false;
    }
  }

  static Future<bool> hasDeviceSupport() async {
    try {
      return await _auth.isDeviceSupported();
    } on PlatformException catch (_) {
      return false;
    }
  }

  static Future<List<BiometricType>> getBiometrics() async {
    try {
      return await _auth.getAvailableBiometrics();
    } on PlatformException catch (_) {
      return <BiometricType>[];
    }
  }

  static Future<bool> authenticate() async {
    final isAvailable = await hasBiometrics();
    if (!isAvailable) return false;

    try {
      return await _auth.authenticate(
        biometricOnly: true,
        localizedReason: 'Scan Fingerprint to Authenticate',
        useErrorDialogs: true,
        stickyAuth: true,
      );
    } on PlatformException catch (_) {
      return false;
    }
  }
}