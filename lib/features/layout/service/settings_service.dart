import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../core/config.dart';

class SettingsService {
  final FirebaseFirestore _firestore;

  SettingsService({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<String> getUserName(User user) async {
    try {
      final doc = await _firestore
          .collection(Config.userCollection)
          .doc(user.uid)
          .get();
      final data = doc.data();
      final fullName = (data?['fullName'] ?? '') as String;
      if (fullName.trim().isNotEmpty) {
        return fullName.trim();
      }
    } catch (_) {}

    final displayName = user.displayName?.trim() ?? '';
    if (displayName.isNotEmpty) {
      return displayName;
    }

    final email = user.email?.trim() ?? '';
    if (email.isNotEmpty && email.contains('@')) {
      return email.split('@').first;
    }

    return 'User';
  }
}
