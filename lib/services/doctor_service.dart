// Copyright (c) 2026 Karim Asaad Qabil. All rights reserved.
// Licensed under the MIT License.

// Copyright (c) 2026 Karim Asaad Qabil. All rights reserved.
// Licensed under the MIT License.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medical_app/models/doctor.dart';
import 'package:medical_app/models/specialty.dart';

class DoctorService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Specialty>> getSpecialties() {
    return _firestore.collection('specialties').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Specialty.fromFirestore(doc.data(), doc.id)).toList();
    });
  }

  Stream<List<Doctor>> getDoctorsBySpecialty(String specialtyId) {
    return _firestore
        .collection('doctors')
        .where('specialtyId', isEqualTo: specialtyId)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Doctor.fromFirestore(doc.data(), doc.id)).toList();
    });
  }

  Future<void> addDoctor(Doctor doctor) async {
    await _firestore.collection('doctors').add(doctor.toFirestore());
  }

  Future<void> updateDoctorOnlineStatus(String doctorId, bool isOnline) async {
    await _firestore.collection('doctors').doc(doctorId).update({'isOnline': isOnline});
  }

  Stream<List<Doctor>> getOnlineDoctors() {
    return _firestore
        .collection('doctors')
        .where('isOnline', isEqualTo: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Doctor.fromFirestore(doc.data(), doc.id)).toList();
    });
  }

  Future<void> toggleFavorite(String userId, String doctorId) async {
    final docRef = _firestore.collection('favorites').doc('${userId}_$doctorId');
    final doc = await docRef.get();
    if (doc.exists) {
      await docRef.delete();
    } else {
      await docRef.set({
        'userId': userId,
        'doctorId': doctorId,
        'timestamp': FieldValue.serverTimestamp(),
      });
    }
  }

  Stream<bool> isDoctorFavorite(String userId, String doctorId) {
    return _firestore.collection('favorites').doc('${userId}_$doctorId').snapshots().map((snapshot) => snapshot.exists);
  }
}
