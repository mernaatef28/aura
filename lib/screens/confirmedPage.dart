import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ConfirmPage extends StatefulWidget {
  @override
  State<ConfirmPage> createState() => _ConfirmPageState();
  CollectionReference users = FirebaseFirestore.instance.collection('checkout');
}

class _ConfirmPageState extends State<ConfirmPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Confirmation"),
        backgroundColor: Color(0xfff6CAC9), // Match your theme color
      ),
      body: Stack(
        children: [
          // Background Image with Opacity
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/pictures/20.jpg"), // Make sure this image is in your assets folder and properly listed in pubspec.yaml
                fit: BoxFit.cover, // Adjust the image to cover the entire screen
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.5), // Adjust opacity here (0.0 - 1.0)
                  BlendMode.darken, // Blend mode to apply transparency
                ),
              ),
            ),
          ),

          // Foreground Content
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.shopping_bag_outlined,
                  size: 100,
                  color: Color(0xfff6CAC9), // Match your theme color
                ),
                SizedBox(height: 20),
                Text(
                  "Thank You!",
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "A confirmation has been sent to your phone message. "
                      "Since you're here, join our list for discounts!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 30),
                MaterialButton(
                  onPressed: () {
                    // Add action for button press
                  },
                  color: Color(0xfff6CAC9),
                  child: Text(
                    "Go to Home Page",
                    style: TextStyle(fontSize: 18, color: Colors.black87),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
