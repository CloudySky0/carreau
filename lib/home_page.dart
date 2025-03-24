import 'dart:io';
import 'package:provider/provider.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'user_provider.dart';
import 'ProductListScreen.dart';
import 'productDetailPage.dart';
import 'Database.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  TextEditingController searchController = TextEditingController();


Future<List<Product>> fetchProducts() async {
  
  List<Product> products;
  products = await Product.fetchProductsFromFirebase();
  print("products:");
  print(products);
  return products;
}
 
  @override
  Widget build(BuildContext context) {
    var userData = Provider.of<UserProvider>(context).userData;
    
    return Scaffold(
        body: Container(
            color: Colors.black,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(children: [

SizedBox(
  width: 400, // Set width
  height: 50, // Set height
  child: TextField(
    controller: searchController,
    style: TextStyle(color: Colors.black),
    decoration: InputDecoration(
      hintText: 'Search...',
      hintStyle: TextStyle(color: Colors.black),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide.none,
      ),
      prefixIcon: Icon(Icons.search, color: Colors.black),
    ),
    onSubmitted: (query) {
      if (query.isNotEmpty) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductListScreen(searchQuery: query, selectedCategory: ["Necklace"],),
            // builder: (context) => ProductListScreen(),
          ),
        );
      }
    },
  ),
),

                      Padding(
                        padding: EdgeInsets.all(5.0),
                      ),
                      Center(
                        child: Text('Hello, ${userData?['profile']['name']}\n Discover Hot Topics',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                            textAlign: TextAlign.center),
                        // Text('',
                        //     style:
                        //         TextStyle(fontSize: 16, color: Colors.white),
                        //           textAlign: TextAlign.center
                        //         ),
                      )
                    ]),
                  ),
                  SizedBox(
                    height: 270,
                    child: Stack(
                      children: [
                        PageView(
                          children: [
                            // Replace with actual image
                            Image.asset('assets/images/PageView1.jpg',
                                fit: BoxFit.cover),
                            Image.asset('assets/images/PageView2.jpg',
                                fit: BoxFit.cover),
                            Image.asset('assets/images/PageView3.jpg',
                                fit: BoxFit.cover),
                            Image.asset('assets/images/PageView4.jpg',
                                fit: BoxFit.cover),
                            Image.asset('assets/images/PageView5.jpg',
                                fit: BoxFit.cover),
                            // Add more images as needed
                          ],
                        ),
                        // Positioned(
                        //   left: 16,
                        //   bottom: 16,
                        //   child: Column(
                        //     crossAxisAlignment: CrossAxisAlignment.start,
                        //     children: [
                        //       Text('Big Savings on Little Luxuries',
                        //           style: TextStyle(
                        //               fontSize: 24,
                        //               color: Colors.white,
                        //               fontWeight: FontWeight.bold)),
                        //       ElevatedButton(
                        //         onPressed: () {
                        //           // Handle shop now action
                        //         },
                        //         child: Text('Shop now', style: TextStyle(color: Colors.white)),
                        //         style: ElevatedButton.styleFrom(
                        //           backgroundColor: Colors.blue, // Change button color
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Our Top Brands',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        ]),
                  ),
                  SizedBox(
                    height: 225,
                    child: StreamBuilder<QuerySnapshot>(
  stream: FirebaseFirestore.instance.collection('products').snapshots(),
  builder: (context, snapshot) {
    if (snapshot.hasError) {
      return Text("Error: ${snapshot.error}");
    }
    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
      return Text("No products found");
    }

    // ✅ Convert snapshot data to Product list using fetchProductsFromFirebase
    List<Product> products = snapshot.data!.docs.map(
      (doc) => Product.fromMap(doc.data() as Map<String, dynamic>),
    ).toList();

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: products.length,
      itemBuilder: (context, index) {
        Product product = products[index];

        // ✅ No need to check null values, handled in fromMap()
        return _buildBrandCard(context, product);
      },
    );
  },
),

                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text('History',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  ),
                  SizedBox(
                    height: 225,
                    child: StreamBuilder<QuerySnapshot>(
  stream: FirebaseFirestore.instance.collection('products').snapshots(),
  builder: (context, snapshot) {
    if (snapshot.hasError) {
      return Text("Error: ${snapshot.error}");
    }
    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
      return Text("No products found");
    }

    // ✅ Convert snapshot data to Product list using fetchProductsFromFirebase
    List<Product> products = snapshot.data!.docs.map(
      (doc) => Product.fromMap(doc.data() as Map<String, dynamic>),
    ).toList();

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: products.length,
      itemBuilder: (context, index) {
        Product product = products[index];

        // ✅ No need to check null values, handled in fromMap()
        return _buildBrandCard(context, product);
      },
    );
  },
),

                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text('Featured Categories',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  ),
                  SizedBox(
                    height: 260,
                    child: StreamBuilder<QuerySnapshot>(
  stream: FirebaseFirestore.instance.collection('products').snapshots(),
  builder: (context, snapshot) {
    if (snapshot.hasError) {
      return Text("Error: ${snapshot.error}");
    }
    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
      return Text("No products found");
    }

    // ✅ Convert snapshot data to Product list using fetchProductsFromFirebase
    List<Product> products = snapshot.data!.docs.map(
      (doc) => Product.fromMap(doc.data() as Map<String, dynamic>),
    ).toList();

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: products.length,
      itemBuilder: (context, index) {
        Product product = products[index];

        // ✅ No need to check null values, handled in fromMap()
        return _buildBrandCard(context, product);
      },
    );
  },
),

                  ),
                ],
              ),
            )));
  }
}

Widget _buildBrandCard(BuildContext context,Product product) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProductDetailPage(product: product,)),
      );
    },
    child :Container(
    width: 150,
    margin: EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: Colors.black,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      mainAxisSize:
          MainAxisSize.min, // Ensures the column takes only required space
      children: [
        SizedBox(
          height: 150, // Set a fixed height for images
          child: ClipRRect(
            borderRadius: BorderRadius.vertical(
                top: Radius.circular(10), bottom: Radius.circular(10)),
            child: Image.network(
              product.image,
              fit: BoxFit.cover,
              width: double.infinity,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(child: CircularProgressIndicator());
              },
              errorBuilder: (context, error, stackTrace) {
                return Icon(Icons.broken_image, color: Colors.white, size: 120);
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: AutoSizeText(
            product.name,
            style: TextStyle(color: Colors.white),
            maxLines: 2, 
            minFontSize: 12, 
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    ),
  ),);
}

Widget _buildFeatureCard(String imageUrl, String brandName) {
  return Container(
    width: 70,
    margin: EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: Colors.black,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      mainAxisSize:
          MainAxisSize.min, // Ensures the column takes only required space
      children: [
        SizedBox(
          height: 200, // Set a fixed height for images
          child: ClipRRect(
            borderRadius: BorderRadius.vertical(
                top: Radius.circular(10), bottom: Radius.circular(10)),
            child: Image.network(
              'https://cors-anywhere.herokuapp.com/${imageUrl}',
              fit: BoxFit.cover,
              width: double.infinity,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(child: CircularProgressIndicator());
              },
              errorBuilder: (context, error, stackTrace) {
                return Icon(Icons.broken_image, color: Colors.white, size: 120);
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            brandName,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    ),
  );
}
