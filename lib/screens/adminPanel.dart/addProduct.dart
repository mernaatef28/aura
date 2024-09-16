import 'package:aura/localVariables/local_variables.dart';
import 'package:aura/widgets/btn.dart';
import 'package:flutter/material.dart';
import 'package:aura/localVariables/styles.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aura/widgets/addProductCard.dart';
import '../../bloc/cartSkinCare/cartLogic.dart';
import '../../bloc/cartSkinCare/cartState.dart';
import '../../widgets/textFormFeild_Widget.dart';
// Import the firebase_core and cloud_firestore plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class addProduct extends StatelessWidget {
  final TextEditingController priceController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController imageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // Create a CollectionReference called users that references the firestore collection
    CollectionReference products = FirebaseFirestore.instance.collection('products');

    Future<void> addProduct() {
      // Call the user's CollectionReference to add a new user
      return products
          .add({
        'ProductName': nameController.text, // John Doe
        'CategoryName': categoryController.text, // Stokes and Sons
        'price': priceController.hashCode ,// 42
        'ImageUrl': imageController.text // 42
      })
          .then((value) => print("product Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }

    return BlocProvider(
      create: (context) => Cartlogic(),
      child: BlocConsumer<Cartlogic, Cartstate>(
        listener: (context, state) {},
        builder: (context, state) {
          Cartlogic obj = BlocProvider.of(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(
                "product add",
                style: auraFontFayrozi30,
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("product list", style: aurabold28),
                    for (int i = 0; i < productLists2.length; i++)
                      AddProductCard(
                        addProductCategory: productLists2[i].categoryName,
                        addProductImageAssets: productLists2[i].imageUrl,
                        editPagePush: () {},
                        addproductName: productLists2[i].productName,
                      ),

                    // add new product to the list
                    Text("add new ", style: aurabold28),

                    TextformfeildWidget(Controller: nameController, feildName: 'ProductName', icon: Icon(Icons.drive_file_rename_outline),) ,
                    TextformfeildWidget(Controller: categoryController, feildName: 'CategoryName', icon: Icon(Icons.account_balance_wallet),) ,
                    TextformfeildWidget(Controller: priceController, feildName: "price", icon: Icon(Icons.monetization_on),) ,
                    TextformfeildWidget(Controller: imageController, feildName: "ImageUrl", icon: Icon(Icons.image)) ,
                    Center(child: btnCal(text: "Add Product", c: firozi, event:  addProduct , textColor: Colors.white)),

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
