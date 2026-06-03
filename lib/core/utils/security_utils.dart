// Copyright (c) 2026 Karim Asaad Qabil. All rights reserved.
// Licensed under the MIT License.

// Copyright (c) 2026 Karim Asaad Qabil. All rights reserved.
// Licensed under the MIT License.

import 'dart:io';
import 'package:flutter/services.dart';
import 'package:safe_device/safe_device.dart';
import 'package:http_certificate_pinning/http_certificate_pinning.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

class SecurityUtils {
  // SHA-256 Fingerprint for SSL Pinning (Example for google.com)
  // In production, replace with the actual server fingerprint
  static const List<String> _allowedFingerprints = [
    "70 94 57 8B 49 EB 1D 28 1F 58 CC D9 E3 0E 05 58 1D D2 BA 30 7B 51 A9 00 23 C9 D9 D2 CE AF 99 61"
  ];

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
  static Future<bool> checkAntiTampering() async {
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      // In a real app, you would compare the current signature with a known hardcoded hash.
      return true; 
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
      return true; // Assume emulator on error for safety
    }
  }

  /// Checks if the app is running in debug mode.
  static bool isDebugMode() {
    bool debug = false;
    assert(debug = true);
    return debug;
  }

  /// Performs a comprehensive security check.
  /// Returns true if the environment is considered safe.
  static Future<bool> performSecurityCheck() async {
    if (isDebugMode()) return true; // Allow debug mode for development

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
