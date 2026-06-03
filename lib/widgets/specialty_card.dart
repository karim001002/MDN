// Copyright (c) 2026 Karim Asaad Qabil. All rights reserved.
// Licensed under the MIT License.

// Copyright (c) 2026 Karim Asaad Qabil. All rights reserved.
// Licensed under the MIT License.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../core/localization/app_localizations.dart';
import '../models/specialty.dart';
import '../screens/doctor/doctor_list_screen.dart';
import '../core/theme/app_theme.dart';

class SpecialtyCard extends ConsumerWidget {
  final Specialty specialty;
  const SpecialtyCard({super.key, required this.specialty});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = Localizations.localeOf(context).languageCode;

    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => DoctorListScreen(specialty: specialty)));
      },
      child: Container(
        width: 100.w,
        margin: EdgeInsets.only(right: 12.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFF1F3F4), width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.primaryBlue.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                _getIconForSpecialty(specialty.id), 
                size: 28.sp, 
                color: AppTheme.primaryBlue
              ),
            ),
            SizedBox(height: 12.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Text(
                specialty.getName(locale),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13.sp, 
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textDark,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ).animate().fadeIn(duration: 400.ms).scale(delay: 100.ms),
    );
  }

  IconData _getIconForSpecialty(String id) {
    switch (id) {
      case 'internal_medicine': return Icons.healing;
      case 'surgery': return Icons.medical_services;
      case 'pediatrics': return Icons.child_care;
      case 'obstetrics_gynecology': return Icons.pregnant_woman;
      case 'ophthalmology': return Icons.visibility;
      case 'dermatology': return Icons.spa;
      case 'psychiatry': return Icons.psychology;
      case 'dentistry': return Icons.tooth; // Note: Use font_awesome or custom if needed, using generic for now
      case 'ent': return Icons.hearing;
      default: return Icons.category;
    }
  }
}
