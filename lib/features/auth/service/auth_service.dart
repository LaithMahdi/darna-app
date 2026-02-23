import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../core/config.dart';
import '../../../core/config/env.dart';
import '../models/user_model.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  AuthService({FirebaseAuth? firebaseAuth, FirebaseFirestore? firestore})
    : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
      _firestore = firestore ?? FirebaseFirestore.instance;

  // Get the current user
  User? get currentUser => _firebaseAuth.currentUser;

  // Get User stream
  Stream<User?> get userChanges => _firebaseAuth.userChanges();

  // Sign in with email and password
  Future<Either<String, User?>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Right(userCredential.user);
    } on FirebaseAuthException catch (e) {
      return Left(_handleAuthException(e));
    } catch (e) {
      return Left('An unknown error occurred');
    }
  }

  // Register with email and password
  Future<Either<String, UserModel>> registerWithEmailAndPassword(
    UserModel user,
    String password,
  ) async {
    try {
      final UserCredential credential = await _firebaseAuth
          .createUserWithEmailAndPassword(
            email: user.email.trim(),
            password: password,
          );

      if (credential.user == null) {
        throw Exception('Failed to create user');
      }
      if (user.fullName != null) {
        await credential.user!.updateDisplayName(user.fullName!);
      }
      final newUser = UserModel(
        uid: credential.user!.uid,
        email: user.email,
        fullName: user.fullName,
        phoneNumber: user.phoneNumber,
        gender: user.gender,
        role: user.role,
        createdAt: DateTime.now(),
      );

      debugPrint('Saving user to Firestore: ${newUser.uid}');
      await _firestore
          .collection(Config.userCollection)
          .doc(newUser.uid)
          .set(newUser.toJson());
      debugPrint('User saved successfully to Firestore');
      return Right(newUser);
    } on FirebaseAuthException catch (e) {
      return Left(_handleAuthException(e));
    } on FirebaseException catch (e) {
      return Left('Database error: ${e.message}');
    } catch (e) {
      return Left('An unknown error occurred during registration');
    }
  }

  // Sign in with Google
  Future<Either<String, User?>> signInWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn.instance;
      await googleSignIn.initialize(serverClientId: Env.firebaseWebClientId);
      final GoogleSignInAccount googleUser = await googleSignIn.authenticate();
      final GoogleSignInAuthentication googleAuth = googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );
      final userCredential = await _firebaseAuth.signInWithCredential(
        credential,
      );
      return Right(userCredential.user);
    } on FirebaseAuthException catch (e) {
      return Left(_handleAuthException(e));
    } catch (e) {
      return Left('Google sign-in failed: ${e.toString()}');
    }
  }

  String _handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'No user found with this email address';
      case 'wrong-password':
        return 'Incorrect password';
      case 'email-already-in-use':
        return 'An account already exists with this email';
      case 'weak-password':
        return 'Password is too weak';
      case 'invalid-email':
        return 'Invalid email address';
      case 'user-disabled':
        return 'This account has been disabled';
      case 'too-many-requests':
        return 'Too many attempts. Please try again later';
      case 'operation-not-allowed':
        return 'Operation not allowed';
      case 'invalid-credential':
        return 'Invalid credentials';
      default:
        return e.message ?? 'An authentication error occurred';
    }
  }
}
