import 'package:flutter/material.dart';


class ProductPage extends StatelessWidget {
  final List<Map<String, String>> products = [
    {
      "image": "assets/images/earings.jpg",
      "title": "Tiffany & Co. Platinum Wedding Diamond Rings",
      "oldPrice": "Rs 24,999",
      "newPrice": "Rs 22,999",
      "discount": "10% off",
      "rating": "4.8 (2048)"
    },
    {
      "image": "assets/images/earings.jpg",
      "title": "Carter Destinee Solitaire Ring 1895",
      "oldPrice": "Rs 14,79,000",
      "newPrice": "Rs 13,50,000",
      "discount": "9% off",
      "rating": "4.9 (648)"
    },
    {
      "image": "assets/images/earings.jpg",
      "title": "Chaumet Platinum Engagement Rings",
      "oldPrice": "Rs 18,57,346",
      "newPrice": "Rs 10,80,000",
      "discount": "6% off",
      "rating": "4.8 (1098)"
    },
    {
      "image": "assets/images/earings.jpg",
      "title": "Classic Dior Gold 5 Carat Rings",
      "oldPrice": "Rs 0",
      "newPrice": "Rs 0",
      "discount": "",
      "rating": "4.7 (825)"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: TextField(
          decoration: InputDecoration(
            hintText: "Search or ask a question",
            prefixIcon: Icon(Icons.search, color: Colors.white),
            hintStyle: TextStyle(color: Colors.white54),
            filled: true,
            fillColor: Colors.black,
            border: InputBorder.none,
          ),
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.sort, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Card(
            color: Colors.black,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(product["image"]!),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product["title"]!,
                        style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            product["oldPrice"]!,
                            style: TextStyle(color: Colors.grey, decoration: TextDecoration.lineThrough),
                          ),
                          SizedBox(width: 8),
                          Text(
                            product["newPrice"]!,
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 8),
                          Text(
                            product["discount"]!,
                            style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.yellow, size: 16),
                          SizedBox(width: 4),
                          Text(
                            product["rating"]!,
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(foregroundColor: Colors.black, backgroundColor: Colors.white),
                        onPressed: () {},
                        child: Text("Add to cart"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}