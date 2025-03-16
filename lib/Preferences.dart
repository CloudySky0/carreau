import 'package:diamond_app/template.dart';
import 'package:flutter/material.dart';

class PreferencesScreen extends StatefulWidget {
  const PreferencesScreen({super.key});

  @override
  _PreferencesScreenState createState() => _PreferencesScreenState();
}

class _PreferencesScreenState extends State<PreferencesScreen> {
  double priceRange = 1000000; // Default price range
  final List<bool> _selectedJewelryTypes = List.generate(6, (index) => false); // Jewelry type selection
  final List<bool> _selectedMaterials = List.generate(5, (index) => false); // Material selection

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              "assets/images/s1.png",
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "PREFERENCES",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Spill the Sparkle! Tell us your bling vibe & let's match you with the perfect jewels",
                    style: TextStyle(fontSize: 14, color: Colors.white70),
                  ),
                  SizedBox(height: 20),
                  
                  // Jewelry Type Selection
                  Text("Select Jewelry Type", style: sectionTitleStyle()),
                  Text("(Tap to select)", style: subTextStyle()),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _buildSelectableChips([
                      "Rings", "Necklaces", "Earrings", "Bracelets", "Anklets", "Others"
                    ], _selectedJewelryTypes),
                  ),
                  SizedBox(height: 20),
                  
                  // Material Selection
                  Text("Choose Material", style: sectionTitleStyle()),
                  Text("(Tap to select)", style: subTextStyle()),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _buildSelectableChips([
                      "Gold", "Diamonds", "Platinum", "Silver", "CVDs"
                    ], _selectedMaterials),
                  ),
                  SizedBox(height: 20),

                  // Price Range Slider
                  Text("Price Range", style: sectionTitleStyle()),
                  Text("(Adjustable Slider)", style: subTextStyle()),
                  Slider(
                    value: priceRange,
                    min: 0,
                    max: 100000000,
                    divisions: 20,
                    label: "Rs ${priceRange.toInt()}",
                    onChanged: (value) {
                      setState(() {
                        priceRange = value;
                      });
                    },
                  ),
                  
                  SizedBox(height: 30),
                  
                  // Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildButton("Save preferences", Colors.blue),
                      SizedBox(width: 10),
                      _buildButton("Skip", Colors.blue),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  TextStyle sectionTitleStyle() {
    return TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white);
  }

  TextStyle subTextStyle() {
    return TextStyle(fontSize: 14, color: Colors.white70);
  }

  List<Widget> _buildSelectableChips(List<String> options, List<bool> selectedList) {
    return options.asMap().map((index, option) {
      return MapEntry(
        index,
        ChoiceChip(
          label: Text(option),
          selected: selectedList[index], // Use the selected state from the list
          onSelected: (selected) {
            setState(() {
              selectedList[index] = selected; // Update the selection state
            });
          },
          backgroundColor: Colors.white24,
          selectedColor: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          labelStyle: TextStyle(color: Colors.black),
        ),
      );
    }).values.toList();
  }

  Widget _buildButton(String text, Color color) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => Template()),);
                print("Button Pressed!");
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
      ),
      child: Text(text, style: TextStyle(fontSize: 16, color: Colors.white)),
    );
  }
}
