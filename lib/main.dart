

import 'package:aura/LoginPage.dart';
import 'package:aura/screens/adminPanel.dart/addProduct.dart';
import 'package:aura/screens/adminPanel.dart/adminPanelHome.dart';
import 'package:aura/screens/cartSkinCare.dart';
import 'package:aura/screens/productHomePage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'screens/checkoutpage.dart';
import 'firebase_options.dart';
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
        home:ProductHomePage() ,
      ));

}

