import 'package:flutter/material.dart';
import '../localVariables/local_variables.dart';
import 'package:aura/localVariables/styles.dart';

class AddProductCard extends StatelessWidget {
  final String addProductImageAssets;
  final String addproductName;
  final String addProductCategory;
  final VoidCallback editPagePush;
  final Function(String) deleteProduct; // Function to delete with document ID
  final String documentId; // Document ID

  AddProductCard({
    required this.addProductCategory,
    required this.addproductName,
    required this.addProductImageAssets,
    required this.editPagePush,
    required this.deleteProduct,
    required this.documentId, // Initialize documentId
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
        child: Row(
          children: [
            Container(
              width: 100.0,
              height: 100.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(addProductImageAssets),
                  fit: BoxFit.cover, // Ensures image fits nicely
                ),
                borderRadius: BorderRadius.circular(25.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    addproductName,
                    style: aurabold25,
                  ),
                  Text(
                    addProductCategory,
                    style: auraFontboldgray15,
                  ),
                  SizedBox(height: 8),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        MaterialButton(
                          onPressed: editPagePush,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          color: firozi,
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 30),
                        MaterialButton(
                          onPressed: () => deleteProduct(documentId), // Pass the document ID to the delete function
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
        ),
      ),
    );
  }
}
