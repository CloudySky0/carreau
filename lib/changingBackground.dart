import 'dart:async';
import 'package:diamond_app/template.dart';
import 'package:flutter/material.dart';
import 'WhyShopWithUs.dart';

class ChangingBackgroundScreen extends StatefulWidget {
  const ChangingBackgroundScreen({super.key});

  @override
  _ChangingBackgroundScreenState createState() =>
      _ChangingBackgroundScreenState();
}

class _ChangingBackgroundScreenState extends State<ChangingBackgroundScreen> {
  List<String> backgroundImages = [
    'assets/images/0.S.1.1.png',
    'assets/images/0.S.1.2.png',
    'assets/images/0.S.1.3.png',
    'assets/images/0.S.1.4.png',
    'assets/images/0.S.1.5.png',
    'assets/images/0.S.1.6.png',
  ];
  
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 3), (timer) {
      setState(() {
        currentIndex = (currentIndex + 1) % backgroundImages.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: AnimatedSwitcher(
              duration: Duration(seconds: 1),
              child: Image.asset(
                backgroundImages[currentIndex],
                key: ValueKey<int>(currentIndex),
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
          ),

          // Foreground Elements
          Positioned(
            top: 550,
            left: 20,
            right: 20,
            child: Text(
              'Welcome to Karreau, your personalized jewelry shopping experience',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // Positioned Button
          Positioned(
            bottom: 50,
            left: 50,
            right: 50,
            child: GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => WhyShopWithUsScreen()),);
                print("Button Pressed!");
              },
              child: Container(
                width: 261,
                height: 58,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Color.fromRGBO(25, 21, 255, 1),
                ),
                child: Text(
                  "Shop Now",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
