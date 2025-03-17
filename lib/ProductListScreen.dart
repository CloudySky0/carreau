// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';


// class Product {
//   final String name;
//   final String image;
//   final double price;
//   final double oldPrice;
//   final String discount;
//   final String rating;
//   final String category;
//   final String delivery;

//   Product({
//     required this.name,
//     required this.image,
//     required this.price,
//     required this.oldPrice,
//     required this.discount,
//     required this.rating,
//     required this.category,
//     required this.delivery,
//   });

//   factory Product.fromMap(Map<String, dynamic> data) {
//     return Product(
//       name: data["name"]?.toString() ?? "",
//       image: data["imageURL"]?.toString() ?? "",
//       price: (data["price"] is num) ? (data["price"] as num).toDouble() : 0.0,
//       oldPrice: (data["old_price"] is num) ? (data["old_price"] as num).toDouble() : 0.0,
//       discount: data["discount"]?.toString() ?? "",
//       rating: data["rating"]?.toString() ?? "",
//       category: data["category"]?.toString() ?? "",
//       delivery: data["delivery"]?.toString() ?? "",
//     );
//   }
// }


// class ProductListScreen extends StatefulWidget {
//   String searchQuery;
//   List<String> selectedCategory = [];

//   ProductListScreen({this.searchQuery = "", List<String?>? selectedCategory})
//       : selectedCategory = (selectedCategory ?? []).whereType<String>().toList();
  
//   @override
//   _ProductListScreenState createState() => _ProductListScreenState();
// }

// class _ProductListScreenState extends State<ProductListScreen> {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   String selectedFilter = "All";  // Default filter option
//   String selectedSort = "Relevance"; // Default sort option

//   TextEditingController searchController = TextEditingController();
//   void updateSearchQuery(String query) {
//   searchController.text = query; // ✅ Set text dynamically
//   searchController.selection = TextSelection.fromPosition(
//     TextPosition(offset: searchController.text.length), // Moves cursor to end
//   );
// }



// List<Product> products = [];
// List<Product>  filteredProducts = [];
//     // Selected Filters
//   double _minPrice = 0;
//   double _maxPrice = 2000000;
//   String? _selectedDelivery;
//   String? _selectedSort;
//   List<String> _selectedBrands = [];
//   List<String> _selectedCategory = [];
//   bool _onlyDiscounted = false;

//   @override
//   void initState() {
//     super.initState();
//     // Filter products based on search query
//     _fetchProductsFromFirebase();
//  updateSearchQuery(widget.searchQuery);
//   }

//   void _fetchProductsFromFirebase() async {
//   FirebaseFirestore.instance.collection('products').get().then((snapshot) {
//     setState(() {
//       products = snapshot.docs.map((doc) => Product.fromMap(doc.data())).toList();
//       _applyFilters();
//     });
//   }).catchError((error) {
//     print("Error fetching products: $error");
//   });
// }


//    void _applyFilters() {
//   setState(() {
//     filteredProducts = products.where((product) {
//       // Apply search filter
//       if (widget.searchQuery.isNotEmpty) {
//         if (!product.name.toLowerCase().contains(widget.searchQuery.toLowerCase())) {
//           return false;
//         }
//       }

//       // Convert price to number and filter
//       double productPrice = (product.price) ?? 0;
//       if (productPrice < _minPrice || productPrice > _maxPrice) {
//         return false;
//       }


//       // Apply category filter
//       if (_selectedCategory.isNotEmpty && !_selectedCategory.contains(product.category ?? "")) {
//         return false;
//       }

//       // Apply delivery filter
//       if (_selectedDelivery != null && product.delivery != _selectedDelivery) {
//         return false;
//       }

//       // Apply discount filter
//       if (_onlyDiscounted && (product.discount == null || product.discount!.isEmpty)) {
//         return false;
//       }

//       return true;
//     }).toList();

//     // Apply sorting
//     if (_selectedSort == "Price Low to High") {
//       filteredProducts.sort((a, b) =>
//         ((a.price) ?? 0).compareTo((b.price) ?? 0)
//       );
//     } else if (_selectedSort == "Price High to Low") {
//       filteredProducts.sort((a, b) =>
//         ((a.price) ?? 0).compareTo((b.price) ?? 0)
//       );
//     } else if (_selectedSort == "Best Rated") {
//       filteredProducts.sort((a, b) =>
//         (double.tryParse(b.rating?.split(" ")?.first ?? "0") ?? 0)
//         .compareTo(double.tryParse(a.rating?.split(" ")?.first ?? "0") ?? 0)
//       );
//     }
//   });
// }

