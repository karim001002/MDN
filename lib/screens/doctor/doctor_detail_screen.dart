// Copyright (c) 2026 Karim Asaad Qabil. All rights reserved.
// Licensed under the MIT License.

// Copyright (c) 2026 Karim Asaad Qabil. All rights reserved.
// Licensed under the MIT License.

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medical_app/core/localization/app_localizations.dart';
import 'package:medical_app/models/doctor.dart';
import 'package:medical_app/providers/doctor_provider.dart';

class DoctorDetailScreen extends ConsumerWidget {
  final Doctor doctor;
  const DoctorDetailScreen({super.key, required this.doctor});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appLocalizations = AppLocalizations.of(context);
    final userId = 'test_user_id'; // TODO: Replace with actual user ID from AuthProvider
    final isFavoriteAsyncValue = ref.watch(favoriteDoctorProvider((userId: userId, doctorId: doctor.id)));

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            actions: [
              isFavoriteAsyncValue.when(
                data: (isFavorite) => IconButton(
                  icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border, color: Colors.red, size: 30),
                  onPressed: () {
                    ref.read(doctorListProvider.notifier).toggleFavorite(userId, doctor.id);
                  },
                ),
                loading: () => const SizedBox.shrink(),
                error: (error, stack) => const SizedBox.shrink(),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0xFF0D47A1), Color(0xFF1976D2)])),
                child: Center(
                  child: CircleAvatar(
                    radius: 70,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 66,
                      backgroundImage: CachedNetworkImageProvider(doctor.image),
                    ),
                  ),
                ),
              ),
              title: Text(doctor.name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _sectionTitle(appLocalizations.clinical_impact, context),
                  _impactCard(doctor, appLocalizations),
                  const SizedBox(height: 30),
                  _sectionTitle(appLocalizations.experience, context),
                  Text('${doctor.experience} ${appLocalizations.experience}', style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // TODO: Navigate to chat screen
        },
        label: Text(appLocalizations.chat),
        icon: const Icon(Icons.chat),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _sectionTitle(String t, BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: Text(t, style: Theme.of(context).textTheme.titleLarge?.copyWith(color: const Color(0xFF0D47A1))),
      );

  Widget _impactCard(Doctor doctor, AppLocalizations appLocalizations) => Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _stat(doctor.cis.toString(), 'CIS'),
              _stat(doctor.cases.toString(), appLocalizations.cases),
              _stat('${doctor.successRate}%', appLocalizations.success),
            ],
          ),
        ),
      );

  Widget _stat(String v, String l) => Column(
        children: [
          Text(v, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blue)),
          Text(l, style: const TextStyle(color: Colors.grey)),
        ],
      );
}
