import 'addProduct.dart';
import 'package:aura/widgets/btn.dart';
import 'package:flutter/material.dart';
import 'package:aura/localVariables/local_variables.dart';
import 'package:aura/localVariables/styles.dart';
import 'updateProduct.dart';

class AdminPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: babyRose,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 50.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Welcome\nback admin!',
                  style: auraFontFayrozi50.copyWith(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  width: 90.0,
                  height: 90.0,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10.0,
                        offset: Offset(0, 5),
                      ),
                    ],
                    image: DecorationImage(
                      image: AssetImage('assets/pictures/6.png'),
                    ),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ],
            ),
            SizedBox(height: 200),
            Center(
              child: Column(
                children: [

                  SizedBox(height: 30),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        print("Navigating to AddProduct");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                 AddProduct() ), // Make sure this is correct
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: firozi,
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(80.0),
                        ),
                        elevation: 5,
                      ),
                      child: Text(
                        '   VIEW PRODUCTS   ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
