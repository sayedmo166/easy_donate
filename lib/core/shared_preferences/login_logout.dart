import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> signInUser(String email, String password) async {
  try {

    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);


    String userId = userCredential.user!.uid;


    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isSaved = await prefs.setString('userId', userId);

    if (isSaved) {
      print('Login successful and userId saved: $userId');
    } else {
      print('Failed to save userId');
    }
  } catch (e) {
    print('Error during login: $e');
  }
}
