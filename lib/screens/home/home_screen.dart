// Copyright (c) 2026 Karim Asaad Qabil. All rights reserved.
// Licensed under the MIT License.

// Copyright (c) 2026 Karim Asaad Qabil. All rights reserved.
// Licensed under the MIT License.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/localization/app_localizations.dart';
import '../../providers/doctor_provider.dart';
import '../../providers/app_provider.dart';
import '../../widgets/specialty_card.dart';
import '../../widgets/doctor_card.dart';
import '../../core/theme/app_theme.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appLocalizations = AppLocalizations.of(context);
    final specialtiesAsyncValue = ref.watch(specialtiesProvider);
    final onlineDoctorsAsyncValue = ref.watch(onlineDoctorsProvider);
    final locale = ref.watch(localeProvider);

    return Scaffold(
      backgroundColor: AppTheme.backgroundWhite,
      appBar: AppBar(
        title: Text(
          appLocalizations.app_name,
          style: TextStyle(color: AppTheme.primaryBlue, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
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
          SizedBox(width: 10),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // Refresh logic
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Bar
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: appLocalizations.search_specialty,
                    prefixIcon: const Icon(Icons.search, color: AppTheme.textLight),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(height: 25.h),

              // Quick Actions
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildQuickAction(
                    context, 
                    Icons.local_hospital, 
                    appLocalizations.hospital_network,
                    AppTheme.primaryBlue,
                  ),
                  _buildQuickAction(
                    context, 
                    Icons.swap_horiz, 
                    appLocalizations.referrals,
                    AppTheme.accentTeal,
                  ),
                  _buildQuickAction(
                    context, 
                    Icons.chat_bubble_outline, 
                    appLocalizations.realtime_chat,
                    Colors.orange,
                  ),
                ],
              ),
              SizedBox(height: 30.h),

              // Specialties Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    appLocalizations.main_specialties, 
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text('See All', style: TextStyle(color: AppTheme.primaryBlue)),
                  ),
                ],
              ),
              SizedBox(height: 15.h),
              specialtiesAsyncValue.when(
                data: (specialties) => SizedBox(
                  height: 110.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: specialties.length,
                    itemBuilder: (context, index) {
                      final specialty = specialties[index];
                      return SpecialtyCard(specialty: specialty);
                    },
                  ),
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) => Center(child: Text('Error: $error')),
              ),
              
              SizedBox(height: 30.h),

              // Online Doctors Section
              Text(
                appLocalizations.online_doctors, 
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: 15.h),
              onlineDoctorsAsyncValue.when(
                data: (doctors) => ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: doctors.length,
                  itemBuilder: (context, index) {
                    final doctor = doctors[index];
                    return DoctorCard(doctor: doctor);
                  },
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) => Center(child: Text('Error: $error')),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickAction(BuildContext context, IconData icon, String label, Color color) {
    return Column(
      children: [
        Container(
          width: 60.w,
          height: 60.w,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(icon, color: color, size: 28),
        ),
        SizedBox(height: 8.h),
        SizedBox(
          width: 80.w,
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: AppTheme.textDark,
            ),
          ),
        ),
      ],
    );
  }
}
