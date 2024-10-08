import 'package:aura/localVariables/classes/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_product_card/flutter_product_card.dart';
import '../localVariables/local_variables.dart';
import '../screens/productPage.dart';
import 'package:flutter/cupertino.dart';

class Productlistdisplay extends StatelessWidget {
  final String launchLine; // This allows us to filter by LaunchingLine

  Productlistdisplay({required this.launchLine});

  // Method to add a product to the cart
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
    CollectionReference productsCollection = FirebaseFirestore.instance.collection('products');

    return StreamBuilder<QuerySnapshot>(
      stream: productsCollection.where('LaunchingLine', isEqualTo: launchLine).snapshots(), // Stream for real-time updates
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator()); // Show loading indicator
        }
        if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text("No products found for this launch line"));
        }

        // Retrieve product data from snapshot
        final products = snapshot.data!.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();

        return GridView.builder(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 0.5,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];

            // Safely parse and handle potential conversion issues
            double parseToDouble(dynamic value) {
              if (value is String) {
                return double.tryParse(value) ?? 0.0;
              } else if (value is double) {
                return value;
              } else if (value is int) {
                return value.toDouble();
              }
              return 0.0;
            }

            double price = parseToDouble(product['price']);
            double rating = parseToDouble(product['rating']);
            double discountPercentage = parseToDouble(product['discount']);

            Product productObject = Product(
              productName: product['ProductName'],
              price: price,
              imageUrl: product['ImageUrl'],
              categoryName: product['CategoryName'],
              shortDescription: product['ProductShortDescription'],
              ProductDetailsDescription: product['ProductDetailsDescription'],
              rating: rating,
              discountPercentage: discountPercentage,
              isAvailable: true,
            );

            return SingleChildScrollView(
              child: Column(
                children: [
                  ProductCard(
                    imageUrl: product['ImageUrl'],
                    categoryName: product['CategoryName'],
                    productName: product['ProductName'],
                    price: price,
                    shortDescription: product['ProductShortDescription'],
                    rating: rating,
                    discountPercentage: discountPercentage,
                    isAvailable: true,
                    cardColor: Colors.white,
                    textColor: Colors.black,
                    borderRadius: 8.0,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailsPage(product: productObject, )
                        ),
                      );
                    },
                    onFavoritePressed: () {
                      // Handle favorite button pressed
                    },
                  ),
                  Container(
                    width: double.infinity,
                    height: 30,
                    child: MaterialButton(
                      onPressed: () {
                        addProductToCart(productObject); // Call the method to add product to cart
                      },
                      child: Icon(Icons.add_shopping_cart_outlined),
                      color: firozi,
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}