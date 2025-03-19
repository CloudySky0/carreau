import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart'; 

Future<void> uploadJsonToFirestore() async {
  try {
    // Initialize Firebase
    await Firebase.initializeApp();

    // JSON data stored in a local variable
    Map<String, dynamic> jsonData = {
       "profile": {
      "name": "Megh",
      "email": "johndoe@example.com",
      "role": "customer",
        "phone": "+1234567890",
        "address": "123 Street, City, Country",
        "profileImage": "https://example.com/profile.jpg",
      },
       "cart": {},
       
       "orders": {
        "orderId1": {
          "status": "delivered",
          "total_price": 75.97,
          "ordered_at": "2025-03-18T12:30:00Z",
          "items": {
            "productId1": {
              "name": "Product 1",
              "price": 29.99,
              "quantity": 2
            },
            "productId2": {
              "name": "Product 2",
              "price": 15.99,
              "quantity": 1
            }
          }
        }
      }
    };


    // Firestore reference
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    
    // Upload JSON as a document
    await firestore.collection("Users").doc().set(jsonData);

    print("✅ JSON uploaded successfully!");
  } catch (e) {
    print("❌ Error uploading JSON: $e");
  }
}

Future<void> setUserProfileReference() async {
  try{
    
    await Firebase.initializeApp();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Reference to the profile document
  DocumentReference wishlist = firestore.collection('products').doc('chaumet_platinum_ring');

  // Store the reference inside the user document
  var user = await firestore.collection('Users').doc('5510lA9P8NHK2Rc31mJX').set({
      'wishlist': FieldValue.arrayUnion([wishlist])
  }, SetOptions(merge: true));
  print(wishlist);
  print("yay");
  }catch (e) {
    print("❌ Error uploading JSON: $e");
  }
}


void main() async {
  
  WidgetsFlutterBinding.ensureInitialized(); 
  // await uploadJsonToFirestore();
  await setUserProfileReference();
}



// {
//   "users": {
//     "userId1": {
//       "name": "John Doe",
//       "email": "johndoe@example.com",
//       "role": "customer",
//       "profile": {
//         "phone": "+1234567890",
//         "address": "123 Street, City, Country",
//         "profileImage": "https://example.com/profile.jpg",
//         "preferences": {
//           "app_theme": "dark",
//           "notifications": true
//         }
//       },
//       "cart": {
//         "productId1": {
//           "name": "Product 1",
//           "price": 29.99,
//           "quantity": 2,
//           "imageUrl": "https://example.com/product1.jpg"
//         },
//         "productId2": {
//           "name": "Product 2",
//           "price": 15.99,
//           "quantity": 1,
//           "imageUrl": "https://example.com/product2.jpg"
//         }
//       },
//       "wishlist": {
//         "productId3": {
//           "name": "Product 3",
//           "price": 49.99,
//           "imageUrl": "https://example.com/product3.jpg"
//         },
//         "productId4": {
//           "name": "Product 4",
//           "price": 99.99,
//           "imageUrl": "https://example.com/product4.jpg"
//         }
//       },
//       "orders": {
//         "orderId1": {
//           "status": "delivered",
//           "total_price": 75.97,
//           "ordered_at": "2025-03-18T12:30:00Z",
//           "items": {
//             "productId1": {
//               "name": "Product 1",
//               "price": 29.99,
//               "quantity": 2
//             },
//             "productId2": {
//               "name": "Product 2",
//               "price": 15.99,
//               "quantity": 1
//             }
//           }
//         }
//       }
//     }
//   },
//   "products": {
//     "productId1": {
//       "name": "Product 1",
//       "description": "High-quality item",
//       "price": 29.99,
//       "stock": 50,
//       "category": "Electronics",
//       "imageUrl": "https://example.com/product1.jpg"
//     },
//     "productId2": {
//       "name": "Product 2",
//       "description": "Durable and reliable",
//       "price": 15.99,
//       "stock": 30,
//       "category": "Accessories",
//       "imageUrl": "https://example.com/product2.jpg"
//     }
//   },
//   "menu": {
//     "categories": {
//       "electronics": {
//         "name": "Electronics",
//         "iconUrl": "https://example.com/electronics-icon.png"
//       },
//       "accessories": {
//         "name": "Accessories",
//         "iconUrl": "https://example.com/accessories-icon.png"
//       }
//     }
//   },
//   "settings": {
//     "app_theme": "dark",
//     "currency": "Indian",
//     "support_email": "support@example.com"
//   }
// }