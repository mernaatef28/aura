import 'package:aura/screens/productPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_product_card/flutter_product_card.dart';
import '../localVariables/local_variables.dart';

Widget recommendedProducts(BuildContext context) => SingleChildScrollView(
  scrollDirection: Axis.horizontal,
  child: Row(
    children: [
      for (int index = 0; index < products.length; index++)
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: 200,
            child: ProductCard(
              imageUrl: products[index].imageUrl, // Make sure you're using the correct list
              categoryName: products[index].categoryName,
              productName: products[index].productName,
              price: products[index].price,
              shortDescription: products[index].shortDescription,
              rating: products[index].rating,
              discountPercentage: products[index].discountPercentage,
              isAvailable: products[index].isAvailable,
              cardColor: Colors.white,
              textColor: Colors.black,
              borderRadius: 8.0,
              onTap: () {
                // Handle product tap
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => produactDetailspage(imageUrl:Image.network( products[index].imageUrl), productName:  products[index].productName, categoryName: products[index].categoryName, price: products[index].price , ) ,
                  ),
                );
              },
              onFavoritePressed: () {
                // Handle favorite button pressed
              },
            ),
          ),
        ),
    ],
  ),
);
