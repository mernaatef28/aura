import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/cartSkinCare/cartLogic.dart';
import '../bloc/cartSkinCare/cartState.dart';
import 'checkoutpage.dart';
import 'package:aura/localVariables/local_variables.dart';
import 'package:aura/localVariables/styles.dart';
import 'package:aura/localVariables/classes/product.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  final CollectionReference cartCollection = FirebaseFirestore.instance.collection('cart');

  // Method to add product to Firebase Firestore cart collection
  Future<void> addProductToCart(Product product) async {
    try {
      await cartCollection.add({
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

  // Method to delete product from Firebase Firestore
  Future<void> deleteProductFromCart(String documentId) async {
    try {
      await cartCollection.doc(documentId).delete();
      print("Product deleted from cart");
    } catch (e) {
      print("Error deleting product from cart: $e");
    }
  }

  // Handle Checkout: Add all products to Firebase
  Future<void> handleCheckout() async {
    for (Product product in products) {
      await addProductToCart(product);
    }
    print("All products added to cart for checkout.");
    // Navigate to CheckoutPage
    Navigator.push(context, MaterialPageRoute(builder: (context) => CheckoutPage()));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => Cartlogic(),
      child: BlocConsumer<Cartlogic, Cartstate>(
        listener: (context, state) {},
        builder: (context, state) {
          Cartlogic obj = BlocProvider.of(context);

          return Scaffold(
            appBar: AppBar(
              elevation: 1,
              title: Text(
                'Shopping cart',
                style: TextStyle(
                  fontSize: 30,
                  color: firozi,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
              leading: Icon(
                Icons.arrow_back,
                color: Color(0xFF51858C),
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    for (int i = 0; i < products.length; i++)
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: babyGray,
                          ),
                          padding: EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Container(
                                width: 80.0,
                                height: 80.0,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(products[i].imageUrl),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      products[i].productName,
                                      style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Center(
                                      child: Text(
                                        products[i].price.toString(),
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Row(
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            obj.mcart();
                                          },
                                          icon: Icon(Icons.remove),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                          child: Text(
                                            '${obj.i}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            obj.pcart();
                                          },
                                          icon: Icon(Icons.add),
                                        ),
                                      ],
                                    ),

                                    MaterialButton(
                                      onPressed: () async {
                                        // Assuming you have a way to store the document ID
                                        String documentId = 'some-document-id'; // Replace with actual ID
                                        await deleteProductFromCart(documentId);
                                      },
                                      minWidth: 2,
                                      height: 10,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      color: babyRose,
                                      child: Row(
                                        children: [
                                          IconButton(
                                            onPressed: () {},
                                            icon: Icon(Icons.delete_outline, size: 30),
                                          ),
                                          Text(
                                            'Delete',
                                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Divider(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total',
                            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '\$ 480.00',
                            style: TextStyle(fontSize: 30),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Delivery charge',
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          '\$ 40.00',
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'SubTotal',
                            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '\$ 520.00',
                            style: TextStyle(fontSize: 30),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {
                        handleCheckout(); // Handle checkout action
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: firozi,
                      ),
                      child: Center(
                        child: Text(
                          'Checkout',
                          style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
