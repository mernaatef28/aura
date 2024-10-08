

import 'package:aura/screens/LoginPage.dart';
import 'package:aura/screens/CategoryDisplay.dart';

import 'package:aura/screens/adminPanel/addProduct.dart';
import 'package:aura/screens/cart.dart';
import 'package:aura/screens/productHomePage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'temps/addAllProducts.dart';
import 'screens/checkoutpage.dart';
import 'firebase_options.dart';
import 'screens/productPage.dart';
import 'temps/categoryadd.dart';
//fireaura-90d09
Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  print('firebase');
  runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        home ://AddProduct(),
        //ProductHomePage(),
        //:Categorydisplay(categoryName: "fairozi collection ") ,
       // produactDetailspage(imageUrl: Image.network("https://github.com/mernaatef28/aura/blob/main/assets/pictures/15.png?raw=true"), productName: 'Gentle Purifying Cleanser', categoryName: 'FaceCare', price: 40.4 , ) ,
        //AddProduct(),
        LoginPage() ,
      ));

}

