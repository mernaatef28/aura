import 'package:aura/localVariables/local_variables.dart';
import 'package:aura/screens/CategoryDisplay.dart';
import 'package:aura/screens/cart.dart';
import 'package:aura/widgets/productListDisplay.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:aura/localVariables/styles.dart';

import '../widgets/recommendedProducts.dart';

class ProductHomePage extends StatefulWidget {
  @override
  State<ProductHomePage> createState() => _ProductHomePageState();
}

class _ProductHomePageState extends State<ProductHomePage> {
  final CollectionReference categoriesCollection = FirebaseFirestore.instance.collection('categories');
  int currentIndex = 0; // Assuming there's a variable for carousel index

  @override
  Widget build(BuildContext context) {
    var controller = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.only(right: 0.8, top: 0.8),
                child: Container(
                    width: 150,
                    height: 150,
                    child: Image.asset("assets/pictures/6.png")),
              ),
            ),
            SizedBox(width: 50),
            Expanded(
              flex: 2,
              child: TextFormField(
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                    color: firozi,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: babyGray,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: firozi,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  hintText: "What are you looking for?",
                  hintStyle: TextStyle(color: Colors.white),
                  filled: true,
                  fillColor: babyGray.withOpacity(0.8),
                ),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.shopping_cart,
              size: 40,
              color: firozi,
            ),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Cart()));
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 30.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselSlider(
                items: mySlides,
                options: CarouselOptions(
                  autoPlay: true,
                  height: 200,
                  onPageChanged: (index, reason) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
                child: Text(
                  "Categories",
                  style: auraFontFayrozi30,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
                child: StreamBuilder<QuerySnapshot>(
                  stream: categoriesCollection.snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return Center(child: Text('Error loading categories'));
                    }

                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return Center(child: Text('No categories found'));
                    }

                    List<QueryDocumentSnapshot> categories = snapshot.data!.docs;

                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: categories.map((categoryDoc) {
                          // Get document ID as categoryName (because the document ID is the category name)
                          String categoryName = categoryDoc.id;
                          // Get image URL from the 'imageUrl' field
                          String imageUrl = categoryDoc['imageUrl'];

                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                InkWell(
                                  child: CircleAvatar(
                                    backgroundImage: NetworkImage(imageUrl),
                                    radius: 40,
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Categorydisplay(
                                          categoryName: categoryName,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                Text(
                                  categoryName,
                                  style: TextStyle(
                                    color: firozi,
                                    fontSize: 17,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
                child: Text(
                  "Recommended for you",
                  style: auraFontFayrozi30,
                ),
              ),
              recommendedProducts(context), // Your existing recommendation widget
            ],
          ),
        ),
      ),
    );
  }
}
