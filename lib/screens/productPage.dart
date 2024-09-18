import 'package:aura/localVariables/classes/product.dart';
import 'package:aura/widgets/recommendedProducts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_product_card/flutter_product_card.dart';
import '../localVariables/local_variables.dart';
import 'cart.dart';
import 'package:aura/localVariables/styles.dart';
import 'package:aura/localVariables/local_variables.dart';

class produactDetailspage extends StatelessWidget {
  late Image imageUrl;

  late String categoryName, productName;

  late double price;

  late String productDetails;

  void addProductToCart(String productName) async {
    try {
      print("Searching for product: $productName");

      // Fetch product details from Firebase using the productName
      var productSnapshot = await FirebaseFirestore.instance
          .collection('products')
          .where('productName', isEqualTo: "SoftMist Toner")
          .get();

      if (productSnapshot.docs.isNotEmpty) {
        var productData = productSnapshot.docs.first.data();
        print("Product data: $productData");

        // Add the product to the 'cart' collection
        await FirebaseFirestore.instance.collection('cart').add({
          'productName': productData['productName'],
          'price': productData['price'],
          'imageUrl': productData['imageUrl'],
          'categoryName': productData['categoryName'],
          'shortDescription': productData['shortDescription'],
          'rating': productData['rating'],
          'discountPercentage': productData['discountPercentage'],
          'isAvailable': productData['isAvailable'],
        });

        print("Product added to cart");
      } else {
        print("Product not found in Firebase");
      }
    } catch (e) {
      print("Error adding product to cart: $e");
    }
  }




  produactDetailspage(
      {required this.imageUrl,
      required this.productName,
      required this.categoryName,
      required this.price,
      this.productDetails =
          "Our Gentle Purifying Cleanser is designed to deeply cleanse your skin while maintaining its natural balance. Formulated with nourishing ingredients, this cleanser effectively removes makeup, dirt, and excess oil, leaving your skin feeling fresh, clean, and revitalized."});

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
                        child: Image.asset("assets/pictures/6.png")),
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
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
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    hintText: "what are you looking for ?",
                    hintStyle: TextStyle(color: Colors.white),
                    filled: true,
                    fillColor: babyGray.withOpacity(0.8),
                  )),
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
            ]),
        body: ListView(children: [
          Container(width: 300, height: 300, child: imageUrl),
          Container(
            padding: EdgeInsets.all(15),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productName,
                    style: auraFontFayrozi30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        categoryName,
                        style: aurasmallgrey20,
                      ),
                      Text(
                        "${price.toString()}\$",
                        style: auraFontbold20,
                      ),
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    height: 30,
                    child: MaterialButton(
                      onPressed: () {
                        addProductToCart(productName); // Call the method with product name
                      },
                      child: Icon(Icons.add_shopping_cart_outlined),
                      color: firozi,
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      productDetails,
                      style: auraFont20,
                    ),
                  ),
                  recommendedProducts(context),
                ]),
          ),
        ]));
  }
}
