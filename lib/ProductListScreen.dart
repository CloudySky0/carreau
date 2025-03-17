import 'package:flutter/material.dart';

class ProductListScreen extends StatefulWidget {
  String searchQuery;
  List<String> selectedCategory = [];

  ProductListScreen({this.searchQuery = "", List<String?>? selectedCategory})
      : selectedCategory = (selectedCategory ?? []).whereType<String>().toList();
  
  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  String selectedFilter = "All";  // Default filter option
  String selectedSort = "Relevance"; // Default sort option

  final List<Map<String, String>> products = [
    {
      "name": "Tiffany & Co. Platinum Wedding Diamond Rings",
      "image": "assets/images/earings.jpg",
      "price": "Rs 22,999",
      "old_price": "Rs 24,999",
      "discount": "10% off",
      "rating": "4.6 (14803)"
    },
    {
      "name": "Carter Destinee Solitaire Ring 1895",
      "image": "assets/images/earings.jpg",
      "price": "Rs 13,50,000",
      "old_price": "Rs 14,70,380",
      "discount": "9% off",
      "rating": "4.7 (4443)"
    },
    {
      "name": "Chaumet Platinum Engagement Rings",
      "image": "assets/images/earings.jpg",
      "price": "Rs 10,80,000",
      "old_price": "Rs 11,87,948",
      "discount": "6% off",
      "rating": "4.5 (2091)"
    },
  ];

  TextEditingController searchController = TextEditingController();
  void updateSearchQuery(String query) {
  searchController.text = query; // ✅ Set text dynamically
  searchController.selection = TextSelection.fromPosition(
    TextPosition(offset: searchController.text.length), // Moves cursor to end
  );
}


  List<Map<String, String>> filteredProducts = [];
    // Selected Filters
  double _minPrice = 0;
  double _maxPrice = 2000000;
  String? _selectedDelivery;
  String? _selectedSort;
  List<String> _selectedBrands = [];
  List<String> _selectedCategory = [];
  bool _onlyDiscounted = false;

  @override
  void initState() {
    super.initState();
    // Filter products based on search query
 _applyFilters();
 updateSearchQuery(widget.searchQuery);
  }
    void _applyFilters() {
    setState(() {
      filteredProducts = products.where((product) {
        // Apply search filter
        // ignore: unrelated_type_equality_checks
        if(widget.searchQuery != Null){
        if (!product["name"]!.toLowerCase().contains(widget.searchQuery.toLowerCase())) {
          return false;
        }
        }

        // Apply price filter
       if (product["price"] is num) {
    double productPrice = (product["price"] as num).toDouble();
    return productPrice >= _minPrice && productPrice <= _maxPrice;
  }
        // Apply brand filter
        if (_selectedBrands.isNotEmpty && !_selectedBrands.contains(product["brand"])) {
          return false;
        }
        if (_selectedCategory.isNotEmpty && !_selectedCategory.contains(product["category"])) {
          return false;
        }
        // Apply delivery filter
        if (_selectedDelivery != null && product["delivery"] != _selectedDelivery) {
          return false;
        }

        // Apply discount filter
        if (_onlyDiscounted && product["discount"] == null) {
          return false;
        }

        return true;
      }).toList();

      // Apply sorting
      if (_selectedSort == "Price Low to High") {
        filteredProducts.sort((a, b) => a["price"]!.compareTo(b["price"]!));
      } else if (_selectedSort == "Price High to Low") {
        filteredProducts.sort((a, b) => b["price"]!.compareTo(a["price"]!));
      } else if (_selectedSort == "Best Rated") {
        filteredProducts.sort((a, b) => b["rating"]!.compareTo(a["rating"]!));
      }
    });
  }

