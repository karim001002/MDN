// Copyright (c) 2026 Karim Asaad Qabil. All rights reserved.
// Licensed under the MIT License.

// Copyright (c) 2026 Karim Asaad Qabil. All rights reserved.
// Licensed under the MIT License.

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medical_app/models/doctor.dart';
import 'package:medical_app/models/specialty.dart';
import 'package:medical_app/services/doctor_service.dart';

final doctorServiceProvider = Provider<DoctorService>((ref) => DoctorService());

final specialtiesProvider = StreamProvider<List<Specialty>>((ref) {
  return ref.read(doctorServiceProvider).getSpecialties();
});

final doctorsBySpecialtyProvider = StreamProvider.family<List<Doctor>, String>((ref, specialtyId) {
  return ref.read(doctorServiceProvider).getDoctorsBySpecialty(specialtyId);
});

final onlineDoctorsProvider = StreamProvider<List<Doctor>>((ref) {
  return ref.read(doctorServiceProvider).getOnlineDoctors();
});

final favoriteDoctorProvider = StreamProvider.family<bool, ({String userId, String doctorId})>((ref, args) {
  return ref.read(doctorServiceProvider).isDoctorFavorite(args.userId, args.doctorId);
});

final doctorListProvider = StateNotifierProvider<DoctorListNotifier, List<Doctor>>((ref) {
  return DoctorListNotifier(ref.read(doctorServiceProvider));
});

class DoctorListNotifier extends StateNotifier<List<Doctor>> {
  final DoctorService _doctorService;

  DoctorListNotifier(this._doctorService) : super([]);

  Future<void> toggleFavorite(String userId, String doctorId) async {
    await _doctorService.toggleFavorite(userId, doctorId);
  }

  Future<void> updateDoctorOnlineStatus(String doctorId, bool isOnline) async {
    await _doctorService.updateDoctorOnlineStatus(doctorId, isOnline);
  }
}
