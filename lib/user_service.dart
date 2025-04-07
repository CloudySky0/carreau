import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  static const String _userIdKey = "user_id";
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Save user ID to SharedPreferences (after successful login)
  static Future<void> saveUserId(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userIdKey, userId);
  }

  // Get user ID from SharedPreferences (to check login status)
  static Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userIdKey);
  }

  // Logout and clear user ID from SharedPreferences
  static Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userIdKey);
  }

  // Authenticate user using Firestore
  static Future<String?> loginUser(String email, String password) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('Users')
          .where('profile.email', isEqualTo: email)
          .where('profile.password', isEqualTo: password) // Store hashed passwords in a real app
          .get();

      if (snapshot.docs.isNotEmpty) {
        String userId = snapshot.docs.first.id;
        await saveUserId(userId);
        return userId;
      } else {
        return null; // Invalid credentials
      }
    } catch (e) {
      print("Error logging in: $e");
      return null;
    }
  }
}