//     void _showFilters() {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       builder: (context) {
//         return StatefulBuilder(builder: (context, setModalState) {
//           return Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: SingleChildScrollView(
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   // Price Range
//                   Text("Price Range", style: TextStyle(fontWeight: FontWeight.bold)),
//                   RangeSlider(
//                     min: 0,
//                     max: 2000000,
//                     values: RangeValues(_minPrice, _maxPrice),
//                     onChanged: (values) {
//                       setModalState(() {
//                         _minPrice = values.start;
//                         _maxPrice = values.end;
//                       });
//                     },
//                   ),
//                   Text("₹${_minPrice.toInt()} - ₹${_maxPrice.toInt()}"),

//                   Divider(),

//                   // Brand Selection (Checkboxes)
//                   Text("Brand", style: TextStyle(fontWeight: FontWeight.bold)),
//                   Column(
//                     children: ["Tiffany", "Carter", "Chaumet"].map((brand) {
//                       return CheckboxListTile(
//                         title: Text(brand),
//                         value: _selectedBrands.contains(brand),
//                         onChanged: (bool? value) {
//                           setModalState(() {
//                             value == true
//                                 ? _selectedBrands.add(brand)
//                                 : _selectedBrands.remove(brand);
//                           });
//                         },
//                       );
//                     }).toList(),
//                   ),

//                   Divider(),

//                   // Delivery Type (Radio Buttons)
//                   Text("Delivery Type", style: TextStyle(fontWeight: FontWeight.bold)),
//                   Column(
//                     children: ["Fast Delivery", "Standard Delivery", "Free Delivery"].map((option) {
//                       return RadioListTile(
//                         title: Text(option),
//                         value: option,
//                         groupValue: _selectedDelivery,
//                         onChanged: (String? value) {
//                           setModalState(() {
//                             _selectedDelivery = value;
//                           });
//                         },
//                       );
//                     }).toList(),
//                   ),

//                   Divider(),

//                   // Discount Filter
//                   SwitchListTile(
//                     title: Text("Only Show Discounted Products"),
//                     value: _onlyDiscounted,
//                     onChanged: (bool value) {
//                       setModalState(() {
//                         _onlyDiscounted = value;
//                       });
//                     },
//                   ),

//                   Divider(),

//                   // Sort Options
//                   Text("Categories", style: TextStyle(fontWeight: FontWeight.bold)),
//                    Column(
//                     children: ["Necklace", "Ring", "Earring","Pendant","Bracelet","Bangle","Anklet","Brooch","Watch"].map((category) {
//                       return CheckboxListTile(
//                         title: Text(category),
//                         value: _selectedCategory.contains(category),
//                         onChanged: (bool? value) {
//                           setModalState(() {
//                             value == true
//                                 ? _selectedCategory.add(category)
//                                 : _selectedCategory.remove(category);
//                           });
//                         },
//                       );
//                     }).toList(),
//                   ),

//                   SizedBox(height: 10),

