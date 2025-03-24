import 'package:diamond_app/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'user_service.dart';
import 'user_provider.dart';
import 'changingBackground.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'template.dart';
import 'login.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;


const firebaseConfig = {

  "apiKey": "AIzaSyDye33flY1vtgJJcASR78O5Vth1myQFmIU",

  "authDomain": "diamond-app-197ff.firebaseapp.com",

  "projectId": "diamond-app-197ff",

  "storageBucket": "diamond-app-197ff.firebasestorage.app",

  "messagingSenderId": "485626860441",

  "appId": "1:485626860441:web:992d553874477f91cd7908",

  "measurementId": "G-GHEJPHF9DK"

};

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  FirebaseOptions firebaseOptions;

  if (kIsWeb) {
    // Web Firebase configuration
    firebaseOptions = FirebaseOptions(
    apiKey: "AIzaSyDye33flY1vtgJJcASR78O5Vth1myQFmIU",

  authDomain: "diamond-app-197ff.firebaseapp.com",

  projectId: "diamond-app-197ff",

  storageBucket: "diamond-app-197ff.firebasestorage.app",

  messagingSenderId: "485626860441",

  appId: "1:485626860441:web:992d553874477f91cd7908",

  measurementId: "G-GHEJPHF9DK"

    );
     await Firebase.initializeApp(options: firebaseOptions);
  } else if (Platform.isAndroid) {
    // Android Firebase configuration
    await Firebase.initializeApp();
  } else {
    throw UnsupportedError("Unsupported platform");
  }
  // await Firebase.initializeApp();  
  String? userId = await UserService.getUserId();

  runApp(JewelryMarketApp(userId: userId,));
}

class JewelryMarketApp extends StatelessWidget {
  const JewelryMarketApp({super.key,required this.userId});
  final String? userId;
  
  // JewelryMarketApp({required this.userId});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.amber,
        fontFamily: 'Poppins',
      ),
      home: ChangingBackgroundScreen(userId: userId),
      )
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    )..repeat();

    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RotationTransition(
              turns: _controller,
              child: Icon(
                FontAwesomeIcons.gem,
                size: 80,
                color: Colors.amber,
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Jewelry Marketplace",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.amber,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [
          OnboardingPage(
            title: "Welcome to Jewelry Marketplace",
            description: "Find the best jewelry that suits your style.",
            image: Icons.shopping_bag,
          ),
          OnboardingPage(
            title: "Personalized Selection",
            description: "Choose from various categories and price ranges.",
            image: Icons.filter_list,
          ),
          OnboardingPage(
            title: "Get Started",
            description: "Sign up or log in to start your journey.",
            image: Icons.login,
            isLastPage: true,
          ),
        ],
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String title;
  final String description;
  final IconData image;
  final bool isLastPage;

  const OnboardingPage({super.key, 
    required this.title,
    required this.description,
    required this.image,
    this.isLastPage = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(image, size: 100, color: Colors.amber),
          SizedBox(height: 20),
          Text(
            title,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          Text(
            description,
            style: TextStyle(fontSize: 16, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 30),
          isLastPage
              ? ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  },
                  child: Text("Get Started"),
                )
              : Container(),
        ],
      ),
    );
  }
}

// class HomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Jewelry Marketplace"),
//         centerTitle: true,
//       ),
//       body: Center(
//         child: Text(
//           "Home Screen - Coming Soon",
//           style: TextStyle(fontSize: 18),
//         ),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         items: [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
//           BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Wishlist"),
//           BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Cart"),
//           BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
//         ],
//       ),
//     );
//   }
// }
