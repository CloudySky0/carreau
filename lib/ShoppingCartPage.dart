import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Database.dart';
import 'user_provider.dart';
import 'package:intl/intl.dart';

class ShoppingCartPage extends StatefulWidget {
  @override
  _ShoppingCartPageState createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  late Future<List<Product>> cartFuture;

  @override
  void initState() {
    super.initState();
    var userData = Provider.of<UserProvider>(context, listen: false).userData;
    cartFuture = Product.fetchCart(userData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        title: TextField(
          decoration: InputDecoration(
            hintText: "Search or ask a question",
            hintStyle: TextStyle(color: Colors.white54),
            border: InputBorder.none,
            prefixIcon: Icon(Icons.search, color: Colors.white),
          ),
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: FutureBuilder<List<Product>>(
        future: cartFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
                child: Text("Error: ${snapshot.error}",
                    style: TextStyle(color: Colors.white)));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
                child: Text("No items in cart",
                    style: TextStyle(color: Colors.white)));
          }

          List<Product> cartItems = snapshot.data!;
          int productQuantities = cartItems.length;

          return Column(
            children: [
              Container(
                padding: EdgeInsets.all(12),
                color: Colors.grey[800],
                child: Row(
                  children: [
                    Icon(Icons.local_shipping, color: Colors.white),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Delivery for Rucs\nLorem ipsum dolor sit amet, consectetur adipiscing elit.',
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) =>
                      ProductCard(product: cartItems[index]),
                ),
              ),
              if (productQuantities != 0) // ✅ Now it only checks after retrieval
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  color: Colors.orange,
                  child: Center(
                    child: Text(
                      'Proceed to buy ($productQuantities items)',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

// Widget productItem(String title, String price, String image, int quantity) {
//   return Card(
//     color: Colors.grey[900],
//     margin: EdgeInsets.all(10),
//     child: Padding(
//       padding: EdgeInsets.all(10),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(
//             width: 100,
//             height: 100,
//             child: Image.asset(image, fit: BoxFit.contain),
//           ),
//           SizedBox(width: 10),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(title,
//                     style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white),
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis),
//                 Text(price, style: TextStyle(fontSize: 14, color: Colors.red)),
//                 SizedBox(height: 5),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     ElevatedButton(
//                       onPressed: () {
//                         setState(() {
//                           productQuantities.remove(title);
//                         });
//                       },
//                       child: Text('Delete'),
//                       style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.white,
//                           foregroundColor: Colors.black),
//                     ),
//                     DropdownButton<int>(
//                       dropdownColor: Colors.grey[900],
//                       value: quantity,
//                       items: [1, 2, 3, 4, 5]
//                           .map((e) => DropdownMenuItem(
//                                 child: Text('$e',
//                                         style: TextStyle(color: Colors.white)),
//                                 value: e,
//                               ))
//                           .toList(),
//                       onChanged: (value) {
//                         if (value != null) {
//                           setState(() {
//                             productQuantities[title] = value;
//                           });
//                         }
//                       },
//                     ),
//                     FavoriteButton(),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }


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
              product.image,
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
                     FavoriteButton(),
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
                    Product.add_to_cart(product.name);
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
  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isFavorite = false; // Track selection state

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border, // Change icon
        color: isFavorite ? Colors.red : Colors.grey, // Change color
      ),
      onPressed: () {
        setState(() {
          isFavorite = !isFavorite; // Toggle state
        });
      },
    );
  }
}
