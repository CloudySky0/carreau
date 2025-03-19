import 'package:diamond_app/wishlist.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home_page.dart';
import 'productPage.dart';
import 'ShoppingCartPage.dart';
import 'ProfileScreen.dart';
import 'user_provider.dart';
// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'KARREAU App',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: KarreauHomePage(),
//     );
//   }
// }


class Template extends StatelessWidget {
  final String? userId;
  Template({super.key, required this.userId});

  final ValueNotifier<int> _currentIndex = ValueNotifier<int>(0);

  final List<Widget> _pages = [
    // ignore: unnecessary_this
    HomePage(),
    Wishlist(),
    ProductPage(),
    ShoppingCartPage(),
    // FavoritesScreen(),
    // ListScreen(),
    // CartScreen(),
    ProfileScreen(),
  ];
 @override
Widget build(BuildContext context) {
  
  Provider.of<UserProvider>(context).fetchUserData(userId!);
  var userProvider = Provider.of<UserProvider>(context);
  var userData = userProvider.userData;

  return Scaffold(
    backgroundColor: Colors.black12,
    appBar: PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: ValueListenableBuilder<int>(
        valueListenable: _currentIndex,
        builder: (context, index, _) {
          return AppBar(
            automaticallyImplyLeading: false, // Removes back arrow
            backgroundColor: Colors.black, 
            title: Text(
              _getAppBarTitle(index),
              style: const TextStyle(
                fontFamily: 'Diamonds', // Custom font
                fontSize: 35,
                color: Colors.white,  // Text color
              ),
            ),
            actions: [], // Removes the search button
          );
        },
      ),
    ),
    body: ValueListenableBuilder<int>(
      valueListenable: _currentIndex,
      builder: (context, index, _) => _pages[index],
    ),
    bottomNavigationBar: ValueListenableBuilder<int>(
      valueListenable: _currentIndex,
      builder: (context, index, _) {
        return BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: const Color.fromARGB(255, 219, 9, 9),
          unselectedItemColor: Colors.black,
          currentIndex: index,
          // ignore: avoid_print
          onTap: (newIndex) {print(userData); _currentIndex.value = newIndex; },
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Wishlist'),
            BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Menu'),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        );
      },
    ),
  );
}

// Function to get the app bar title based on the index
String _getAppBarTitle(int index) {
  switch (index) {
    case 0:
      return 'KARREAU';
    case 1:
      return 'Wishlist';
    case 2:
      return 'Menu';
    case 3:
      return 'Cart';
    case 4:
      return 'Profile';
    default:
      return 'KARREAU';
  }
}

// Function to get app bar background color based on the index
Color _getAppBarColor(int index) {
  switch (index) {
    case 0:
      return Colors.black;
    case 1:
      return Colors.red;
    case 2:
      return Colors.green;
    case 3:
      return Colors.orange;
    case 4:
      return Colors.purple;
    default:
      return Colors.black;
  }
}

}

  Widget _buildBrandCard(String imagePath, String brandName) {
    return Container(
      width: 150,
      margin: EdgeInsets.all(8.0),
      child: Column(
        children: [
          Expanded(
            child: Image.asset(imagePath, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(brandName),
          ),
        ],
      ),
    );
  }



// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'FileExampleScreen.dart';
// import 'flutter_generator.dart';
// import 'changingBackground.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Jewelry Marketplace"),
//         actions: [
//           IconButton(onPressed: () {}, icon: const Icon(Icons.shopping_cart)),
//         ],
//       ),
//       drawer: Drawer(
//         child: Column(
//           children: [
//             const UserAccountsDrawerHeader(
//               accountName: Text("User Name"),
//               accountEmail: Text("user@example.com"),
//             ),
//             ListTile(
//               leading: const Icon(Icons.home),
//               title: const Text("Home"),
//               onTap: () {
//                 Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()),);
//               },
//             ),
//             const ListTile(
//               leading: Icon(Icons.category),
//               title: Text("Categories"),
//             ),
//             const ListTile(
//               leading: Icon(Icons.account_circle),
//               title: Text("Profile"),
//             ),
//             ListTile(
//               leading: const Icon(Icons.account_balance_wallet),
//               title: const Text("Examples for file"),
//               onTap: () {
//                 Navigator.push(context, MaterialPageRoute(builder: (context) => FileExamplesScreen()),);
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.account_balance_wallet),
//               title: const Text("Example od Splash"),
//               onTap: () {
//                 Navigator.push(context, MaterialPageRoute(builder: (context) => ChangingBackgroundScreen()),);
//               },
//             )
//           ],
//         ),
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//   stream: FirebaseFirestore.instance.collection("products").snapshots(),
//   builder: (context, snapshot) {
//     if (snapshot.connectionState == ConnectionState.waiting) {
//       return const Center(child: CircularProgressIndicator());
//     }
//     if (snapshot.hasError) {
//       return Center(child: Text("Error: ${snapshot.error}"));
//     }
//     if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//       return const Center(child: Text("No products available"));
//     }

//     final products = snapshot.data!.docs;
//     return GridView.builder(
//       padding: const EdgeInsets.all(10),
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//         crossAxisSpacing: 10,
//         mainAxisSpacing: 10,
//         childAspectRatio: 0.75,
//       ),
//       itemCount: products.length,
//       itemBuilder: (context, index) {
//         final product = products[index].data() as Map<String, dynamic>;
//         return Card(
//           elevation: 3,
//           child: Column(
//             children: [
//               Expanded(
//                 child: Image.network(
//                   product['imageUrl'] ?? "https://media.istockphoto.com/id/1399508588/vector/blue-diamonds-icon-isolate-on-white-background.webp?s=2048x2048&w=is&k=20&c=C4PR3YeFKqfdokiyc1gWW5RbZApUIuRlKpNEx2tcaGQ=",
//                   fit: BoxFit.cover,
//                 ),
//               ),
//                Padding(
//                 padding: EdgeInsets.all(8.0),
//                 child: Text("${product['name']}", style: TextStyle(fontSize: 16)),
//               ),
//               Text("\$${product['price'] ?? '0.00'}", style: const TextStyle(fontWeight: FontWeight.bold)),
//             ],
//           ),
//         );
//       },
//     );
//   },
// )

//     );
//   }
// }
