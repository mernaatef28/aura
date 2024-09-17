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
  final CollectionReference orderCollection = FirebaseFirestore.instance.collection('orders');

  List<Map<String, dynamic>> cartProducts = []; // List to store products with their document IDs

  @override
  void initState() {
    super.initState();
    fetchCartProducts(); // Fetch products when cart page is loaded
  }

  // Method to fetch products from Firestore 'cart' collection
  Future<void> fetchCartProducts() async {
    try {
      QuerySnapshot cartSnapshot = await cartCollection.get();
      List<Map<String, dynamic>> fetchedProducts = [];

      for (QueryDocumentSnapshot doc in cartSnapshot.docs) {
        Product product = Product(
          productName: doc['productName'],
          price: doc['price'],
          imageUrl: doc['imageUrl'],
          categoryName: doc['categoryName'],
          shortDescription: doc['shortDescription'],
          rating: doc['rating'],
          discountPercentage: doc['discountPercentage'],
          isAvailable: doc['isAvailable'],
        );

        fetchedProducts.add({
          'product': product,
          'documentId': doc.id, // Store the document ID along with the product
          'quantity': 1 , // Default to 1 if quantity is not set
        });
      }

      setState(() {
        cartProducts = fetchedProducts;
      });

      print("Products fetched from cart collection");
    } catch (e) {
      print("Error fetching products from cart collection: $e");
    }
  }

  // Method to delete product from Firestore cart collection
  Future<void> deleteProductFromCart(String documentId) async {
    try {
      await cartCollection.doc(documentId).delete();
      print("Product deleted from cart");
      fetchCartProducts(); // Refresh cart after deletion
    } catch (e) {
      print("Error deleting product from cart: $e");
    }
  }

  // Method to update quantity in Firestore cart collection
  Future<void> updateQuantity(String documentId, int newQuantity) async {
    try {
      await cartCollection.doc(documentId).update({'quantity': newQuantity});
      print("Product quantity updated");
      fetchCartProducts(); // Refresh cart after updating quantity
    } catch (e) {
      print("Error updating product quantity: $e");
    }
  }

  // Handle Checkout: Transfer products to 'orders' and clear 'cart'
  Future<void> handleCheckout() async {
    try {
      // Transfer each product from 'cart' to 'orders'
      for (Map<String, dynamic> item in cartProducts) {
        Product product = item['product'];
        int quantity = item['quantity'] ?? 1; // Default to 1 if quantity is not set

        await orderCollection.add({
          'productName': product.productName,
          'price': product.price,
          'imageUrl': product.imageUrl,
          'categoryName': product.categoryName,
          'shortDescription': product.shortDescription,
          'rating': product.rating,
          'discountPercentage': product.discountPercentage,
          'isAvailable': product.isAvailable,
          'quantity': quantity, // Send quantity to orders collection
        });
      }

      // Clear the 'cart' collection
      QuerySnapshot cartSnapshot = await cartCollection.get();
      for (QueryDocumentSnapshot doc in cartSnapshot.docs) {
        await cartCollection.doc(doc.id).delete();
      }

      print("Products moved to orders and cart cleared");

      // Navigate to CheckoutPage
      Navigator.push(context, MaterialPageRoute(builder: (context) => CheckoutPage()));
    } catch (e) {
      print("Error during checkout: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => Cartlogic(),
      child: BlocConsumer<Cartlogic, Cartstate>(
        listener: (context, state) {},
        builder: (context, state) {
          Cartlogic obj = BlocProvider.of(context);

          // Calculate the total dynamically
          double total = 0;
          for (var item in cartProducts) {
            double productPrice = item['product'].price;
            int quantity = item['quantity'] ?? 1; // Default to 1 if quantity is not set
            total += productPrice * quantity;
          }

          return Scaffold(
            appBar: AppBar(
              elevation: 1,
              title: Text('Shopping cart', style: auraFontFayrozi30),
              centerTitle: true,
            ),
            body: cartProducts.isEmpty
                ? Center(
              child: Text(
                'Your cart is empty',
                style: aurabold25,
              ),
            )
                : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    for (int i = 0; i < cartProducts.length; i++)
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
                                    image: NetworkImage(cartProducts[i]['product'].imageUrl),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      cartProducts[i]['product'].productName,
                                      style: aurabold25,
                                    ),
                                    Text(
                                      '\$${cartProducts[i]['product'].price}',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      'Qty: ${cartProducts[i]['quantity']}',
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    MaterialButton(
                                      onPressed: () async {
                                        String documentId = cartProducts[i]['documentId'];
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
                                          Text('Delete', style: auraFontbold20),
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
                          Text('Total', style: auraFontbold30),
                          Text('\$${total.toStringAsFixed(2)}', // Use actual total calculation
                              style: TextStyle(fontSize: 30)),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Delivery charge', style: TextStyle(fontSize: 20)),
                        Text('\$40.00', // Use actual delivery charge value
                            style: TextStyle(fontSize: 20)),
                      ],
                    ),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('SubTotal', style: auraFontbold30),
                          Text('\$${(total + 40).toStringAsFixed(2)}', // Subtotal calculation including delivery charge
                              style: TextStyle(fontSize: 30)),
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
                        child: Text('Checkout', style: checkoutStyle),
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
