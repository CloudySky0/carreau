import 'package:flutter/material.dart';

class ShoppingCartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Removes the back button
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
            color: Colors.grey[300],
            child: Row(
              children: [
                Icon(Icons.local_shipping, color: Colors.black),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Delivery for Rucs\nLorem ipsum dolor sit amet, consectetur adipiscing elit.',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                productItem('Tiffany & Co. Platinum Wedding Diamond Rings',
                    'Rs 22,999', 'assets/images/earings.jpg', 1),
                productItem('Pandora Diamond Bracelet', 'Rs 13,50,000',
                    'assets/images/earings.jpg', 1),
                productItem('Harry Winston Diamond Set', 'Rs 10,75,000',
                    'assets/images/earings.jpg', 2),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
            color: Colors.yellow,
            child: Center(
              child: Text(
                'Proceed to buy (2 items)',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget productItem(String title, String price, String image, int quantity) {
  return Card(
    margin: EdgeInsets.all(10),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(image, width: 100, height: 100, fit: BoxFit.cover),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(price, style: TextStyle(fontSize: 14, color: Colors.red)),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Delete'),
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.black),
                  ),
                  DropdownButton<int>(
                    value: quantity,
                    items: [1, 2, 3, 4, 5]
                        .map((e) => DropdownMenuItem(
                              child: Text('Quantity $e'),
                              value: e,
                            ))
                        .toList(),
                    onChanged: (value) {},
                  ),
                  Icon(Icons.favorite_border, color: Colors.red),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
