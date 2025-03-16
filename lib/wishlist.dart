import 'package:flutter/material.dart';

class Wishlist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WishlistScreen(),
    );
  }
}

class WishlistScreen extends StatelessWidget {
  final List<Map<String, String>> items = [
    {
      'image': 'assets/images/bracelet.jpg',
      'title': 'Vintage Crystal Diamond Choker',
      'oldPrice': 'Rs 5,999',
      'newPrice': 'Rs 4,499',
      'discount': '25% off',
      'rating': '★★★★☆ (3459)'
    },
    {
      'image': 'assets/images/bracelet.jpg',
      'title': 'Vintage Dior Gold Chain',
      'oldPrice': 'Rs 3,999',
      'newPrice': 'Rs 2,599',
      'discount': '15% off',
      'rating': '★★★★★ (3895)'
    },
    {
      'image': 'assets/images/bracelet.jpg',
      'title': 'Tiffany & Co. Platinum Wedding Diamond Ring',
      'oldPrice': 'Rs 24,999',
      'newPrice': 'Rs 22,999',
      'discount': '10% off',
      'rating': '★★★★☆ (4568)'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child:     Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: items.map((item) => WishlistItem(item)).toList(),
        ),
      ),
    ));
  }
}

class WishlistItem extends StatelessWidget {
  final Map<String, String> item;

  WishlistItem(this.item);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(item['image']!, width: 100, height: 100, fit: BoxFit.cover),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item['title']!, style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 5),
                  Text.rich(
  TextSpan(
    children: [
      // Strikethrough for old price
      TextSpan(
        text: '${item['oldPrice']}  ', // Add space for separation
        style: TextStyle(
          color: Colors.grey, // Faded color for old price
          decoration: TextDecoration.lineThrough, // Strikethrough effect
          decorationColor: Colors.red, // Optional: Strikethrough color
          decorationThickness: 2, // Optional: Line thickness
        ),
      ),
      // New price (bold and red)
      TextSpan(
        text: ' ${item['newPrice']}  ',
        style: TextStyle(
          color: Colors.red,
          fontWeight: FontWeight.bold,
        ),
      ),
      // Discount (if applicable)
      TextSpan(
        text: '  ${item['discount']}',
        style: TextStyle(
          color: Colors.green, // You can change this color
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  ),
),

                  Text(item['rating']!),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FavoriteButton(),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text('Add to cart'),
                      )
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
