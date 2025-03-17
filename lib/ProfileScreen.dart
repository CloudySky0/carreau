import 'package:flutter/material.dart';



class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[400],
        title: Text('Profile', style: TextStyle(color: Colors.black)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {},
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Name Section
            Row(
              children: [
                Icon(Icons.account_circle, size: 40, color: Colors.white),
                SizedBox(width: 10),
                Text("Hello Name", style: TextStyle(fontSize: 18)),
                Icon(Icons.arrow_drop_down, color: Colors.white),
              ],
            ),

            SizedBox(height: 15),

            // Quick Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildQuickButton("Orders"),
                _buildQuickButton("Notifications"),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildQuickButton("Account"),
                _buildQuickButton("Support & Help"),
              ],
            ),

            SizedBox(height: 20),

            // Orders Section
            Text("Orders", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(3, (index) => _buildOrderPlaceholder()),
            ),

            SizedBox(height: 20),

            // Settings List
            _buildSettingsItem("Account"),
            _buildSettingsItem("App Preferences"),
            _buildSettingsItem("Orders & Payments"),
            _buildSettingsItem("Support & Help"),
            _buildSettingsItem("Legal & About"),
            _buildSettingsItem("Linked Accounts"),
            _buildSettingsItem("Logout"),
          ],
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white54,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
      ),
    );
  }

  // Quick Action Button Widget
  Widget _buildQuickButton(String title) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
          ),
          onPressed: () {},
          child: Text(title, textAlign: TextAlign.center),
        ),
      ),
    );
  }

  // Order Placeholder Widget
  Widget _buildOrderPlaceholder() {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  // Settings List Item Widget
  Widget _buildSettingsItem(String title) {
    return Column(
      children: [
        ListTile(
          title: Text(title, style: TextStyle(fontSize: 16)),
          tileColor: Colors.white10,
          onTap: () {},
        ),
        Divider(height: 1, color: Colors.grey[800]),
      ],
    );
  }
}