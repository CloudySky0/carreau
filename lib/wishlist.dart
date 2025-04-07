// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'Database.dart';
// import 'user_provider.dart';

// class Wishlist extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: WishlistScreen(),
//     );
//   }
// }

// class WishlistScreen extends StatelessWidget {
  
//   // = [
//   //   {
//   //     'image': 'assets/images/bracelet.jpg',
//   //     'title': 'Vintage Crystal Diamond Choker',
//   //     'oldPrice': 'Rs 5,999',
//   //     'newPrice': 'Rs 4,499',
//   //     'discount': '25% off',
//   //     'rating': '★★★★☆ (3459)'
//   //   },
//   //   {
//   //     'image': 'assets/images/bracelet.jpg',
//   //     'title': 'Vintage Dior Gold Chain',
//   //     'oldPrice': 'Rs 3,999',
//   //     'newPrice': 'Rs 2,599',
//   //     'discount': '15% off',
//   //     'rating': '★★★★★ (3895)'
//   //   },
//   //   {
//   //     'image': 'assets/images/bracelet.jpg',
//   //     'title': 'Tiffany & Co. Platinum Wedding Diamond Ring',
//   //     'oldPrice': 'Rs 24,999',
//   //     'newPrice': 'Rs 22,999',
//   //     'discount': '10% off',
//   //     'rating': '★★★★☆ (4568)'
//   //   },
//   // ];

//   @override
//   Widget build(BuildContext context) {

 

//     // List<Product> item = await Product.fetchWishlist(userData);
//     return Scaffold(
//       body: Container(
//         color: Colors.black,
//         child:     Padding(
//         padding: const EdgeInsets.all(10.0),
//         child: FutureBuilder<List<Product>>(
//           future:Product.fetchWishlist(userData),
//           builder: (context, snapshot) {
//       if (snapshot.connectionState == ConnectionState.waiting) {
//         return Center(child: CircularProgressIndicator());
//       }
//       if (snapshot.hasError) {
//         return Center(child: Text("Error: ${snapshot.error}"));
//       }
//       if (!snapshot.hasData || snapshot.data!.isEmpty) {
//         return Center(child: Text("No items in wishlist"));
//       }

//       List<Product> wishlist = snapshot.data!;
//       return  ListView(
//           children: wishlist.map((item) => WishlistItem(item)).toList(),
//         );
//           }
//           )
       
//       ),
//     ));
//   }
// }

// class WishlistItem extends StatelessWidget {
//   final Product item;

//   WishlistItem(this.item);

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       color: Colors.grey[900],
//       margin: EdgeInsets.only(bottom: 10),
//       child: Padding(
//         padding: EdgeInsets.all(10),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Image.asset(item.image!, width: 100, height: 100, fit: BoxFit.cover),
//             SizedBox(width: 10),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(item.name!, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
//                   SizedBox(height: 5),
//                   Text.rich(
//   TextSpan(
//     children: [
//       // Strikethrough for old price
//       TextSpan(
//         text: '${item.oldPrice}  ', // Add space for separation
//         style: TextStyle(
//           color: Colors.white, // Faded color for old price
//           decoration: TextDecoration.lineThrough, // Strikethrough effect
//           decorationColor: Colors.red, // Optional: Strikethrough color
//           decorationThickness: 2, // Optional: Line thickness
//         ),
//       ),
//       // New price (bold and red)
//       TextSpan(
//         text: ' ${item.price}  ',
//         style: TextStyle(
//           color: Colors.red,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//       // Discount (if applicable)
//       TextSpan(
//         text: '  ${item.discount}',
//         style: TextStyle(
//           color: Colors.green, // You can change this color
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//     ],
//   ),
// ),

//                   Text(item.rating!, style: TextStyle(color: Colors.white),),
//                   SizedBox(height: 5),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       FavoriteButton(),
//                       ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.white,
//                     foregroundColor: Colors.black,
//                     padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//                   ),
//                   onPressed: () {
//                     print("Added  to cart");
//                   },
//                   child: Text("Add to cart"),
//                 ),
//                     ],
//                   )
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

// class FavoriteButton extends StatefulWidget {
//   @override
//   _FavoriteButtonState createState() => _FavoriteButtonState();
// }

