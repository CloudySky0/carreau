import 'dart:developer';

import 'package:diamond_app/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'accountPage.dart';
import 'appPreferences.dart';
import 'paymentMethods.dart';
import 'supportHelpScreen.dart';
import 'user_provider.dart';
import 'user_service.dart';
import 'main.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var userData = Provider.of<UserProvider>(context).userData;


    return Scaffold(
      backgroundColor: Colors.black,
      // appBar: AppBar(
      //   backgroundColor: Colors.grey[400],
      //   title: Text('Profile', style: TextStyle(color: Colors.black)),
      //   leading: IconButton(
      //     icon: Icon(Icons.arrow_back, color: Colors.black),
      //     onPressed: () {},
      //   ),
      // ),
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
                Text("Hello ${userData?['profile']['name']}", style: TextStyle(fontSize: 18, color: Colors.white)),
                Icon(Icons.arrow_drop_down, color: Colors.white),
              ],
            ),

            SizedBox(height: 15),

            // Quick Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildQuickButton(context,"Orders"),
                _buildQuickButton(context, "Notifications"),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildQuickButton(context,"Account"),
                _buildQuickButton(context,"Support & Help"),
              ],
            ),

            SizedBox(height: 20),

            // Orders Section
            Text("Orders", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(3, (index) => _buildOrderPlaceholder()),
            ),

            SizedBox(height: 20),

            // Settings List
            _buildSettingsItem(context, "Account"),
            _buildSettingsItem(context, "App Preferences"),
            _buildSettingsItem(context, "Orders & Payments"),
            _buildSettingsItem(context, "Support & Help"),
            _buildSettingsItem(context, "Legal & About"),
            _buildSettingsItem(context, "Linked Accounts"),
            _buildSettingsItem(context, "Logout"),
          ],
        ),
      ),


    );
  }

  // Quick Action Button Widget
Widget _buildQuickButton(BuildContext context, String title) {
  return Expanded(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white24,
          foregroundColor: Colors.white,
        ),
        onPressed: () {
          if (title == "Account") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AccountScreen()),
            );
          }
          if (title == "Support & Help"){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SupportHelpScreen()),
            );
          }
        },
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
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  // Settings List Item Widget
  Widget _buildSettingsItem(BuildContext context, String title) {
    return Column(
      children: [
        ListTile(
          title: Text(title, style: TextStyle(fontSize: 16,color: Colors.white)),
          tileColor: Colors.white10,
          onTap: () {
            if (title == "Account") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AccountScreen()),
            );
            }
            if (title == "App Preferences") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AppPreferencesScreen()),
            );
          }
          if (title == "Orders & Payments") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SavedPaymentMethodsScreen()),
            );
          }
          if (title == "Logout") {
             UserService.clearUser();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => JewelryMarketApp(userId: null,)),
            );
          }
          },
        ),
        Divider(height: 1, color: Colors.grey[800]),
      ],
    );
  }
}