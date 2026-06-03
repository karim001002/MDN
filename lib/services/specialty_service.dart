// Copyright (c) 2026 Karim Asaad Qabil. All rights reserved.
// Licensed under the MIT License.

// Copyright (c) 2026 Karim Asaad Qabil. All rights reserved.
// Licensed under the MIT License.

import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/specialty.dart';
import '../core/constants/medical_specialties.dart';

class SpecialtyService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collection = 'specialties';

  Future<List<Specialty>> getSpecialties() async {
    final snapshot = await _firestore.collection(_collection).get();
    return snapshot.docs
        .map((doc) => Specialty.fromFirestore(doc.data(), doc.id))
        .toList();
  }

  Future<void> seedSpecialties() async {
    final batch = _firestore.batch();
    
    for (var item in MedicalSpecialties.data) {
      final docRef = _firestore.collection(_collection).doc(item['id']);
      
      // Transform sub_specialties format to match model
      final List<Map<String, dynamic>> subSpecialties = (item['sub_specialties'] as List).map((sub) {
        return {
          'names': {
            'en': sub['en'],
            'ar': sub['ar'],
          }
        };
      }).toList();

      batch.set(docRef, {
        'names': item['names'],
        'sub_specialties': subSpecialties,
      });
    }
    
    await batch.commit();
  }
}
