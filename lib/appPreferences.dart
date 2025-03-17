import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPreferencesScreen extends StatefulWidget {
  @override
  _AppPreferencesScreenState createState() => _AppPreferencesScreenState();
}

class _AppPreferencesScreenState extends State<AppPreferencesScreen> {
  bool isLightTheme = false;
  String? selectedLanguage;
  String? selectedCurrency;
  bool orderUpdates = true;
  bool exclusiveDeals = true;
  bool wishlistAlerts = true;
  bool newArrivals = true;
  bool securityAlerts = true;

  @override
  void initState() {
    super.initState();
    loadPreferences();
  }

  // Save Preferences
  Future<void> savePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("isLightTheme", isLightTheme);
    await prefs.setString("selectedLanguage", selectedLanguage ?? "");
    await prefs.setString("selectedCurrency", selectedCurrency ?? "");
    await prefs.setBool("orderUpdates", orderUpdates);
    await prefs.setBool("exclusiveDeals", exclusiveDeals);
    await prefs.setBool("wishlistAlerts", wishlistAlerts);
    await prefs.setBool("newArrivals", newArrivals);
    await prefs.setBool("securityAlerts", securityAlerts);
  }

  // Load Preferences
  Future<void> loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isLightTheme = prefs.getBool("isLightTheme") ?? false;
      selectedLanguage = prefs.getString("selectedLanguage") ?? null;
      selectedCurrency = prefs.getString("selectedCurrency") ?? null;
      orderUpdates = prefs.getBool("orderUpdates") ?? true;
      exclusiveDeals = prefs.getBool("exclusiveDeals") ?? true;
      wishlistAlerts = prefs.getBool("wishlistAlerts") ?? true;
      newArrivals = prefs.getBool("newArrivals") ?? true;
      securityAlerts = prefs.getBool("securityAlerts") ?? true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text("App Preferences", style: TextStyle(color: Colors.black)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {},
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Theme Toggle
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Theme", style: TextStyle(color: Colors.white, fontSize: 16)),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isLightTheme = !isLightTheme;
                    });
                    savePreferences();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: isLightTheme ? Colors.blue : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      isLightTheme ? "Light" : "Dark",
                      style: TextStyle(color: isLightTheme ? Colors.white : Colors.black),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),

            // Language Dropdown
            Text("Language", style: TextStyle(color: Colors.white, fontSize: 16)),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(),
              ),
              dropdownColor: Colors.white,
              hint: Text("Select language"),
              value: selectedLanguage,
              onChanged: (value) {
                setState(() {
                  selectedLanguage = value;
                });
                savePreferences();
              },
              items: ["English", "Spanish", "French", "German"]
                  .map((lang) => DropdownMenuItem(value: lang, child: Text(lang)))
                  .toList(),
            ),
            SizedBox(height: 20),

            // Currency Dropdown
            Text("Currency", style: TextStyle(color: Colors.white, fontSize: 16)),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(),
              ),
              dropdownColor: Colors.white,
              hint: Text("Select currency"),
              value: selectedCurrency,
              onChanged: (value) {
                setState(() {
                  selectedCurrency = value;
                });
                savePreferences();
              },
              items: ["USD", "EUR", "INR", "GBP"]
                  .map((currency) => DropdownMenuItem(value: currency, child: Text(currency)))
                  .toList(),
            ),
            SizedBox(height: 20),

            // Notification Preferences
            Text("Notification", style: TextStyle(color: Colors.white, fontSize: 16)),
            _buildSwitchTile("Order Updates", orderUpdates, (value) {
              setState(() {
                orderUpdates = value;
              });
              savePreferences();
            }),
            _buildSwitchTile("Exclusive Deals & Offers", exclusiveDeals, (value) {
              setState(() {
                exclusiveDeals = value;
              });
              savePreferences();
            }),
            _buildSwitchTile("Wishlist Alerts", wishlistAlerts, (value) {
              setState(() {
                wishlistAlerts = value;
              });
              savePreferences();
            }),
            _buildSwitchTile("New Arrivals", newArrivals, (value) {
              setState(() {
                newArrivals = value;
              });
              savePreferences();
            }),
            _buildSwitchTile("Security Alerts", securityAlerts, (value) {
              setState(() {
                securityAlerts = value;
              });
              savePreferences();
            }),
          ],
        ),
      ),
    );
  }

  // Helper Widget for Switch Buttons
  Widget _buildSwitchTile(String title, bool value, Function(bool) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(color: Colors.white, fontSize: 14)),
          Switch(
            value: value,
            activeColor: Colors.blue,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
