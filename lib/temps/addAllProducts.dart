import 'package:aura/widgets/btn.dart';
import 'package:flutter/material.dart';
import 'package:aura/localVariables/styles.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aura/widgets/addProductCard.dart';
import '../../bloc/cartSkinCare/cartLogic.dart';
import '../../bloc/cartSkinCare/cartState.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../localVariables/local_variables.dart';

class addAllProducts extends StatelessWidget {
  final TextEditingController priceController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController imageController = TextEditingController();
  final TextEditingController shortDescriptionController = TextEditingController();
  final TextEditingController detailsDescriptionController = TextEditingController();
  final TextEditingController launchingLineController = TextEditingController(); // New Controller

  @override
  Widget build(BuildContext context) {
    CollectionReference products = FirebaseFirestore.instance.collection('products');

    Future<void> addProduct(Map<String, dynamic> productData) async {
      return products
          .add(productData)
          .then((value) => print("Product Added"))
          .catchError((error) => print("Failed to add product: $error"));
    }

    Future<void> addAllProducts() async {
      final productList = [
        // AuraBeige Line
        {
          'ProductName': 'SoftMist',
          'CategoryName': 'Toner',
          'price': '19',
          'ImageUrl': 'https://github.com/mernaatef28/aura/blob/main/assets/pictures/30.png?raw=true',
          'ProductShortDescription': 'A soothing toner for sensitive skin.',
          'ProductDetailsDescription': 'SoftMist Toner is formulated with calming ingredients to soothe and hydrate sensitive skin. It helps to reduce redness and prepare your skin for the next steps in your routine.',
          'LaunchingLine': 'AuraBeige'
        },
        {
          'ProductName': 'CreamyComfort',
          'CategoryName': 'Moisturizer',
          'price': '27',
          'ImageUrl': 'https://github.com/mernaatef28/aura/blob/main/assets/pictures/22.png?raw=true',
          'ProductShortDescription': 'A rich moisturizer for ultimate comfort.',
          'ProductDetailsDescription': 'CreamyComfort Moisturizer provides deep hydration and nourishment, leaving your skin feeling soft and comfortable. Ideal for dry and sensitive skin types.',
          'LaunchingLine': 'AuraBeige'
        },
        {
          'ProductName': 'CalmSerum',
          'CategoryName': 'Serum',
          'price': '32',
          'ImageUrl': 'https://github.com/mernaatef28/aura/blob/main/assets/pictures/40.png?raw=true',
          'ProductShortDescription': 'A calming serum for irritated skin.',
          'ProductDetailsDescription': 'CalmSerum is designed to soothe and repair irritated skin. Its gentle formula helps to reduce inflammation and promote a healthy complexion.',
          'LaunchingLine': 'AuraBeige'
        },
        {
          'ProductName': 'GentleFoam',
          'CategoryName': 'Cleanser',
          'price': '22',
          'ImageUrl': 'https://github.com/mernaatef28/aura/blob/main/assets/pictures/32.png?raw=true',
          'ProductShortDescription': 'A gentle foaming cleanser for daily use.',
          'ProductDetailsDescription': 'GentleFoam Cleanser effectively removes impurities while being gentle on the skin. Suitable for all skin types, especially sensitive skin.',
          'LaunchingLine': 'AuraBeige'
        },

        // Aurafirozi Line
        {
          'ProductName': 'FreshFoam',
          'CategoryName': 'Toner',
          'price': '18',
          'ImageUrl': 'https://github.com/mernaatef28/aura/blob/main/assets/pictures/29.png?raw=true',
          'ProductShortDescription': 'A refreshing toner that balances and hydrates.',
          'ProductDetailsDescription': 'FreshFoam Toner is infused with natural extracts to balance your skin\'s pH and provide a burst of hydration. Perfect for prepping your skin for the next steps in your routine.',
          'LaunchingLine': 'Aurafirozi'
        },
        {
          'ProductName': 'DewDrop',
          'CategoryName': 'Moisturizer',
          'price': '25',
          'ImageUrl': 'https://github.com/mernaatef28/aura/blob/main/assets/pictures/25.png?raw=true',
          'ProductShortDescription': 'A lightweight moisturizer for a dewy glow.',
          'ProductDetailsDescription': 'DewDrop Moisturizer delivers intense hydration without the heaviness. Its unique formula leaves your skin feeling soft, smooth, and radiant.',
          'LaunchingLine': 'Aurafirozi'
        },
        {
          'ProductName': 'GlowSerum',
          'CategoryName': 'Serum',
          'price': '30',
          'ImageUrl': 'https://github.com/mernaatef28/aura/blob/main/assets/pictures/39.png?raw=true',
          'ProductShortDescription': 'A potent serum for a luminous complexion.',
          'ProductDetailsDescription': 'GlowSerum is packed with antioxidants and vitamins to brighten and even out your skin tone. Use daily for a noticeable glow.',
          'LaunchingLine': 'Aurafirozi'
        },
        {
          'ProductName': 'PureClean',
          'CategoryName': 'Cleanser',
          'price': '20',
          'ImageUrl': 'https://github.com/mernaatef28/aura/blob/main/assets/pictures/34.png?raw=true',
          'ProductShortDescription': 'A gentle cleanser that purifies and refreshes.',
          'ProductDetailsDescription': 'PureClean Cleanser removes impurities and excess oil without stripping your skin. Its gentle formula is suitable for all skin types.',
          'LaunchingLine': 'Aurafirozi'
        },

        // Auralabini Line
        {
          'ProductName': 'AquaMist',
          'CategoryName': 'Toner',
          'price': '19',
          'ImageUrl': 'https://github.com/mernaatef28/aura/blob/main/assets/pictures/27.png?raw=true',
          'ProductShortDescription': 'A hydrating toner with a cooling effect.',
          'ProductDetailsDescription': 'AquaMist Toner soothes and hydrates with a refreshing mist. Ideal for calming irritated skin and providing a moisture boost.',
          'LaunchingLine': 'Auralabini'
        },
        {
          'ProductName': 'SilkCream',
          'CategoryName': 'Moisturizer',
          'price': '27',
          'ImageUrl': 'https://github.com/mernaatef28/aura/blob/main/assets/pictures/23.png?raw=true',
          'ProductShortDescription': 'A rich moisturizer for silky smooth skin.',
          'ProductDetailsDescription': 'SilkCream Moisturizer deeply nourishes and hydrates, leaving your skin feeling luxuriously soft and smooth. Perfect for dry and sensitive skin.',
          'LaunchingLine': 'Auralabini'
        },
        {
          'ProductName': 'RadianceBoost',
          'CategoryName': 'Serum',
          'price': '32',
          'ImageUrl': 'https://github.com/mernaatef28/aura/blob/main/assets/pictures/38.png?raw=true',
          'ProductShortDescription': 'A brightening serum for radiant skin.',
          'ProductDetailsDescription': 'RadianceBoost Serum targets dark spots and uneven skin tone, delivering a brighter and more radiant complexion with regular use.',
          'LaunchingLine': 'Auralabini'
        },
        {
          'ProductName': 'GentleWash',
          'CategoryName': 'Cleanser',
          'price': '22',
          'ImageUrl': 'https://github.com/mernaatef28/aura/blob/main/assets/pictures/33.png?raw=true',
          'ProductShortDescription': 'A mild cleanser for daily use.',
          'ProductDetailsDescription': 'GentleWash Cleanser effectively removes dirt and makeup while being gentle on the skin. Suitable for all skin types, including sensitive skin.',
          'LaunchingLine': 'Auralabini'
        },

        // Aurayellow Line
        {
          'ProductName': 'SunKiss',
          'CategoryName': 'Toner',
          'price': '20',
          'ImageUrl': 'https://github.com/mernaatef28/aura/blob/main/assets/pictures/28.png?raw=true',
          'ProductShortDescription': 'A revitalizing toner with a hint of citrus.',
          'ProductDetailsDescription': 'SunKiss Toner revitalizes your skin with a refreshing citrus scent. It balances and hydrates, leaving your skin feeling rejuvenated.',
          'LaunchingLine': 'Aurayellow'
        },
        {
          'ProductName': 'GoldenGlow',
          'CategoryName': 'Moisturizer',
          'price': '28',
          'ImageUrl': 'https://github.com/mernaatef28/aura/blob/main/assets/pictures/24.png?raw=true',
          'ProductShortDescription': 'A nourishing moisturizer for a golden glow.',
          'ProductDetailsDescription': 'GoldenGlow Moisturizer provides deep hydration and a radiant finish. Perfect for achieving a healthy, sun-kissed look.',
          'LaunchingLine': 'Aurayellow'
        },
        {
          'ProductName': 'LightBeam',
          'CategoryName': 'Serum',
          'price': '33',
          'ImageUrl': 'https://github.com/mernaatef28/aura/blob/main/assets/pictures/37.png?raw=true',
          'ProductShortDescription': 'A brightening serum for luminous skin.',
          'ProductDetailsDescription': 'LightBeam Serum targets dullness and uneven skin tone, delivering a luminous and radiant complexion with regular use.',
          'LaunchingLine': 'Aurayellow'
        },
        {
          'ProductName': 'CitrusClean',
          'CategoryName': 'Cleanser',
          'price': '23',
          'ImageUrl': 'https://github.com/mernaatef28/aura/blob/main/assets/pictures/35.png?raw=true',
          'ProductShortDescription': 'A citrus-infused cleanser for a fresh feel.',
          'ProductDetailsDescription': 'CitrusClean Cleanser invigorates your skin with a burst of citrus. It effectively removes impurities and leaves your skin feeling fresh and clean.',
          'LaunchingLine': 'Aurayellow'
        },

        // Aurapambi Line
        {
          'ProductName': 'ClearWave',
          'CategoryName': 'Toner',
          'price': '18',
          'ImageUrl': 'https://github.com/mernaatef28/aura/blob/main/assets/pictures/26.png?raw=true',
          'ProductShortDescription': 'A clarifying toner for clear, balanced skin.',
          'ProductDetailsDescription': 'ClearWave Toner clarifies your skin, reducing excess oil and balancing your complexion. Ideal for oily and combination skin.',
          'LaunchingLine': 'Aurapambi'
        },
        {
          'ProductName': 'VelvetHydrate',
          'CategoryName': 'Moisturizer',
          'price': '26',
          'ImageUrl': 'https://github.com/mernaatef28/aura/blob/main/assets/pictures/21.png?raw=true',
          'ProductShortDescription': 'A luxurious moisturizer for deep hydration.',
          'ProductDetailsDescription': 'VelvetHydrate Moisturizer delivers rich hydration and leaves your skin feeling velvety smooth. Perfect for all skin types.',
          'LaunchingLine': 'Aurapambi'
        },
        {
          'ProductName': 'ClearGlow',
          'CategoryName': 'Serum',
          'price': '31',
          'ImageUrl': 'https://github.com/mernaatef28/aura/blob/main/assets/pictures/36.png?raw=true',
          'ProductShortDescription': 'A clarifying serum for a clear, glowing complexion.',
          'ProductDetailsDescription': 'ClearGlow Serum helps to reduce the appearance of blemishes and uneven skin tone, giving you a clear and glowing complexion.',
          'LaunchingLine': 'Aurapambi'
        },
        {
          'ProductName': 'FoamClean',
          'CategoryName': 'Cleanser',
          'price': '21',
          'ImageUrl': 'https://github.com/mernaatef28/aura/blob/main/assets/pictures/31.png?raw=true',
          'ProductShortDescription': 'A foaming cleanser for a deep clean.',
          'ProductDetailsDescription': 'FoamClean Cleanser provides a deep clean without stripping your skin of its natural oils. Suitable for all skin types, especially oily and combination skin.',
          'LaunchingLine': 'Aurapambi'
        }
      ];


      for (var product in productList) {
        await addProduct(product);
      }
    }

    return BlocProvider(
      create: (context) => Cartlogic(),
      child: BlocConsumer<Cartlogic, Cartstate>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                "Add Products to Firebase",
                style: auraFontFayrozi30,
              ),
            ),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: btnCal(
                  text: "Add All Products",
                  c: firozi,
                  event: addAllProducts,
                  textColor: Colors.white,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
