import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Firestore Categories Setup')),
        body: CategoriesSetup(),
      ),
    );
  }
}

class CategoriesSetup extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createCategoriesCollection() async {
    // Define the categories and their images
    final categories = {
      'AuraBeige': 'https://github.com/mernaatef28/aura/blob/main/assets/pictures/19.png?raw=true',
      'Aurafirozi': 'https://github.com/mernaatef28/aura/blob/main/assets/pictures/18.png?raw=true',
      'Auralabini': 'https://github.com/mernaatef28/aura/blob/main/assets/pictures/17.png?raw=true',
      'Aurapambi': 'https://github.com/mernaatef28/aura/blob/main/assets/pictures/13.png?raw=true',
      'Aurayellow': 'https://github.com/mernaatef28/aura/blob/main/assets/pictures/18(1).png?raw=true',
    };

    // Add each category to the Firestore collection
    for (var entry in categories.entries) {
      await _firestore.collection('categories').doc(entry.key).set({
        'imageUrl': entry.value,
      }).then((_) {
        print('Category ${entry.key} added successfully.');
      }).catchError((error) {
        print('Failed to add category ${entry.key}: $error');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: createCategoriesCollection,
        child: Text('Create Categories Collection'),
      ),
    );
  }
}
