import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'ProductListScreen.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
                        child: Text('Hello, Name\n Discover Hot Topics',
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
                    height: 210,
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('products')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text("Error: ${snapshot.error}");
                        }
                        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                          return Text("No products found");
                        }

                        var products = snapshot.data!.docs;

                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: products.length,
                          itemBuilder: (context, index) {
                            var product =
                                products[index].data() as Map<String, dynamic>?;

                            // Handle null values safely
                            String imageURL = product?['imageURL'] ??
                                'https://i.pinimg.com/736x/35/93/d6/3593d6b438457ec0e895b790e0879dc7.jpg';
                            String productName =
                                product?['name'] ?? 'Unnamed Product';
                            double price =
                                (product?['price'] as num?)?.toDouble() ?? 0.0;

                            return _buildBrandCard(imageURL, productName);
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
                    height: 210,
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('products')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text("Error: ${snapshot.error}");
                        }
                        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                          return Text("No products found");
                        }

                        var products = snapshot.data!.docs;

                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: products.length,
                          itemBuilder: (context, index) {
                            var product =
                                products[index].data() as Map<String, dynamic>?;

                            // Handle null values safely
                            String imageURL = product?['imageURL'] ??
                                'https://i.pinimg.com/736x/35/93/d6/3593d6b438457ec0e895b790e0879dc7.jpg';
                            String productName =
                                product?['name'] ?? 'Unnamed Product';
                            double price =
                                (product?['price'] as num?)?.toDouble() ?? 0.0;

                            return _buildBrandCard(imageURL, productName);
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
                      stream: FirebaseFirestore.instance
                          .collection('featured')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text("Error: ${snapshot.error}");
                        }
                        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                          return Text("No products found");
                        }

                        var products = snapshot.data!.docs;

                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: products.length,
                          itemBuilder: (context, index) {
                            var product =
                                products[index].data() as Map<String, dynamic>?;

                            // Handle null values safely
                            String imageURL = product?['imageURL'] ??
                                'https://i.pinimg.com/736x/35/93/d6/3593d6b438457ec0e895b790e0879dc7.jpg';
                            String productName =
                                product?['name'] ?? 'Unnamed Product';
                            double price =
                                (product?['price'] as num?)?.toDouble() ?? 0.0;

                            return _buildFeatureCard(imageURL, productName);
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

Widget _buildBrandCard(String imageUrl, String brandName) {
  return Container(
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
              imageUrl,
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
              imageUrl,
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
