import 'package:aura/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditProductPage extends StatefulWidget {
  final String? productName; // Optional product name

  EditProductPage({this.productName});

  @override
  _EditProductPageState createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _priceController;
  late TextEditingController _descriptionController;
  late TextEditingController _categoryNameController;

  Map<String, dynamic>? _productData;

  @override
  void initState() {
    super.initState();

    // Initialize controllers with default values (empty strings)
    _nameController = TextEditingController(text: '');
    _priceController = TextEditingController(text: '');
    _descriptionController = TextEditingController(text: '');
    _categoryNameController = TextEditingController(text: '');

    // Only fetch the product if the product name is provided
    if (widget.productName != null && widget.productName!.isNotEmpty) {
      _fetchProductByName(widget.productName!);
    }
  }

  Future<void> _fetchProductByName(String productName) async {
    try {
      QuerySnapshot query = await FirebaseFirestore.instance
          .collection('products')
          .where('ProductName', isEqualTo: productName)
          .get();

      if (query.docs.isNotEmpty) {
        setState(() {
          _productData = query.docs.first.data() as Map<String, dynamic>?;
          // Safely initialize controllers with fetched data or default values
          _nameController.text = _productData?['ProductName'] ?? 'Unnamed Product'; // Provide a default string
          _priceController.text = _productData?['price']?.toString() ?? '0'; // Default to '0' for price
          _descriptionController.text = _productData?['ProductDetailsDescription'] ?? 'No Description';
          _categoryNameController.text = _productData?['CategoryName'] ?? 'Uncategorized';
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Product not found')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching product: $e')),
      );
    }
  }

  Future<void> _updateProduct() async {
    if (_formKey.currentState!.validate()) {
      try {
        QuerySnapshot query = await FirebaseFirestore.instance
            .collection('products')
            .where('ProductName', isEqualTo: widget.productName)
            .get();

        if (query.docs.isNotEmpty) {
          await query.docs.first.reference.update({
            'ProductName': _nameController.text,
            'price': _priceController.text,
            'ProductDetailsDescription': _descriptionController.text,
            'CategoryName': _categoryNameController.text,
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Product updated successfully')),
          );
          Navigator.pop(context); // Go back after updating
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Product not found for updating')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update product: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.lightPink,
        title: Center(
          child: Text(
            "Update Product",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: _productData != null
          ? SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: _productData?['ImageUrl'] != null
                      ? Image.network(
                    _productData!['ImageUrl'],
                    height: 200,
                    width: 200,
                    fit: BoxFit.cover,
                  )
                      : Image.asset(
                    'assets/login2.png', // Default placeholder image
                    height: 200,
                    width: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Product Name'),
                  validator: (value) => value == null || value.isEmpty
                      ? 'Please enter a name'
                      : null,
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _priceController,
                  decoration: InputDecoration(labelText: 'Price'),
                  validator: (value) => value == null || value.isEmpty
                      ? 'Please enter a price'
                      : null,
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(labelText: 'Description'),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _categoryNameController,
                  decoration: InputDecoration(labelText: 'Category Name'),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _updateProduct,
                  child: Text('Save Changes'),
                ),
              ],
            ),
          ),
        ),
      )
          : Center(child: CircularProgressIndicator()), // Show loader while fetching data
    );
  }
}
