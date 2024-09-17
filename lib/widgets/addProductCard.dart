import 'package:flutter/material.dart';

import '../localVariables/local_variables.dart';
import 'package:aura/localVariables/styles.dart';

class AddProductCard extends StatelessWidget {
  late String addProductImageAssets, addproductName, addProductCategory;

  late Function editPagePush;

  AddProductCard({
    required this.addProductCategory,
    required this.addproductName,
    required this.addProductImageAssets,
    required this.editPagePush,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.grey[100],
            ),
            padding: EdgeInsets.all(16),
            child:Row(
              children: [
                // Fix Container width and height
                Container(
                  width: 100.0,
                  height: 100.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(addProductImageAssets),
                    ),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(addproductName,
                          // name of product that is passed by the widget requires
                          style: aurabold25),
                      Text(addProductCategory,
                          //name of category  that is passed by the widget requires
                          style: auraFontboldgray15),
                      SizedBox(height: 8),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            MaterialButton(
                              onPressed: (){} ,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              color: firozi,
                              child: Icon(
                                Icons.edit,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            MaterialButton(
                              onPressed: () async {
                                //delete action needed from firebase
                                // needed to be in the provider cubit
                                /*
                                  await udb.deleteData(id: udb.users[i]["id"]) ;
                                  setState(() {

                                  });*/
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              color: babyRose,
                              child: Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )));
  }
}
