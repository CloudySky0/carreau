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
  late Future<List<Map<Product, dynamic>>> cartFuture;
 void refreshPage() {
  setState(() {
    var userData = Provider.of<UserProvider>(context, listen: false).userData;
    cartFuture = Product.fetchCart(userData); // ✅ Refetch cart data
  });
}

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
      body: FutureBuilder<List<Map<Product, dynamic>>>(
  future: cartFuture,
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return Center(child: CircularProgressIndicator());
    }
    if (snapshot.hasError) {
      return Center(
        child: Text(
          "Error: ${snapshot.error}",
          style: TextStyle(color: Colors.white),
        ),
      );
    }
    if (!snapshot.hasData || snapshot.data!.isEmpty) {
      return Center(
        child: Text(
          "No items in cart",
          style: TextStyle(color: Colors.white),
        ),
      );
    }

    List<Map<Product, dynamic>> cartItems = snapshot.data!;
    int totalQuantity = cartItems.fold(
        0, (sum, item) => sum + (item.values.first as int));

    return StatefulBuilder(
      builder: (context, setState) => Column(
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
              itemBuilder: (context, index) {
                Product product = cartItems[index].keys.first;
                int quantity = cartItems[index].values.first;

                return ProductCard(
                  product: product,
                  quantity: quantity,
                  onIncrement: () {
                    setState(() {
                      cartItems[index][product] = quantity + 1;
                      totalQuantity++;
                    });
                  },
                  onDecrement: () {
                    setState(() {
                      if (quantity > 1) {
                        cartItems[index][product] = quantity - 1;
                        totalQuantity--;
                      }
                    });
                  },
                  refreshPage: refreshPage
                );
              },
            ),
          ),
          if (totalQuantity != 0)
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              color: Colors.orange,
              child: Center(
                child: Text(
                  'Proceed to buy ($totalQuantity items)',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
            ),
        ],
      ),
    );
  },
)
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
//                           totalQuantity.remove(title);
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
//                             totalQuantity[title] = value;
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
  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback refreshPage;
  
   ProductCard({
    required this.product,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
    required this.refreshPage,
  });

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
                     IconButton(
                  icon: Icon(Icons.remove,color: Colors.white),
                  onPressed: quantity > 1 ? onDecrement : null,
                ),
                Text('$quantity', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                IconButton(
                  icon: Icon(Icons.add,color: Colors.white),
                  onPressed: onIncrement,
                ),
                  ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed:  () async {
    print("Deleting ${product.name} from cart");
    await Product.removefromCart(product.name);
    refreshPage();
                    // Product.add_to_cart(product.name);
                  },
                  child: Text(" Delete "),
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
