import 'package:flutter/material.dart';
import 'Database.dart';
import 'package:intl/intl.dart';


class ProductDetailPage extends StatelessWidget {
   final Product product; // Add this

  const ProductDetailPage({Key? key, required this.product}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        // title: TextField(
        //   decoration: InputDecoration(
        //     filled: true,
        //     fillColor: Colors.white,
        //     hintText: "Search or ask a question",
        //     prefixIcon: Icon(Icons.search, color: Colors.black),
        //     border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        //   ),
        // ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Product Image Slider
            Container(
              height: 250,
              child: PageView(
                children: [
                  Image.network("https://cors-anywhere.herokuapp.com/${product.image}", fit: BoxFit.cover), // Add images in assets
                  // Image.asset('assets/images/earings.jpg', fit: BoxFit.cover),
                ],
              ),
            ),

            // Product Details
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.yellow, size: 18),
                      SizedBox(width: 5),
                      Text(product.rating, style: TextStyle(color: Colors.white)),
                      Spacer(),
                      FavoriteButton(productname: product.name,),
                    ],
                  ),

                  // Price with Discount
                  Row(
                    children: [
                      Text(NumberFormat.currency(locale: 'en_IN', symbol: 'Rs. ').format(product.price), style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                      SizedBox(width: 10),
                      Text(NumberFormat.currency(locale: 'en_IN', symbol: 'Rs. ').format(product.oldPrice), style: TextStyle(fontSize: 16, color: Colors.grey, decoration: TextDecoration.lineThrough)),
                      SizedBox(width: 10),
                      Text(product.discount, style: TextStyle(fontSize: 16, color: Colors.green)),
                    ],
                  ),
                  SizedBox(height: 10),

                  // Available Offers Section
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(10),
                    color: Colors.yellow[700],
                    child: Text("AVAILABLE OFFERS", style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(height: 10),

                  // Specifications
                  ExpansionTile(
                    title: Text("Specifications", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    children: [
                      ListTile(title: Text("Brand: Tiffany & Co.", style: TextStyle(color: Colors.white))),
                      ListTile(title: Text("Collection: Luxury Diamond Rings", style: TextStyle(color: Colors.white))),
                      ListTile(title: Text("Material: 18K Platinum", style: TextStyle(color: Colors.white))),
                      ListTile(title: Text("Gemstone: Natural Diamonds", style: TextStyle(color: Colors.white))),
                      ListTile(title: Text("Diamond Cut: Round Brilliant & Emerald Cut", style: TextStyle(color: Colors.white))),
                      ListTile(title: Text("Carat Weight: 5K per ring", style: TextStyle(color: Colors.white))),
                    ],
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),

      // Add to Cart Section
      bottomNavigationBar: Container(
        color: Colors.pink,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        child: Row(
          children: [
            Text("Quantity    ", style: TextStyle(color: Colors.white)),
            // Quantity Selector
            DropdownButton<String>(
              dropdownColor: Colors.pink,
              value: "1",
              items: ["1", "2", "3", "4"]
                  .map((String value) => DropdownMenuItem(
                        value: value,
                        child: Text("$value", style: TextStyle(color: Colors.white)),
                      ))
                  .toList(),
              onChanged: (String? newValue) {},
            ),
            SizedBox(width: 20),

            // Add to Cart Button
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                   Product.add_to_cart(product.name, 1);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 12),
                ),
                child: Text("Add to Cart", style: TextStyle(color: Colors.pink, fontSize: 16)),
              ),
            ),
          ],
        ),
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

// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: ProductPage(),
//     );
//   }
// }

// class ProductPage extends StatefulWidget {
//   @override
//   _ProductPageState createState() => _ProductPageState();
// }

// class _ProductPageState extends State<ProductPage> {
//   int quantity = 1;
//   String? selectedCustomization;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         title: TextField(
//           decoration: InputDecoration(
//             hintText: "Search or ask a question",
//             prefixIcon: Icon(Icons.search),
//             border: InputBorder.none,
//           ),
//         ),
        
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Image.asset('assets/ring.jpg', fit: BoxFit.cover),
//             Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "Tiffany & Co. Platinum Wedding 18 Karat Diamond Rings",
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
//                   ),
//                   Row(
//                     children: [
//                       Icon(Icons.star, color: Colors.amber, size: 18),
//                       Text(" 4.5 (14839)"),
//                     ],
//                   ),
//                   SizedBox(height: 5),
//                   Row(
//                     children: [
//                       Text(
//                         "Rs 22,999",
//                         style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
//                       ),
//                       SizedBox(width: 10),
//                       Text(
//                         "Rs 24,999",
//                         style: TextStyle(
//                           decoration: TextDecoration.lineThrough,
//                           color: Colors.grey,
//                         ),
//                       ),
//                       SizedBox(width: 10),
//                       Text(
//                         "10% off",
//                         style: TextStyle(color: Colors.green),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 10),
//                   Container(
//                     color: Colors.yellow[700],
//                     padding: EdgeInsets.all(8),
//                     child: Text(
//                       "AVAILABLE OFFERS",
//                       style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
//                     ),
//                   ),
//                   SizedBox(height: 10),
//                   Text(
//                     "Features:",
//                     style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
//                   ),
//                   SizedBox(height: 5),
//                   Text("• Timeless, elegant design",style: TextStyle(color: Colors.white)),
//                   Text("• Certified conflict-free diamonds", style: TextStyle(color: Colors.white)),
//                   Text("• Available in multiple sizes", style: TextStyle(color: Colors.white)),
//                   Text("• Handcrafted with precision", style: TextStyle(color: Colors.white)),
//                   SizedBox(height: 10),
//                   DropdownButton<String>(
//                     dropdownColor: Colors.grey[900],
//                     hint: Text("Customization (if any)"),
//                     value: selectedCustomization,
//                     onChanged: (value) {
//                       setState(() {
//                         selectedCustomization = value;
//                       });
//                     },
//                     items: ["Engraving", "Custom Fit", "No Customization"]
//                         .map((option) => DropdownMenuItem(
//                               child: Text(option, style: TextStyle(color: Colors.white),),
//                               value: option,
//                             ))
//                         .toList(),
//                   ),
//                   SizedBox(height: 10),
//                   Row(
//                     children: [
//                       DropdownButton<int>(
//                         value: quantity,
//                         dropdownColor: Colors.grey[900],
//                         onChanged: (value) {
//                           setState(() {
//                             quantity = value!;
//                           });
//                         },
//                         items: List.generate(
//                           10,
//                           (index) => DropdownMenuItem(
//                             child: Text("${index + 1}",style: TextStyle(color: Colors.white),),
//                             value: index + 1,
//                           ),
//                         ),
//                       ),
//                       SizedBox(width: 10),
//                       Expanded(
//                         child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             padding: EdgeInsets.symmetric(vertical: 15),
//                             backgroundColor: Colors.pink,
//                           ),
//                           onPressed: () {},
//                           child: Text("Add to cart", style: TextStyle(color: Colors.white),),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }