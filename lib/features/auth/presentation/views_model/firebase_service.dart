import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dounts_store/features/auth/presentation/views_model/uesr_model.dart';

class FirebaseAuthService {

  static Future<UserModel> login({required String email, required String password}) async {
    try {
      final credentials = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final userCollection = FirebaseFirestore.instance.collection('users');
      final docSnapshot = await userCollection.doc(credentials.user!.uid).get();

      if (!docSnapshot.exists) {
        throw Exception('User not found');
      }

      return UserModel.fromMap(docSnapshot.data()!);
    } catch (e) {
      rethrow;
    }
  }

  static Future<UserModel> register({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final credentials = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final userCollection = FirebaseFirestore.instance.collection('users');
      final user = UserModel(
        name: name,
        email: email,
        password: password,
        userId: credentials.user!.uid,
      );

      await userCollection.doc(credentials.user!.uid).set(user.toMap());

      return user;
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }

  static Future<UserModel> getUserById(String userId) async {
    try {
      final userCollection = FirebaseFirestore.instance.collection('users');
      final docSnapshot = await userCollection.doc(userId).get();

      if (!docSnapshot.exists) {
        throw Exception('User not found');
      }

      return UserModel.fromMap(docSnapshot.data()!);
    } catch (e) {
      rethrow;
    }
  }
}
