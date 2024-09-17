import 'package:aura/localVariables/styles.dart';
import 'package:aura/widgets/productListDisplay.dart';
import 'package:flutter/material.dart';
import '../localVariables/local_variables.dart';
import 'cart.dart';

class Categorydisplay extends StatelessWidget {
  final String categoryName;

  Categorydisplay({required this.categoryName});

  @override
  Widget build(BuildContext context) {
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
                  child: Image.asset("assets/pictures/6.png"),
                ),
              ),
            ),
            SizedBox(width: 50),
            Expanded(
              flex: 2,
              child: TextFormField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search, color: firozi),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: babyGray, width: 2.0),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: firozi, width: 2.0),
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
            icon: Icon(Icons.shopping_cart, size: 40, color: firozi),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Cart()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                categoryName,
                style: auraFontFayrozi40,
              ),
            ),
            Productlistdisplay(launchLine: categoryName),
          ],
        ),
      ),
    );
  }
}