//                   // Apply & Reset Buttons
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       ElevatedButton(
//                         onPressed: () {
//                           setState(() {
//                             _applyFilters();
//                           });
//                           Navigator.pop(context);
//                         },
//                         child: Text("Apply Filters"),
//                       ),
//                       TextButton(
//                         onPressed: () {
//                           setModalState(() {
//                             _minPrice = 0;
//                             _maxPrice = 2000000;
//                             _selectedBrands.clear();
//                             _selectedDelivery = null;
//                             _selectedCategory.clear();
//                             _selectedSort = null;
//                             _onlyDiscounted = false;
//                           });
//                         },
//                         child: Text("Reset"),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           );
//         });
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Padding(
//         padding: const EdgeInsets.all(10.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Search Bar
//             Container(
//               padding: EdgeInsets.symmetric(horizontal: 10),
//               margin: EdgeInsets.only(top: 40, bottom: 10),
//               decoration: BoxDecoration(
//                 color: Colors.white10,
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: TextField(
//                 controller: searchController,
//                 decoration: InputDecoration(
//                   hintText: "Search or ask a question",
//                   hintStyle: TextStyle(color: Colors.white54),
//                   border: InputBorder.none,
//                   prefixIcon: Icon(Icons.search, color: Colors.white),
//                 ),
//                 style: TextStyle(color: Colors.white),
//                 onSubmitted:  (query) {
//                   if (query.isNotEmpty){
//                     widget.searchQuery = query;
//                     _applyFilters();
//                      print("Selected ${this._selectedCategory}");
//                   }else{
//                     widget.searchQuery = Null as String;
                    

//                   }
//                   },
//               ),
//             ),

//             // Filter & Sort Row
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 // Filter Button
//                 ElevatedButton(
//                 onPressed: _showFilters,
//                 child: Text("Filters"),
//               ),

//                 // Sort Button
//                 PopupMenuButton<String>(
//                   onSelected: (value) {
//                     setState(() {
//                       selectedSort = value;
//                     });
//                   },
//                   itemBuilder: (context) => [
//                     PopupMenuItem(value: "Relevance", child: Text("Relevance")),
//                     PopupMenuItem(value: "Newest", child: Text("Newest")),
//                     PopupMenuItem(value: "Best Sellers", child: Text("Best Sellers")),
//                   ],
//                   child: _filterButton("Sort"),
//                 ),
//               ],
//             ),

//             SizedBox(height: 10),

//             // Product List
//             Expanded(
//               child: ListView.builder(
//                 itemCount: filteredProducts.length,
//                 itemBuilder: (context, index) {
//                   return ProductCard(
//                     product: filteredProducts[index],
//                   );
//                 },
//               ),
//             ),  
//           ],
//         ),
//       ),
//     );
//   }
// }

//  Widget _filterButton(String text) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
//       decoration: BoxDecoration(
//         color: Colors.white10,
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(color: Colors.white54),
//       ),
//       child: Row(
//         children: [
//           Icon(
//             text == "Filters" ? Icons.filter_list : Icons.sort,
//             color: Colors.white,
//             size: 18,
//           ),
//           SizedBox(width: 5),
//           Text(
//             text,
//             style: TextStyle(color: Colors.white),
//           ),
//         ],
//       ),
//     );
//   }


// // Product Card Widget
// class ProductCard extends StatelessWidget {
//   final Product product;

//   ProductCard({required this.product});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.symmetric(vertical: 8),
//       padding: EdgeInsets.all(10),
//       decoration: BoxDecoration(
//         color: Colors.white10,
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Product Image
//           ClipRRect(
//             borderRadius: BorderRadius.circular(10),
//             child: Image.asset(
//               "assets/images/necklace.jpg",
//               width: 100,
//               height: 100,
//               fit: BoxFit.cover,
//             ),
//           ),
//           SizedBox(width: 10),

//           // Product Details
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   product.name!,
//                   style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
//                 ),
//                 SizedBox(height: 5),
//                 Text(
//                   product.rating!,
//                   style: TextStyle(color: Colors.white54, fontSize: 12),
//                 ),
//                 SizedBox(height: 5),
//                 Row(
//                   children: [
//                     Text(
//                       product.price.toStringAsFixed(2),
//                       style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
//                     ),
//                     SizedBox(width: 5),
//                     Text(
//                       product.oldPrice.toStringAsFixed(2),
//                       style: TextStyle(
//                         color: Colors.white54,
//                         fontSize: 12,
//                         decoration: TextDecoration.lineThrough,
//                       ),
//                     ),
//                     SizedBox(width: 5),
//                     Text(
//                       product.discount!,
//                       style: TextStyle(color: Colors.green, fontSize: 12),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 10),

//                 // Add to Cart Button
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.white,
//                     foregroundColor: Colors.black,
//                     padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//                   ),
//                   onPressed: () {
//                     print("Added ${product.name} to cart");
//                   },
//                   child: Text("Add to cart"),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

class ProductListScreen extends StatefulWidget {
  String searchQuery;
  List<String> selectedCategory = [];

   ProductListScreen({this.searchQuery = "", List<String?>? selectedCategory})
       : selectedCategory = (selectedCategory ?? []).whereType<String>().toList();
  
  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Product> products = [];
  List<Product> filteredProducts = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchProductsFromFirebase();
    updateSearchQuery(widget.searchQuery);
  }

  void _fetchProductsFromFirebase() async {
    _firestore.collection('products').get().then((snapshot) {
      setState(() {
        products = snapshot.docs.map((doc) => Product.fromMap(doc.data())).toList();
        filteredProducts = products;
      });
    }).catchError((error) {
      print("Error fetching products: $error");
    });
  }

  void _searchProducts(String query) {
    setState(() {
      filteredProducts = products.where((product) {
        return product.name.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  void updateSearchQuery(String query) {
  searchController.text = query; // ✅ Set text dynamically
  searchController.selection = TextSelection.fromPosition(
    TextPosition(offset: searchController.text.length), // Moves cursor to end
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            // Search Bar
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              margin: EdgeInsets.only(top: 40, bottom: 10),
              decoration: BoxDecoration(
                color: Colors.white10,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: "Search or ask a question",
                  hintStyle: TextStyle(color: Colors.white54),
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search, color: Colors.white),
                ),
                style: TextStyle(color: Colors.white),
                onSubmitted:  (query) {
                  if (query.isNotEmpty){
                    widget.searchQuery = query;
                    _searchProducts(query);
                  }else{
                    widget.searchQuery = Null as String;
                    

                  }
                  },
              ),
            ),

            // Product List
            Expanded(
              child: filteredProducts.isEmpty
                  ? Center(
                      child: Text(
                        "No products found",
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  : ListView.builder(
                      itemCount: filteredProducts.length,
                      itemBuilder: (context, index) {
                        return ProductCard(product: filteredProducts[index]);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

// Updated Product Card with Network Image
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
                      "₹${product.price.toStringAsFixed(2)}",
                      style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 5),
                    Text(
                      "₹${product.oldPrice.toStringAsFixed(2)}",
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
