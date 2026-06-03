// Copyright (c) 2026 Karim Asaad Qabil. All rights reserved.
// Licensed under the MIT License.

// Copyright (c) 2026 Karim Asaad Qabil. All rights reserved.
// Licensed under the MIT License.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medical_app/core/localization/app_localizations.dart';
import 'package:medical_app/models/specialty.dart';
import 'package:medical_app/providers/doctor_provider.dart';
import 'package:medical_app/widgets/doctor_card.dart';

class DoctorListScreen extends ConsumerWidget {
  final Specialty specialty;
  const DoctorListScreen({super.key, required this.specialty});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appLocalizations = AppLocalizations.of(context);
    final doctorsAsyncValue = ref.watch(doctorsBySpecialtyProvider(specialty.id));

    return Scaffold(
      appBar: AppBar(title: Text(specialty.names[appLocalizations.localeName] ?? specialty.names['en']!)),
      body: doctorsAsyncValue.when(
        data: (doctors) => ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: doctors.length,
          itemBuilder: (context, i) {
            final doctor = doctors[i];
            return DoctorCard(doctor: doctor);
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
