import 'package:flutter/material.dart';
import 'Preferences.dart';

class WhyShopWithUsScreen extends StatelessWidget {
  const WhyShopWithUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/s1.png',
              fit: BoxFit.cover,
            ),
          ),
          SingleChildScrollView(  // Allow scrolling
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 220),  // Add some space at the top
                Icon(Icons.diamond, size: 80, color: Colors.white),
                SizedBox(height: 10),
                Text(
                  "Why shop with us?",
                  style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _featureCard(Icons.style, "Exclusive Designs", "Unique jewelry from verified sellers"),
                    _featureCard(Icons.lock, "Safe Payments", "Encrypted payment gateway"),
                  ],
                ),
                SizedBox(height: 20),
                _featureCard(Icons.shopping_bag, "Customizable Shopping", "Filter by style, metal, gemstone"),
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PreferencesScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue, 
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                      child: Text("Continue", style: TextStyle(fontSize: 18, color: Colors.white)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _featureCard(IconData icon, String title, String description) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Colors.white.withOpacity(0.2),
          radius: 30,
          child: Icon(icon, size: 30, color: Colors.white),
        ),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              SizedBox(height: 4),
              Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: Colors.white70),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
