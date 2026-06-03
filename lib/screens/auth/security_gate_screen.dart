// Copyright (c) 2026 Karim Asaad Qabil. All rights reserved.
// Licensed under the MIT License.

// Copyright (c) 2026 Karim Asaad Qabil. All rights reserved.
// Licensed under the MIT License.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../core/localization/app_localizations.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/security_utils.dart';
import 'dart:io';

// The access key is hardcoded for this "repository protection" requirement.
// In a real production app, this would be handled differently, 
// but for the user's specific request to prevent others from running it without a password:
const String _PROJECT_ACCESS_KEY = "KARIM-2026-SECURE";

class SecurityGateScreen extends StatefulWidget {
  const SecurityGateScreen({super.key});

  @override
  State<SecurityGateScreen> createState() => _SecurityGateScreenState();
}

class _SecurityGateScreenState extends State<SecurityGateScreen> {
  final TextEditingController _controller = TextEditingController();
  String? _errorMessage;
  bool _isCheckingSecurity = true;
  bool _isEnvironmentSafe = true;

  @override
  void initState() {
    super.initState();
    _checkSecurity();
  }

  Future<void> _checkSecurity() async {
    bool isSafe = await SecurityUtils.performSecurityCheck();
    if (mounted) {
      setState(() {
        _isEnvironmentSafe = isSafe;
        _isCheckingSecurity = false;
      });
    }
  }

  void _verifyKey() {
    if (_controller.text == _PROJECT_ACCESS_KEY) {
      context.go('/auth');
    } else {
      setState(() {
        _errorMessage = AppLocalizations.of(context)?.invalid_key ?? "Invalid Key";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    if (_isCheckingSecurity) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (!_isEnvironmentSafe) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(30.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.security_update_warning, size: 80, color: Colors.red),
                SizedBox(height: 24.h),
                Text(
                  "Security Violation",
                  style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold, color: Colors.red),
                ),
                SizedBox(height: 12.h),
                const Text(
                  "This app cannot run on rooted devices or emulators for security reasons.",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24.h),
                ElevatedButton(
                  onPressed: () => exit(0),
                  child: const Text("Exit App"),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(30.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.lock_person_rounded,
                size: 80.h,
                color: AppTheme.primaryBlue,
              ).animate().scale(duration: 600.ms, curve: Curves.backOut),
              SizedBox(height: 24.h),
              Text(
                l10n.security_gate_title,
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryBlue,
                ),
              ).animate().fadeIn(delay: 200.ms),
              SizedBox(height: 12.h),
              Text(
                l10n.security_gate_desc,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.grey[600],
                ),
              ).animate().fadeIn(delay: 300.ms),
              SizedBox(height: 40.h),
              TextField(
                controller: _controller,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: l10n.access_key,
                  errorText: _errorMessage,
                  prefixIcon: const Icon(Icons.key_rounded),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onSubmitted: (_) => _verifyKey(),
              ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.1, end: 0),
              SizedBox(height: 24.h),
              SizedBox(
                width: double.infinity,
                height: 50.h,
                child: ElevatedButton(
                  onPressed: _verifyKey,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryBlue,
                    shape: BorderRadius.circular(12),
                  ),
                  child: Text(
                    l10n.verify,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ).animate().fadeIn(delay: 500.ms).slideY(begin: 0.2, end: 0),
              SizedBox(height: 40.h),
              Text(
                "© 2026 Karim Asaad Qabil",
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
