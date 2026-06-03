// Copyright (c) 2026 Karim Asaad Qabil. All rights reserved.
// Licensed under the MIT License.

// Copyright (c) 2026 Karim Asaad Qabil. All rights reserved.
// Licensed under the MIT License.

import 'package:flutter/material.dart';

@immutable
class Doctor {
  final String id;
  final String name;
  final String branch;
  final String specialtyId;
  final int experience;
  final double rating;
  final double cis;
  final int cases;
  final int successRate;
  final double peerRating;
  final List<String> tags;
  final String image;
  final bool isOnline;
  final bool isPreferred;

  const Doctor({
    required this.id,
    required this.name,
    required this.branch,
    required this.specialtyId,
    required this.experience,
    required this.rating,
    required this.cis,
    required this.cases,
    required this.successRate,
    required this.peerRating,
    required this.tags,
    required this.image,
    this.isOnline = false,
    this.isPreferred = false,
  });

  Doctor copyWith({bool? isPreferred, bool? isOnline}) {
    return Doctor(
      id: id,
      name: name,
      branch: branch,
      specialtyId: specialtyId,
      experience: experience,
      rating: rating,
      cis: cis,
      cases: cases,
      successRate: successRate,
      peerRating: peerRating,
      tags: tags,
      image: image,
      isOnline: isOnline ?? this.isOnline,
      isPreferred: isPreferred ?? this.isPreferred,
    );
  }

  factory Doctor.fromFirestore(Map<String, dynamic> data, String id) {
    return Doctor(
      id: id,
      name: data['name'] ?? '',
      branch: data['branch'] ?? '',
      specialtyId: data['specialtyId'] ?? '',
      experience: data['experience'] ?? 0,
      rating: (data['rating'] as num?)?.toDouble() ?? 0.0,
      cis: (data['cis'] as num?)?.toDouble() ?? 0.0,
      cases: data['cases'] ?? 0,
      successRate: data['successRate'] ?? 0,
      peerRating: (data['peerRating'] as num?)?.toDouble() ?? 0.0,
      tags: List<String>.from(data['tags'] ?? []),
      image: data['image'] ?? '',
      isOnline: data['isOnline'] ?? false,
      isPreferred: data['isPreferred'] ?? false,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'branch': branch,
      'specialtyId': specialtyId,
      'experience': experience,
      'rating': rating,
      'cis': cis,
      'cases': cases,
      'successRate': successRate,
      'peerRating': peerRating,
      'tags': tags,
      'image': image,
      'isOnline': isOnline,
      'isPreferred': isPreferred,
    };
  }
}