// class _FavoriteButtonState extends State<FavoriteButton> {
//   bool isFavorite = true; // Track selection state

//   @override
//   Widget build(BuildContext context) {
//     return IconButton(
//       icon: Icon(
//         isFavorite ? Icons.favorite : Icons.favorite_border, // Change icon
//         color: isFavorite ? Colors.red : Colors.grey, // Change color
//       ),
//       onPressed: () {
//         setState(() {
//           isFavorite = !isFavorite; // Toggle state
//         });
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Database.dart';
import 'user_provider.dart';
import 'package:intl/intl.dart';

class Wishlist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WishlistScreen(),
    );
  }
}
class WishlistScreen extends StatefulWidget {
  @override
  _WishlistScreenState createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  late Future<List<Product>> wishlistFuture;

  @override
  void initState() {
    super.initState();
    var userData = Provider.of<UserProvider>(context, listen: false).userData;
    wishlistFuture = Product.fetchWishlist(userData); // Call once in initState
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        padding: EdgeInsets.all(10),
        child: FutureBuilder<List<Product>>(
          future: wishlistFuture, // Use the stored future
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}", style: TextStyle(color: Colors.white)));
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text("No items in wishlist", style: TextStyle(color: Colors.white)));
            }

            List<Product> wishlist = snapshot.data!;
            return ListView.builder(
              itemCount: wishlist.length,
              itemBuilder: (context, index) => ProductCard(product: wishlist[index],),
            );
          },
        ),
      ),
    );
  }
}

class WishlistItem extends StatelessWidget {
  final Product item;

  WishlistItem(this.item);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[900],
      margin: EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network("https://cors-anywhere.herokuapp.com/${item.image}" ?? 'assets/images/default.jpg', width: 100, height: 100, fit: BoxFit.cover),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.name ?? "Unknown Product", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                  SizedBox(height: 5),
                  
                  Text(item.rating ?? "No rating", style: TextStyle(color: Colors.white)),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FavoriteButton(productname: item.name,),
                      AddToCartButton(),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;

  ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              "https://cors-anywhere.herokuapp.com/${product.image}",
              width: 100,
              height: 100,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Icon(Icons.broken_image, size: 100, color: Colors.grey);
              },
            ),
          ),
          SizedBox(width: 10),

          // Product Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Text(
                  "⭐ ${product.rating}",
                  style: TextStyle(color: Colors.white54, fontSize: 12),
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Text(
                      NumberFormat.currency(locale: 'en_IN', symbol: 'Rs. ').format(product.price),
                      style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 5),
                    Text(
                      NumberFormat.currency(locale: 'en_IN', symbol: 'Rs. ').format(product.oldPrice),
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: 12,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    SizedBox(width: 5),
                    Text(
                      "${product.discount} OFF",
                      style: TextStyle(color: Colors.green, fontSize: 12),
                    ),
                  ],
                ),
                SizedBox(height: 10),

                // Add to Cart Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                     FavoriteButton(productname: product.name,),
                     SizedBox(width: 50),
                  ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () {
                    print("Added ${product.name} to cart");
                    Product.add_to_cart(product.name, 1);
                  },
                  child: Text("Add to cart"),
                ),
               
                  ]
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}



class FavoriteButton extends StatefulWidget {
  final String productname;
  const FavoriteButton({super.key, required this.productname});

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isFavorite = false; // Default value

  @override
  void initState() {
    super.initState();
    checkFavoriteStatus();
  }

  void checkFavoriteStatus() async {
    bool favoriteStatus = await Product.isProductInWishlist(widget.productname);
    setState(() {
      isFavorite = favoriteStatus; // Update state after async call
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border, // Change icon
        color: isFavorite ? Colors.red : Colors.grey, // Change color
      ),
      onPressed: () {
        if(!isFavorite){
          Product.add_to_wishlist(widget.productname);
        }else{
          Product.removeFromWishlist(widget.productname);
        }
        setState(() {
          isFavorite = !isFavorite; // Toggle state
        });
      },
    );
  }
}

class AddToCartButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      onPressed: () => print("Added to cart"),
      child: Text("Add to cart"),
    );
  }
}
