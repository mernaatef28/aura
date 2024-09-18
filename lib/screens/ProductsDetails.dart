import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:finalproj/colors.dart';

class EditProductPage extends StatefulWidget {
  final String? productName; // Optional product name

  EditProductPage({this.productName});

  @override
  _EditProductPageState createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _quantityController;
  late TextEditingController _priceController;
  late TextEditingController _descriptionController;
  late TextEditingController _categoryNameController;

  Map<String, dynamic>? _productData;

  @override
  void initState() {
    super.initState();

    // Initialize controllers with default values (empty strings)
    _nameController = TextEditingController(text: '');
    _quantityController = TextEditingController(text: '');
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
          .where('name', isEqualTo: productName)
          .get();

      if (query.docs.isNotEmpty) {
        setState(() {
          _productData = query.docs.first.data() as Map<String, dynamic>?;
          // Initialize controllers with fetched data or empty string if null
          _nameController.text = _productData?['name'] ?? '';
          _quantityController.text = _productData?['Quantity']?.toString() ?? '';
          _priceController.text = _productData?['Price']?.toString() ?? '';
          _descriptionController.text = _productData?['description'] ?? '';
          _categoryNameController.text = _productData?['categoryName'] ?? '';
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
            .where('name', isEqualTo: widget.productName)
            .get();

        if (query.docs.isNotEmpty) {
          await query.docs.first.reference.update({
            'name': _nameController.text,
            'Quantity': _quantityController.text,
            'Price': _priceController.text,
            'description': _descriptionController.text,
            'categoryName': _categoryNameController.text,
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
          ? Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (_productData?['image'] != null)
                Center(
                  child: Image.network(
                    _productData!['image'],
                    height: 200,
                    width: 200,
                    fit: BoxFit.cover,
                  ),
                )
              else
                Center(
                  child: Image.asset(
                    'assets/login2.png',
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
                controller: _quantityController,
                decoration: InputDecoration(labelText: 'Quantity'),
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter a quantity'
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
      )
          : Center(child: CircularProgressIndicator()), // Show loader while fetching data
    );
  }
}
