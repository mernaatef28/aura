
import 'package:aura/screens//confirmedPage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CheckoutPage extends StatefulWidget {
  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  CollectionReference users = FirebaseFirestore.instance.collection('checkout');

  // Text Controllers
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();
  final TextEditingController countryController = TextEditingController();

  final _formKey = GlobalKey<FormState>(); //  Key for validation
  String? _deliveryOption = 'Cash On Delivery';

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    addressController.dispose();
    mobileNumberController.dispose();
    countryController.dispose();
    super.dispose();
  }

  Future<void> _submitCheckout() async {
    // Validate the form
    if (!_formKey.currentState!.validate()) {
      return; // If the form is not valid, don't proceed
    }

    // Ensure that 'Cash On Delivery' is selected
    if (_deliveryOption != 'Cash On Delivery') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please select 'Cash On Delivery'")),
      );
         Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ConfirmPage()),
      );;
    }




    try {
      await users.add({
        'firstName': firstNameController.text,
        'lastName': lastNameController.text,
        'address': addressController.text,
        'mobileNumber': mobileNumberController.text,
        'country': countryController.text,
        'deliveryOption': _deliveryOption,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Checkout successful!")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to complete checkout: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Shipping Address',
          style: TextStyle(
            color: Color(0xff51858C),
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: Icon(Icons.arrow_back_ios_new_outlined),
      ),
      body: Container(
        margin: const EdgeInsets.all(16.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.blueGrey,
            width: 2, // Border width
          ),
          borderRadius: BorderRadius.circular(15), // Rounded corners
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Name Fields
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0, bottom: 16.0),
                        child: TextFormField(
                          controller: firstNameController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            labelText: 'First Name',
                            suffixIcon: Icon(Icons.person),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your first name';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0, bottom: 16.0),
                        child: TextFormField(
                          controller: lastNameController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            labelText: 'Last Name',
                            suffixIcon: Icon(Icons.person),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your last name';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                // Mobile Number Field
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: TextFormField(
                    controller: mobileNumberController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: 'Mobile Number',
                      suffixIcon: Icon(Icons.phone),
                    ),
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your mobile number';
                      }
                      if (!RegExp(r'^\d+$').hasMatch(value)) {
                        return 'Please enter a valid mobile number';
                      }
                      return null;
                    },
                  ),
                ),
                // Address Field
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: TextFormField(
                    controller: addressController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: 'Address',
                      suffixIcon: Icon(Icons.location_on),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your address';
                      }
                      return null;
                    },
                  ),
                ),
                // Country Field
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: TextFormField(
                    controller: countryController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: 'Country',
                      suffixIcon: Icon(Icons.location_city),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your country';
                      }
                      return null;
                    },
                  ),
                ),
                // Delivery Option
                Divider(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Delivery Option:',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      RadioListTile<String>(
                        title: const Text('Cash On Delivery', style: TextStyle(fontSize: 20)),
                        value: 'Cash On Delivery',
                        groupValue: _deliveryOption,
                        onChanged: (String? value) {
                          setState(() {
                            _deliveryOption = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Divider(),
                // Order Summary
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Container(
                    color: Colors.white30,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Order Summary', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('SubTotal', style: TextStyle(fontSize: 25)),
                            Text('\$ 480.00', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Delivery Charge', style: TextStyle(fontSize: 20)),
                            Text('\$ 40.00', style: TextStyle(fontSize: 20)),
                          ],
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Total', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                            Text('\$ 520.00', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                // Submit Button
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: MaterialButton(
                    onPressed: _submitCheckout,
                    color: Color(0xfff6CAC9),
                    child: Text(
                      "Checkout",
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
