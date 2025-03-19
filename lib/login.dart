import 'package:diamond_app/template.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'user_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _nameController = TextEditingController();
  bool isLoading = false;
  String? message; // Stores login result

  Future<void> _checkNameInFirebase() async {
  setState(() => isLoading = true);

  String name = _nameController.text.trim();
  if (name.isEmpty) {
    setState(() {
      message = "Please enter a name.";
      isLoading = false;
    });
    return;
  }

  try {
    var query = await FirebaseFirestore.instance
        .collection('Users')
        .where('profile.name', isEqualTo: name)
        .get();

    if (query.docs.isNotEmpty) {
      String userId = query.docs.first.id; // Get document ID

      await UserService.saveUserId(userId); // Store ID in SharedPreferences

      setState(() => message = "✅ Login Successful!");

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Template(userId: userId)),
      );
    } else {
      setState(() => message = "❌ User Not Found.");
    }
  } catch (e) {
    setState(() => message = "⚠️ Error: $e");
  } finally {
    setState(() => isLoading = false);
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login Page")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: "Enter your name"),
              ),
              SizedBox(height: 10),
              isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _checkNameInFirebase,
                      child: Text("Login"),
                    ),
              SizedBox(height: 10),
              if (message != null)
                Text(
                  message!,
                  style: TextStyle(fontSize: 16, color: Colors.blue),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
