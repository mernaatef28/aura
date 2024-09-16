import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'LoginPage.dart';
import 'colors.dart'; // Assuming this contains the color definitions like AppColors

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference users = FirebaseFirestore.instance.collection('users');

  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String confirmPassword = '';
  bool isLoading = false;

  void _showNotification(String message, bool isError) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(message),
          backgroundColor: isError ? Colors.red : Colors.green,
        );
      },
    );
  }

  Future<void> _signup() async {
    if (_formKey.currentState?.validate() != true) {
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      UserCredential user = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (user != null) {
        users.doc(user.user?.uid).set({'email': email});
        _showNotification("Signup successful!", false);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginPage())
        );
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
        decoration: BoxDecoration(
          color: AppColors.lightPink, // Light pink background
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo
                  Image.asset(
                    'assets/signin.png', // Path to the logo image
                    height: 100,
                  ),
                  SizedBox(height: 20),
                  // Sign Up Text
                  Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                  SizedBox(height: 30),

                  // Form
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            labelStyle: TextStyle(
                              color: Color(0xFFFFFFFF),
                            ),
                            prefixIcon: Icon(Icons.email, color: Color(0xFF627882)), // Blue-gray color
                            border: InputBorder.none,
                            fillColor: Colors.transparent,
                            filled: true,
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF627882),
                                width: 1.5,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              email = value;
                            });
                          },
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: TextStyle(
                              color: Color(0xFFFFFFFF),
                            ),
                            prefixIcon: Icon(Icons.lock, color: Color(0xFF627882)),
                            border: InputBorder.none,
                            fillColor: Colors.transparent,
                            filled: true,
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF627882),
                                width: 1.5,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            if (value.length < 6) {
                              return 'Password should be at least 6 characters';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              password = value;
                            });
                          },
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Confirm Password',
                            labelStyle: TextStyle(
                              color: Color(0xFFFFFFFF),
                            ),
                            prefixIcon: Icon(Icons.lock, color: Color(0xFF627882)),
                            border: InputBorder.none,
                            fillColor: Colors.transparent,
                            filled: true,
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF627882),
                                width: 1.5,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please confirm your password';
                            }
                            if (value != password) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              confirmPassword = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),

                  // Sign Up Button
                  isLoading
                      ? CircularProgressIndicator()
                      : ElevatedButton(
                    onPressed: _signup,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF627882), // Blue-gray button color
                      padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),

                    ),
                    child: Text(
                      'Signup',
                      style: TextStyle(fontSize: 18, color: Colors.white,fontWeight: FontWeight.bold,),

                    ),
                  ),
                  SizedBox(height: 20),

                  // Google Sign In Button
                  OutlinedButton.icon(
                    onPressed: () {
                      // Google sign-in logic
                    },
                    icon: Icon(Icons.g_mobiledata, color: Color(0xFF627882)),
                    label: Text(
                      'Sign in with Google',
                      style: TextStyle(color: Color(0xFF627882)),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Color(0xFF627882)), // Border color
                      padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                    ),
                  ),
                  SizedBox(height: 20),

                  // Log In Text
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: Text(
                      "Already have an account? Log In",
                      style: TextStyle(
                        fontSize: 16,
                          color: Color(0xFF627882),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
