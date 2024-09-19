import 'package:aura/localVariables/classes/product.dart';
import 'package:aura/widgets/recommendedProducts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_product_card/flutter_product_card.dart';
import '../localVariables/local_variables.dart';
import 'cart.dart';
import 'package:aura/localVariables/styles.dart';
import 'package:aura/localVariables/local_variables.dart';

class ProductDetailsPage extends StatelessWidget {
  final Product product;

  // Pass the Product object via constructor
  ProductDetailsPage({required this.product});

  // Add the product to the cart using the passed Product object
  void addProductToCart(Product product) async {
    try {
      await FirebaseFirestore.instance.collection('cart').add({
        'productName': product.productName,
        'price': product.price,
        'imageUrl': product.imageUrl,
        'categoryName': product.categoryName,
        'shortDescription': product.shortDescription,
        'rating': product.rating,
        'discountPercentage': product.discountPercentage,
        'isAvailable': product.isAvailable,
      });

      print("Product added to cart");
    } catch (e) {
      print("Error adding product to cart: $e");
    }
  }

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
        ],
      ),
      body: ListView(
        children: [
          Container(width: 300, height: 300, child: Image.network(product.imageUrl)),
          Container(
            padding: EdgeInsets.all(15),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.productName,
                    style: auraFontFayrozi30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        product.categoryName,
                        style: aurasmallgrey20,
                      ),
                      Text(
                        "${product.price.toString()}\$",
                        style: auraFontbold20,
                      ),
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    height: 30,
                    child: MaterialButton(
                      onPressed: () {
                        addProductToCart(product); // Use the product object directly to add to cart
                      },
                      child: Icon(Icons.add_shopping_cart_outlined),
                      color: firozi,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      product.ProductDetailsDescription,
                      style: auraFont20,
                    ),
                  ),
                  recommendedProducts(context),
                ]),
          ),
        ],
      ),
    );
  }
}
