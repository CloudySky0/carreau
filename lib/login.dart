import 'package:flutter/material.dart';
import 'user_service.dart';
import 'template.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;

  Future<void> login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    String? userId = await UserService.loginUser(email, password);

    if (userId != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Template(userId: userId,)),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Invalid email or password")),
      );
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Login", style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                  labelStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email, color: Colors.white),
                ),
                style: TextStyle(color: Colors.white),
                keyboardType: TextInputType.emailAddress,
                validator: (value) => value!.isEmpty ? "Enter your email" : null,
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password",
                  labelStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock, color: Colors.white),
                ),
                style: TextStyle(color: Colors.white),
                validator: (value) => value!.length < 6 ? "Password must be at least 6 characters" : null,
              ),
              SizedBox(height: 20),
              isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: login,
                      child: Text("Login"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.black,
                        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 50),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
