// Copyright (c) 2026 Karim Asaad Qabil. All rights reserved.
// Licensed under the MIT License.

// Copyright (c) 2026 Karim Asaad Qabil. All rights reserved.
// Licensed under the MIT License.

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medical_app/services/auth_service.dart';

final authServiceProvider = Provider<AuthService>((ref) => AuthService());

final authStateProvider = StreamProvider<User?>((ref) {
  return ref.read(authServiceProvider).authStateChanges;
});

final authProvider = StateNotifierProvider<AuthNotifier, User?>((ref) {
  return AuthNotifier(ref.read(authServiceProvider));
});

class AuthNotifier extends StateNotifier<User?> {
  final AuthService _authService;

  AuthNotifier(this._authService) : super(null) {
    _authService.authStateChanges.listen((user) => state = user);
  }

  Future<User?> signIn(String email, String password) async {
    return await _authService.signInWithEmailAndPassword(email, password);
  }

  Future<User?> signUp(String email, String password) async {
    return await _authService.registerWithEmailAndPassword(email, password);
  }

  Future<void> signOut() async {
    await _authService.signOut();
  }
}
