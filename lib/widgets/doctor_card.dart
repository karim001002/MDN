// Copyright (c) 2026 Karim Asaad Qabil. All rights reserved.
// Licensed under the MIT License.

// Copyright (c) 2026 Karim Asaad Qabil. All rights reserved.
// Licensed under the MIT License.

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../core/localization/app_localizations.dart';
import '../models/doctor.dart';
import '../providers/doctor_provider.dart';
import '../screens/doctor/doctor_detail_screen.dart';
import '../core/theme/app_theme.dart';

class DoctorCard extends ConsumerWidget {
  final Doctor doctor;
  const DoctorCard({super.key, required this.doctor});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appLocalizations = AppLocalizations.of(context);
    final userId = 'test_user_id'; 
    final isFavoriteAsyncValue = ref.watch(favoriteDoctorProvider((userId: userId, doctorId: doctor.id)));

    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => DoctorDetailScreen(doctor: doctor))),
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: CachedNetworkImage(
                    imageUrl: doctor.image,
                    width: 80.w,
                    height: 80.w,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(color: Colors.grey[200]),
                    errorWidget: (context, url, error) => Container(
                      color: AppTheme.secondaryBlue,
                      child: Icon(Icons.person, color: AppTheme.primaryBlue),
                    ),
                  ),
                ),
                if (doctor.isOnline)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        doctor.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                          color: AppTheme.textDark,
                        ),
                      ),
                      isFavoriteAsyncValue.when(
                        data: (isFavorite) => GestureDetector(
                          onTap: () {
                            ref.read(doctorListProvider.notifier).toggleFavorite(userId, doctor.id);
                          },
                          child: Icon(
                            isFavorite ? Icons.bookmark : Icons.bookmark_border,
                            color: isFavorite ? AppTheme.primaryBlue : AppTheme.textLight,
                            size: 22.sp,
                          ),
                        ),
                        loading: () => const SizedBox.shrink(),
                        error: (error, stack) => const SizedBox.shrink(),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    doctor.branch,
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: AppTheme.textLight,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      _buildBadge(
                        'CIS: ${doctor.cis}',
                        AppTheme.primaryBlue.withOpacity(0.1),
                        AppTheme.primaryBlue,
                      ),
                      SizedBox(width: 8.w),
                      _buildBadge(
                        '${doctor.successRate}% Success',
                        Colors.green.withOpacity(0.1),
                        Colors.green,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.1, end: 0),
    );
  }

  Widget _buildBadge(String text, Color bgColor, Color textColor) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11.sp,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
    );
  }
}