    void _showFilters() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(builder: (context, setModalState) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Price Range
                  Text("Price Range", style: TextStyle(fontWeight: FontWeight.bold)),
                  RangeSlider(
                    min: 0,
                    max: 2000000,
                    values: RangeValues(_minPrice, _maxPrice),
                    onChanged: (values) {
                      setModalState(() {
                        _minPrice = values.start;
                        _maxPrice = values.end;
                      });
                    },
                  ),
                  Text("₹${_minPrice.toInt()} - ₹${_maxPrice.toInt()}"),

                  Divider(),

                  // Brand Selection (Checkboxes)
                  Text("Brand", style: TextStyle(fontWeight: FontWeight.bold)),
                  Column(
                    children: ["Tiffany", "Carter", "Chaumet"].map((brand) {
                      return CheckboxListTile(
                        title: Text(brand),
                        value: _selectedBrands.contains(brand),
                        onChanged: (bool? value) {
                          setModalState(() {
                            value == true
                                ? _selectedBrands.add(brand)
                                : _selectedBrands.remove(brand);
                          });
                        },
                      );
                    }).toList(),
                  ),

                  Divider(),

                  // Delivery Type (Radio Buttons)
                  Text("Delivery Type", style: TextStyle(fontWeight: FontWeight.bold)),
                  Column(
                    children: ["Fast Delivery", "Standard Delivery"].map((option) {
                      return RadioListTile(
                        title: Text(option),
                        value: option,
                        groupValue: _selectedDelivery,
                        onChanged: (String? value) {
                          setModalState(() {
                            _selectedDelivery = value;
                          });
                        },
                      );
                    }).toList(),
                  ),

                  Divider(),

                  // Discount Filter
                  SwitchListTile(
                    title: Text("Only Show Discounted Products"),
                    value: _onlyDiscounted,
                    onChanged: (bool value) {
                      setModalState(() {
                        _onlyDiscounted = value;
                      });
                    },
                  ),

                  Divider(),

                  // Sort Options
                  Text("Categories", style: TextStyle(fontWeight: FontWeight.bold)),
                   Column(
                    children: ["Necklace", "Ring", "Earring","Pendant","Bracelet","Bangle","Anklet","Brooch","Watch"].map((category) {
                      return CheckboxListTile(
                        title: Text(category),
                        value: _selectedBrands.contains(category),
                        onChanged: (bool? value) {
                          setModalState(() {
                            value == true
                                ? _selectedBrands.add(category)
                                : _selectedBrands.remove(category);
                          });
                        },
                      );
                    }).toList(),
                  ),

                  SizedBox(height: 10),

                  // Apply & Reset Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _applyFilters();
                          });
                          Navigator.pop(context);
                        },
                        child: Text("Apply Filters"),
                      ),
                      TextButton(
                        onPressed: () {
                          setModalState(() {
                            _minPrice = 0;
                            _maxPrice = 2000000;
                            _selectedBrands.clear();
                            _selectedDelivery = null;
                            _selectedSort = null;
                            _onlyDiscounted = false;
                          });
                        },
                        child: Text("Reset"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                    _applyFilters();
                     print("Selected ${this._selectedCategory}");
                  }else{
                    widget.searchQuery = Null as String;
                    

                  }
                  },
              ),
            ),

            // Filter & Sort Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Filter Button
                ElevatedButton(
                onPressed: _showFilters,
                child: Text("Filters"),
              ),

                // Sort Button
                PopupMenuButton<String>(
                  onSelected: (value) {
                    setState(() {
                      selectedSort = value;
                    });
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem(value: "Relevance", child: Text("Relevance")),
                    PopupMenuItem(value: "Newest", child: Text("Newest")),
                    PopupMenuItem(value: "Best Sellers", child: Text("Best Sellers")),
                  ],
                  child: _filterButton("Sort"),
                ),
              ],
            ),

            SizedBox(height: 10),

            // Product List
            Expanded(
              child: ListView.builder(
                itemCount: filteredProducts.length,
                itemBuilder: (context, index) {
                  return ProductCard(
                    product: filteredProducts[index],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

 Widget _filterButton(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white54),
      ),
      child: Row(
        children: [
          Icon(
            text == "Filters" ? Icons.filter_list : Icons.sort,
            color: Colors.white,
            size: 18,
          ),
          SizedBox(width: 5),
          Text(
            text,
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }


// Product Card Widget
class ProductCard extends StatelessWidget {
  final Map<String, String> product;

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
            child: Image.asset(
              product["image"]!,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 10),

          // Product Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product["name"]!,
                  style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Text(
                  product["rating"]!,
                  style: TextStyle(color: Colors.white54, fontSize: 12),
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Text(
                      product["price"]!,
                      style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 5),
                    Text(
                      product["old_price"]!,
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: 12,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    SizedBox(width: 5),
                    Text(
                      product["discount"]!,
                      style: TextStyle(color: Colors.green, fontSize: 12),
                    ),
                  ],
                ),
                SizedBox(height: 10),

                // Add to Cart Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () {
                    print("Added ${product["name"]} to cart");
                  },
                  child: Text("Add to cart"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}