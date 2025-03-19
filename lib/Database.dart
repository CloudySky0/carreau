
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'user_service.dart';

class Product {
  final String name;
  final String image;
  final double price;
  final double oldPrice;
  final String discount;
  final String rating;
  final String category;
  final String delivery;

  Product({
    required this.name,
    required this.image,
    required this.price,
    required this.oldPrice,
    required this.discount,
    required this.rating,
    required this.category,
    required this.delivery,
  });

  static Future<List<Product>> fetchProductsFromFirebase() async {
  try {
    
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    QuerySnapshot snapshot = await firestore.collection('products').get();
    
    List<Product> products = snapshot.docs.map((doc) => Product.fromMap(doc.data() as Map<String, dynamic>)).toList();

    return products;
  } catch (error) {
    print("Error fetching products: $error");
    return []; // Return an empty list in case of an error
  }
}


  static Future<List<Product>> fetchWishlist(Map<String, dynamic>? userData) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
   List<Product> wishlist = [];
  // Fetch user document

    // Map<String, dynamic> userData = userSnapshot.data() as Map<String, dynamic>;

   
      // Get stored references
      List<dynamic> wishlistRefs = userData!['wishlist'];

      // Convert them to DocumentReference objects
      for (var ref in wishlistRefs) {
    DocumentSnapshot productSnapshot = await ref.get();
    // print(productSnapshot.data());
  
    if (productSnapshot.exists) {
      wishlist.add(Product.fromMap(productSnapshot.data() as Map<String, dynamic>));
      print(wishlist[0]);
        print("yay");
    }
  }
  return wishlist;
}


  static Future<List<Product>> fetchCart(Map<String, dynamic>? userData) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
   List<Product> Cart = [];
  // Fetch user document

    // Map<String, dynamic> userData = userSnapshot.data() as Map<String, dynamic>;

   
      // Get stored references
      List<dynamic> CartRefs = userData!['cart'];

      // Convert them to DocumentReference objects
      for (var ref in CartRefs) {
    DocumentSnapshot productSnapshot = await ref.get();
    // print(productSnapshot.data());
  
    if (productSnapshot.exists) {
      Cart.add(Product.fromMap(productSnapshot.data() as Map<String, dynamic>));
      print(Cart[0]);
        print("yay");
    }
  }
  return Cart;

}

  static void add_to_cart( String productname)async {
    try{
    FirebaseFirestore firestore = FirebaseFirestore.instance;
      QuerySnapshot query = await FirebaseFirestore.instance
      .collection('products') // Change to your collection name
      .where('name', isEqualTo: productname)
      .limit(1) // To ensure only one result
      .get();

    String? userId = await UserService.getUserId();
    DocumentReference item = query.docs.first.reference;
    await firestore.collection('Users').doc(userId).set({
      'cart': FieldValue.arrayUnion([item])
  }, SetOptions(merge: true));
    }catch (e) {
    print("❌ Error uploading JSON: $e");
  }
  }

  static void add_to_wishlist( String productname)async {
    try{
    FirebaseFirestore firestore = FirebaseFirestore.instance;
      QuerySnapshot query = await FirebaseFirestore.instance
      .collection('products') // Change to your collection name
      .where('name', isEqualTo: productname)
      .limit(1) // To ensure only one result
      .get();

    String? userId = await UserService.getUserId();
    DocumentReference item = query.docs.first.reference;
    await firestore.collection('Users').doc(userId).set({
      'wishlist': FieldValue.arrayUnion([item])
  }, SetOptions(merge: true));
    }catch (e) {
    print("❌ Error uploading JSON: $e");
  }
  }

  static Future<void> removeFromWishlist(String productname) async {
  try {
    String? userId = await UserService.getUserId();
    DocumentReference userDoc = FirebaseFirestore.instance.collection('Users').doc(userId);
    QuerySnapshot query = await FirebaseFirestore.instance
      .collection('products') // Change to your collection name
      .where('name', isEqualTo: productname)
      .limit(1) // To ensure only one result
      .get();
      DocumentReference productRef = query.docs.first.reference;
    await userDoc.update({
      'wishlist': FieldValue.arrayRemove([productRef])
    });

    print("Product removed from wishlist");
  } catch (e) {
    print("Error removing product: $e");
  }
}


  static Future<bool> isProductInWishlist(String productName) async {
  try {
    String? userId = await UserService.getUserId();
    // Fetch user's wishlist (list of references)
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('Users')
        .doc(userId) // Assuming user ID is used as document ID
        .get();

    if (!userDoc.exists) return false;

    List<dynamic> wishlistRefs = userDoc['wishlist']; // Array of references

    for (DocumentReference ref in wishlistRefs) {
      DocumentSnapshot productDoc = await ref.get(); // Fetch product data
      if (productDoc.exists && productDoc['name'] == productName) {
        return true; // Found the product in wishlist
      }
    }
  } catch (e) {
    print("Error checking wishlist: $e");
  }
  return false; // Product not found
}


  factory Product.fromMap(Map<String, dynamic> data) {
    return Product(
      name: data["name"]?.toString() ?? "",
      image: data["imageURL"]?.toString() ?? "",
      price: (data["price"] is num) ? (data["price"] as num).toDouble() : 0.0,
      oldPrice: (data["old_price"] is num) ? (data["old_price"] as num).toDouble() : 0.0,
      discount: data["discount"]?.toString() ?? "",
      rating: data["rating"]?.toString() ?? "",
      category: data["category"]?.toString() ?? "",
      delivery: data["delivery"]?.toString() ?? "",
    );
  }
}
