import 'package:aura/localVariables/classes/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_product_card/flutter_product_card.dart';

import '../localVariables/local_variables.dart';
import '../screens/productPage.dart';

class Productlistdisplay extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true, // Allows GridView to take the minimum space
      physics: ScrollPhysics(), // Disables GridView's scrolling
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 0.55,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return ProductCard(
          imageUrl: products[index].imageUrl,
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
                builder: (context) => produactDetailspage(imageUrl: Image.asset('assets/pictures/14.png'), productName: 'Gentle Purifying Cleanser', categoryName: 'FaceCare', price: 40.4 , ) ,
              ),
            );
          },
          onFavoritePressed: () {
// Handle favorite button pressed
          },
        );
      },
    );
  }
}
