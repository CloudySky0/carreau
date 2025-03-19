import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Database.dart';

class UserProvider extends ChangeNotifier {
    Map<String, dynamic>? _userData;

    Map<String, dynamic>? get userData => _userData;

  Future<void> fetchUserData(String userId) async {
    try {
      DocumentSnapshot snapshot =
          await FirebaseFirestore.instance.collection('Users').doc(userId).get();

      if (snapshot.exists) {
        _userData = snapshot.data() as Map<String, dynamic>;
        notifyListeners(); // Notify listeners when data is updated
      }
    } catch (error) {
      print("Error fetching user data: $error");
    }
  }

  void clearUserData() {
    _userData = null;
    notifyListeners();
  }

  // Map<String, dynamic>? _userData;
  List<Product> _wishlist = [];

  // Map<String, dynamic>? get userData => _userData!;
  List<Product> get wishlist => _wishlist;

  Future<void> fetchWishlist() async {
    if (_userData == null) return;
    
    _wishlist = await Product.fetchWishlist(_userData!);
    notifyListeners();  // Notify UI when data updates
  }
}
