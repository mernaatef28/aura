
import 'package:flutter/material.dart';


import 'package:aura/screens/adminPanel.dart/adminPanelHome.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:aura/screens/productHomePage.dart';
import 'package:aura/signupPage.dart';
import 'colors.dart';
import 'notification.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference users = FirebaseFirestore.instance.collection(
      'users');
  String email = '';
  String password = '';
  bool isLoading = false;

  void _showNotification(String message, bool isError) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return NotificationPage(message: message, isError: isError);
      },
    );
  }

  Future<void> _login() async {
    setState(() {
      isLoading = true;
    });

    try {
      if (email == 'jana.hagar@gmail.com' && password == '123456') {
        _showNotification("Admin login successful!", false);

        // navigate to admin page
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AdminPanel()));

      } else {
        QuerySnapshot result = await users.where('email', isEqualTo: email)
            .get();
        if (result.docs.isNotEmpty) {
          UserCredential user = await _auth.signInWithEmailAndPassword(
            email: email,
            password: password,
          );
          if (user != null) {
            _showNotification("Login successful!", false);

            // navigate to the main shop page
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProductHomePage()));

          }
        } else {
          _showNotification("Email does not exist!", true);
        }
      }
    } catch (e) {
      _showNotification(e.toString(), true);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.lightBlue,

        child: Center( // Wrap with Center to avoid overflow
          child: SingleChildScrollView( // Wrap the Column with SingleChildScrollView
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 50), // Add a top space for better alignment

                  // Logo
                  Image.asset('assets/pictures/9.png', height: 200),
                  SizedBox(height: 20),

                  // Welcome Text
                  Text(
                    'Welcome!',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: AppColors.tealBlue,
                    ),
                  ),
                  SizedBox(height: 30),

                  // Email Input Field
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(color: AppColors.lightYellow),
                      prefixIcon: Icon(
                          Icons.email, color: AppColors.lightYellow),
                      border: InputBorder.none,
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.lightYellow),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        email = value;
                      });
                    },
                  ),
                  SizedBox(height: 15),

                  // Password Input Field
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(color: AppColors.lightYellow),
                      prefixIcon: Icon(
                          Icons.lock, color: AppColors.lightYellow),
                      border: InputBorder.none,
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.lightYellow),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        password = value;
                      });
                    },
                  ),
                  SizedBox(height: 30),

                  // Login Button
                  isLoading
                      ? CircularProgressIndicator()
                      : ElevatedButton(
                    onPressed: _login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF4A6572),
                      padding: EdgeInsets.symmetric(
                          horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 15),

                  // Forgot Password Text
                  TextButton(
                    onPressed: () {
                      // Forgot password logic here
                    },
                    child: Text(
                      'Forgot password?',
                      style: TextStyle(
                          color: AppColors.lightYellow), // Darker yellow text
                    ),
                  ),
                  SizedBox(height: 15),

                  // "Don't have an account?" text and Sign Up Button
                  Text(
                    "Don't have an account?",
                    style: TextStyle(
                        color: AppColors.lightYellow), // Darker yellow text
                  ),
                  SizedBox(height: 10),

                  // Sign Up Button
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignupPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF4A6572),
                      padding: EdgeInsets.symmetric(
                          horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 20), // Final bottom space
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
