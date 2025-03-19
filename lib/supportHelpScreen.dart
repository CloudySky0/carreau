import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: SupportHelpScreen(),
    );
  }
}

class SupportHelpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text("Support & help", style: TextStyle(color: Colors.black)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {},
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search bar
            Text("How can we help you?", style: TextStyle(color: Colors.white, fontSize: 16)),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: "Search or ask a question",
                prefixIcon: Icon(Icons.search, color: Colors.black),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            SizedBox(height: 20),

            // Help Categories
            _buildHelpButton("Order & Shipping – Track orders, delivery issues, returns."),
            _buildHelpButton("Payments & Refunds – Billing, refunds, & payment issues."),
            _buildHelpButton("Account & Security – Manage your account & password."),
            _buildHelpButton("Shopping Assistance – How to browse, wishlist, & buy."),
            _buildHelpButton("App Settings – Language, notifications, and preferences."),
            _buildHelpButton("Contact Us – Need more help? Talk to our support team."),
            SizedBox(height: 20),

            // Popular FAQ Sections
            Text("Popular FAQ Sections", style: TextStyle(color: Colors.white, fontSize: 16)),
            SizedBox(height: 10),
            _buildFAQButton('"How do I return an item?"'),
            _buildFAQButton('"When will I receive my refund?"'),
            _buildFAQButton('"How can I change my password?"'),
            _buildFAQButton('"What are the accepted payment methods?"'),
            SizedBox(height: 20),

            // Chat and Call Buttons
            Text("For more details, visit our Help Center.", style: TextStyle(color: Colors.white)),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildActionButton(Icons.chat, "Chat"),
                SizedBox(width: 10),
                _buildActionButton(Icons.call, "Call"),
              ],
            ),
            SizedBox(height: 20),

            // Full Help Center Button
            Center(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: Text("View full help center", style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),

      
    );
  }

  // Helper method to build Help Category Buttons
  Widget _buildHelpButton(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(text, style: TextStyle(color: Colors.black)),
        ),
      ),
    );
  }

  // Helper method to build FAQ Buttons
  Widget _buildFAQButton(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(text, style: TextStyle(color: Colors.black, fontSize: 14)),
        ),
      ),
    );
  }

  // Helper method to build Chat & Call Buttons
  Widget _buildActionButton(IconData icon, String text) {
    return ElevatedButton.icon(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
      icon: Icon(icon, color: Colors.black),
      label: Text(text, style: TextStyle(color: Colors.black)),
    );
  }
}