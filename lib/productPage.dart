import 'package:flutter/material.dart';
import 'ProductListScreen.dart';
class ProductPage extends StatelessWidget {
  final List<Map<String, String>> categories = [
    {"name": "Necklaces", "image": "assets/images/necklace.jpg"},
    {"name": "Rings", "image": "assets/images/necklace.jpg"},
    {"name": "Earrings", "image": "assets/images/necklace.jpg"},
    {"name": "Pendants", "image": "assets/images/necklace.jpg"},
    {"name": "Bracelets", "image": "assets/images/necklace.jpg"},
    {"name": "Bangles", "image": "assets/images/necklace.jpg"},
    {"name": "Anklets", "image": "assets/images/necklace.jpg"},
    {"name": "Brooches & Pins", "image": "assets/images/necklace.jpg"},
    {"name": "Watches", "image": "assets/images/necklace.jpg"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Shop By Category",
              style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.8,
                ),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return CategoryCard(
                    image: categories[index]["image"]!,
                    label: categories[index]["name"]!,
                    onTap: () {
                      // Handle navigation or action
                       Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductListScreen(searchQuery: "", selectedCategory: [categories[index]["name"]],),
          ),
        );
                      // print("Tapped on ${categories[index]["name"]}");
                    },
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

class CategoryCard extends StatelessWidget {
  final String image;
  final String label;
  final VoidCallback onTap; // Function to handle button press

  CategoryCard({required this.image, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Call the function when tapped
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: AssetImage(image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(height: 5),
          Text(
            label,
            style: TextStyle(color: Colors.white, fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
