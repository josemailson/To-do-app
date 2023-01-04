import 'package:firebase_auth/firebase_auth.dart';

import '../model/user_model.dart';

abstract class AuthRepository {
  Future<UserModel> login(String email, String password);
  Future<UserModel> register(String email, String password);
  Future<void> signOut();
  bool get isLogged;
  User? get currentUser;
}

class FirebaseRepository implements AuthRepository {
  FirebaseAuth get _firebase => FirebaseAuth.instance;

  @override
  bool get isLogged => _firebase.currentUser != null;

  @override
  User? get currentUser => _firebase.currentUser;

  @override
  Future<void> signOut() async {
    await _firebase.signOut();
  }

  @override
  Future<UserModel> login(String email, String password) async {
    try {
      final result = await _firebase.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (result.user != null) {
        return UserModel(name: '', email: email);
      }
      throw Exception();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserModel> register(String email, String password) async {
    try {
      final result = await _firebase.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      //Para mandar o name, use o updateDisplayName
      //_firebase.currentUser.updateDisplayName(displayName)
      if (result.user != null) {
        return UserModel(name: '', email: email);
      }
      throw Exception();
    } catch (e) {
      rethrow;
    }
  }
}
