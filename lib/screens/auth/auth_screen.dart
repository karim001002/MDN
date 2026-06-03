// Copyright (c) 2026 Karim Asaad Qabil. All rights reserved.
// Licensed under the MIT License.

// Copyright (c) 2026 Karim Asaad Qabil. All rights reserved.
// Licensed under the MIT License.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/localization/app_localizations.dart';
import '../../core/theme/app_theme.dart';
import '../../providers/app_provider.dart';

class AuthScreen extends ConsumerWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appLocalizations = AppLocalizations.of(context);
    final locale = ref.watch(localeProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20.h),
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppTheme.secondaryBlue,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.language, color: AppTheme.primaryBlue, size: 20),
                  ),
                  onPressed: () {
                    final newLocale = locale.languageCode == 'en' 
                        ? const Locale('ar') 
                        : const Locale('en');
                    ref.read(localeProvider.notifier).state = newLocale;
                  },
                ),
              ),
              SizedBox(height: 40.h),
              
              // App Logo or Illustration
              Container(
                height: 120.h,
                width: 120.h,
                decoration: BoxDecoration(
                  color: AppTheme.primaryBlue.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.medical_services_rounded, size: 60.h, color: AppTheme.primaryBlue),
              ).animate().scale(duration: 600.ms, curve: Curves.backOut),
              
              SizedBox(height: 30.h),
              Text(
                appLocalizations.app_name,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: AppTheme.primaryBlue,
                  fontWeight: FontWeight.bold,
                ),
              ).animate().fadeIn(delay: 300.ms),
              
              SizedBox(height: 50.h),
              
              TextField(
                decoration: InputDecoration(
                  hintText: appLocalizations.email,
                  prefixIcon: const Icon(Icons.email_outlined),
                ),
              ).animate().fadeIn(delay: 400.ms).slideX(),
              
              SizedBox(height: 20.h),
              
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Password", // Add to arb if needed
                  prefixIcon: const Icon(Icons.lock_outline),
                ),
              ).animate().fadeIn(delay: 500.ms).slideX(),
              
              SizedBox(height: 40.h),
              
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed("/home");
                },
                child: Text(appLocalizations.login),
              ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.2, end: 0),
              
              SizedBox(height: 20.h),
              
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed("/register_doctor");
                },
                child: Text(
                  appLocalizations.register_dr,
                  style: TextStyle(
                    color: AppTheme.primaryBlue,
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                  ),
                ),
              ).animate().fadeIn(delay: 700.ms),
              
              SizedBox(height: 40.h),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(height: 1, width: 50, color: Colors.grey[300]),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text("Or continue with", style: TextStyle(color: Colors.grey[500])),
                  ),
                  Container(height: 1, width: 50, color: Colors.grey[300]),
                ],
              ),
              
              SizedBox(height: 30.h),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildSocialButton(Icons.g_mobiledata, Colors.red),
                  SizedBox(width: 20.w),
                  _buildSocialButton(Icons.apple, Colors.black),
                  SizedBox(width: 20.w),
                  _buildSocialButton(Icons.facebook, Colors.blue[800]!),
                ],
              ).animate().fadeIn(delay: 800.ms),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSocialButton(IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[200]!),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Icon(icon, size: 30, color: color),
    );
  }
}
