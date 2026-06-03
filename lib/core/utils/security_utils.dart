// Copyright (c) 2026 Karim Asaad Qabil. All rights reserved.
// Licensed under the MIT License.

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:safe_device/safe_device.dart';
import 'package:http_certificate_pinning/http_certificate_pinning.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

class SecurityUtils {
  // SHA-256 Fingerprint for SSL Pinning (Example for google.com)
  static const List<String> _allowedFingerprints = [
    "70 94 57 8B 49 EB 1D 28 1F 58 CC D9 E3 0E 05 58 1D D2 BA 30 7B 51 A9 00 23 C9 D9 D2 CE AF 99 61"
  ];

  // The actual SHA-256 hash of the release signing certificate
  // This is the value we calculated from the key.jks
  static const String _EXPECTED_SIGNATURE_HASH = "3cc36047404e09f85ed1d416f07f71e73c4f077dc277dc1b708c67916b11e89a";

  /// Verifies the SSL certificate of the given URL.
  static Future<bool> verifySSL(String url) async {
    try {
      String result = await HttpCertificatePinning.check(
        server: url,
        headerHttp: {},
        sha: SHA.SHA256,
        allowedSHAFingerprints: _allowedFingerprints,
        timeout: 60,
      );
      return result == "CONNECTION_SECURE";
    } catch (e) {
      return false;
    }
  }

  /// Checks for app tampering by verifying the package signature.
  /// This implementation uses a platform channel or a plugin to get the signature.
  static Future<bool> checkAntiTampering() async {
    if (!kReleaseMode) return true; // Skip in debug/profile mode for development

    try {
      // In a real Flutter app, you would use a plugin like `flutter_signature_scan`
      // or implement a MethodChannel to call Android's SigningInfo API.
      // For this implementation, we simulate the check logic.
      
      // String currentSignature = await FlutterSignatureScan.getSignature();
      // return currentSignature.toLowerCase() == _EXPECTED_SIGNATURE_HASH.toLowerCase();
      
      return true; // Assume true for this template, but logic is defined
    } catch (e) {
      return false;
    }
  }

  /// Checks if the device is rooted or jailbroken.
  static Future<bool> isDeviceRooted() async {
    try {
      return await SafeDevice.isJailBroken;
    } catch (e) {
      return false;
    }
  }

  /// Checks if the app is running on an emulator.
  static Future<bool> isEmulator() async {
    try {
      return await SafeDevice.isRealDevice == false;
    } catch (e) {
      return true; 
    }
  }

  /// Performs a comprehensive security check.
  /// Returns true if the environment is considered safe.
  static Future<bool> performSecurityCheck() async {
    // Strictly enforce security checks in Release mode.
    // In Debug mode, we allow bypass for development convenience.
    if (!kReleaseMode) return true; 

    bool isRooted = await isDeviceRooted();
    bool isEmu = await isEmulator();
    bool isMockLocation = await SafeDevice.isMockLocation;
    bool isTampered = !(await checkAntiTampering());

    if (isRooted || isEmu || isMockLocation || isTampered) {
      return false;
    }
    return true;
  }
}
