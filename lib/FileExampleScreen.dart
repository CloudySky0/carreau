import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class FileExamplesScreen extends StatefulWidget {
  const FileExamplesScreen({super.key});

  @override
  _FileExamplesScreenState createState() => _FileExamplesScreenState();
}

class _FileExamplesScreenState extends State<FileExamplesScreen> {
  List<dynamic> diamonds = [];

  @override
  void initState() {
    super.initState();
    loadDiamonds();
  }

  Future<void> loadDiamonds() async {
    final String response = await rootBundle.loadString('assets/examples/example.json');
    final data = json.decode(response);
    setState(() {
      diamonds = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Diamond Examples")),
      body: diamonds.isEmpty
          ? Center(child: CircularProgressIndicator()) // Show loader while fetching data
          : ListView.builder(
              itemCount: diamonds.length,
              itemBuilder: (context, index) {
                final diamond = diamonds[index];
                return Card(
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    leading: Image.asset(
                      diamond["imageUrl"],
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(diamond["name"]),
                    subtitle: Text("Category: ${diamond["category"]}"),
                    trailing: Text("\$${diamond["price"]}"),
                  ),
                );
              },
            ),
    );
  }
}
