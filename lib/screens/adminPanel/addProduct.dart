
import 'package:aura/screens/adminPanel/updateProduct.dart';
import 'package:aura/widgets/btn.dart';
import 'package:flutter/material.dart';
import 'package:aura/localVariables/styles.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aura/widgets/addProductCard.dart';
import '../../bloc/cartSkinCare/cartLogic.dart';
import '../../bloc/cartSkinCare/cartState.dart';
import '../../localVariables/local_variables.dart';
import '../../widgets/textFormFeild_Widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class AddProduct extends StatelessWidget {
  final TextEditingController priceController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController imageController = TextEditingController();
  final TextEditingController shortDescriptionController = TextEditingController();
  final TextEditingController detailsDescriptionController = TextEditingController();
  final TextEditingController launchingLineController = TextEditingController(); // New Controller

  @override
  Widget build(BuildContext context) {
    CollectionReference products = FirebaseFirestore.instance.collection('products');

    Future<void> addProduct() async {
      if (nameController.text.isNotEmpty &&
          categoryController.text.isNotEmpty &&
          priceController.text.isNotEmpty &&
          imageController.text.isNotEmpty &&
          shortDescriptionController.text.isNotEmpty &&
          detailsDescriptionController.text.isNotEmpty &&
          launchingLineController.text.isNotEmpty) {
        try {
          await products.add({
            'ProductName': nameController.text,
            'CategoryName': categoryController.text,
            'price': priceController.text,
            'ImageUrl': imageController.text,
            'ProductShortDescription': shortDescriptionController.text,
            'ProductDetailsDescription': detailsDescriptionController.text,
            'LaunchingLine': launchingLineController.text,
          });
          print("Product Added");

          // Clear the text fields
          nameController.clear();
          categoryController.clear();
          priceController.clear();
          imageController.clear();
          shortDescriptionController.clear();
          detailsDescriptionController.clear();
          launchingLineController.clear();
        } catch (error) {
          print("Failed to add product: $error");
        }
      } else {
        print("Please fill in all fields");
      }
    }

    return BlocProvider(
      create: (context) => Cartlogic(),
      child: BlocConsumer<Cartlogic, Cartstate>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                "Add Product",
                style: auraFontFayrozi30,
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Product List", style: aurabold28),

                    // Fetching and displaying products from Firebase
                    StreamBuilder<QuerySnapshot>(
                      stream: products.snapshots(),
                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Text("Something went wrong");
                        }

                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        }

                        return Container(
                          height: 600.0, // Set a fixed height for the ListView
                          child: ListView(
                            children: snapshot.data!.docs.map((DocumentSnapshot document) {
                              Map<String, dynamic>? data = document.data() as Map<String, dynamic>?; // Handle null values
                              if (data == null) {
                                return ListTile(
                                  title: Text("Error: Data is null"),
                                );
                              }

                              String docId = document.id; // Get the document ID

                              return AddProductCard(
                                addProductCategory: data['CategoryName'] ?? 'Unknown Category', // Default value
                                addProductImageAssets: data['ImageUrl'] ?? 'No Image URL',      // Default value
                                addproductName: data['ProductName'] ?? 'Unnamed Product',       // Default value
                                editPagePush: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EditProductPage(productName: data['ProductName'] ?? 'Unnamed Product'), // Pass product name
                                    ),
                                  );
                                },

                                deleteProduct: (String documentId) async {
                                  await products.doc(documentId).delete().then((_) {
                                    print("Product deleted");
                                  }).catchError((error) {
                                    print("Failed to delete product: $error");
                                  });
                                },
                                documentId: docId, // Pass the document ID
                              );
                            }).toList(),
                          ),
                        );
                      },
                    ),

                    Text("Add New", style: aurabold28),

                    TextformfeildWidget(
                      Controller: nameController,
                      feildName: 'ProductName',
                      icon: Icon(Icons.drive_file_rename_outline),
                    ),
                    TextformfeildWidget(
                      Controller: categoryController,
                      feildName: 'CategoryName',
                      icon: Icon(Icons.account_balance_wallet),
                    ),
                    TextformfeildWidget(
                      Controller: priceController,
                      feildName: "Price",
                      icon: Icon(Icons.monetization_on),
                    ),
                    TextformfeildWidget(
                      Controller: imageController,
                      feildName: "ImageUrl",
                      icon: Icon(Icons.image),
                    ),
                    TextformfeildWidget(
                      Controller: shortDescriptionController,
                      feildName: "Short Description",
                      icon: Icon(Icons.description),
                    ),
                    TextformfeildWidget(
                      Controller: detailsDescriptionController,
                      feildName: "Details Description",
                      icon: Icon(Icons.description_outlined),
                    ),
                    TextformfeildWidget(
                      Controller: launchingLineController,
                      feildName: "Launching Line",
                      icon: Icon(Icons.label),
                    ),
                    Center(
                      child: btnCal(
                        text: "Add Product",
                        c: firozi,
                        event: addProduct,
                        textColor: Colors.white,
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
