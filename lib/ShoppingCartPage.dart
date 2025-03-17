import 'package:flutter/material.dart';

class ShoppingCartPage extends StatefulWidget {
  @override
  _ShoppingCartPageState createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  Map<String, int> productQuantities = {
    'Tiffany & Co. Platinum Wedding Diamond Rings': 1,
    'Pandora Diamond Bracelet': 1,
    'Harry Winston Diamond Set': 2,
  };

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
      body: Column(
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
            child: productQuantities.isEmpty
                ? Center(
                    child: Text(
                      'Your cart is empty',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  )
                : ListView(
                    children: productQuantities.keys.map((title) {
                      return productItem(
                        title,
                        'Rs 22,999',
                        'assets/images/earings.jpg',
                        productQuantities[title]!,
                      );
                    }).toList(),
                  ),
          ),
          if (productQuantities.isNotEmpty)
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              color: Colors.orange,
              child: Center(
                child: Text(
                  'Proceed to buy (${productQuantities.values.reduce((a, b) => a + b)} items)',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
            ),
        ],
      ),
    );
  }

Widget productItem(String title, String price, String image, int quantity) {
  return Card(
    color: Colors.grey[900],
    margin: EdgeInsets.all(10),
    child: Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            height: 100,
            child: Image.asset(image, fit: BoxFit.contain),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis),
                Text(price, style: TextStyle(fontSize: 14, color: Colors.red)),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          productQuantities.remove(title);
                        });
                      },
                      child: Text('Delete'),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black),
                    ),
                    DropdownButton<int>(
                      dropdownColor: Colors.grey[900],
                      value: quantity,
                      items: [1, 2, 3, 4, 5]
                          .map((e) => DropdownMenuItem(
                                child: Text('$e',
                                        style: TextStyle(color: Colors.white)),
                                value: e,
                              ))
                          .toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            productQuantities[title] = value;
                          });
                        }
                      },
                    ),
                    FavoriteButton(),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
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
