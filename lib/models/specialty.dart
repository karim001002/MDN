// Copyright (c) 2026 Karim Asaad Qabil. All rights reserved.
// Licensed under the MIT License.

// Copyright (c) 2026 Karim Asaad Qabil. All rights reserved.
// Licensed under the MIT License.

import 'package:flutter/foundation.dart';

@immutable
class Specialty {
  final String id;
  final Map<String, String> names;
  final List<SubSpecialty> subSpecialties;

  const Specialty({
    required this.id,
    required this.names,
    required this.subSpecialties,
  });

  String getName(String languageCode) {
    return names[languageCode] ?? names['en'] ?? '';
  }

  factory Specialty.fromFirestore(Map<String, dynamic> data, String id) {
    return Specialty(
      id: id,
      names: Map<String, String>.from(data['names'] ?? {}),
      subSpecialties: (data['sub_specialties'] as List<dynamic>?)
              ?.map((b) => SubSpecialty.fromMap(b))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'names': names,
      'sub_specialties': subSpecialties.map((b) => b.toMap()).toList(),
    };
  }
}

@immutable
class SubSpecialty {
  final Map<String, String> names;

  const SubSpecialty({
    required this.names,
  });

  String getName(String languageCode) {
    return names[languageCode] ?? names['en'] ?? '';
  }

  factory SubSpecialty.fromMap(Map<String, dynamic> data) {
    return SubSpecialty(
      names: Map<String, String>.from(data['names'] ?? {}),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'names': names,
    };
  }
}
