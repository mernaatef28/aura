import 'dart:ui';

import 'package:flutter/material.dart';

import 'classes/product.dart';

Color firozi = Color(0xff51858c) ,
    babyBlue = Color(0xffbbdbe2),
    babyRose = Color(0xfff6cac9),
    babyYellow = Color(0xfff8f0ae),
    babyGray = Color(0xffD9D9D9);
final List<Widget> mySlides = [
  ClipRRect(
    borderRadius: BorderRadius.circular(20),
    child: Image.asset(
      "assets/pictures/17.png",
      fit: BoxFit.cover,
      width: double.infinity,
      height: 200,
    ),
  ),
  ClipRRect(
    borderRadius: BorderRadius.circular(20),
    child: Image.asset(
      "assets/pictures/13.png",
      fit: BoxFit.cover,
      width: double.infinity,
      height: 200,
    ),
  ),
  ClipRRect(
    borderRadius: BorderRadius.circular(20),
    child: Image.asset(
      "assets/pictures/17.png",
      fit: BoxFit.cover,
      width: double.infinity,
      height: 200,
    ),
  ),
  ClipRRect(
    borderRadius: BorderRadius.circular(20),
    child: Image.asset(
      "assets/pictures/18.png",
      fit: BoxFit.cover,
      width: double.infinity,
      height: 200,
    ),
  ),
  ClipRRect(
    borderRadius: BorderRadius.circular(20),
    child: Image.asset(
      "assets/pictures/16.png",
      fit: BoxFit.cover,
      width: double.infinity,
      height: 200,
    ),
  ),
];

final categories =[
  AssetImage("assets/pictures/18.png"),
  AssetImage("assets/pictures/17.png"),
  AssetImage("assets/pictures/13.png"),
  AssetImage("assets/pictures/18.png"),
  AssetImage("assets/pictures/17.png"),
  AssetImage("assets/pictures/13.png")
] ;
final cartegories_names =[
  'firozi',
  'labini',
  'pambi',
  'aurayellow',
  'labini',
  'pambi'
] ;
int currentIndex =0 ;

final List<Map<String, dynamic>> productsList = [
  {
    'name': 'Product 1',
    'image': 'assets/pictures/15.png',
    'price': 29.99,
  },
  {
    'name': 'Product 2',
    'image': 'assets/pictures/14.png',
    'price': 19.99,
  },
  {
    'name': 'Product 3',
    'image': 'assets/pictures/15.png',
    'price': 39.99,
  },
];
List<Product> products = [
  // AuraBeige Line
  Product(
    imageUrl: 'https://github.com/mernaatef28/aura/blob/main/assets/pictures/30.png?raw=true',
    categoryName: 'AuraBeige',
    productName: 'SoftMist Toner',
    price: 19,
    shortDescription: 'A soothing toner for sensitive skin.',
    rating: 4.8,
    discountPercentage: 0,
    isAvailable: true,
  ),
  Product(
    imageUrl: 'https://github.com/mernaatef28/aura/blob/main/assets/pictures/25.png?raw=true',
    categoryName: 'Aurafirozi',
    productName: 'DewDrop Moisturizer',
    price: 25,
    shortDescription: 'A lightweight moisturizer for a dewy glow.',
    rating: 4.8,
    discountPercentage: 0,
    isAvailable: true,
  ),
  Product(
    imageUrl: 'https://github.com/mernaatef28/aura/blob/main/assets/pictures/22.png?raw=true',
    categoryName: 'AuraBeige',
    productName: 'CreamyComfort Moisturizer',
    price: 27,
    shortDescription: 'A rich moisturizer for ultimate comfort.',
    rating: 4.7,
    discountPercentage: 0,
    isAvailable: true,
  ),
  Product(
    imageUrl: 'https://github.com/mernaatef28/aura/blob/main/assets/pictures/40.png?raw=true',
    categoryName: 'AuraBeige',
    productName: 'CalmSerum',
    price: 32,
    shortDescription: 'A calming serum for irritated skin.',
    rating: 4.9,
    discountPercentage: 0,
    isAvailable: true,
  ),
  Product(
    imageUrl: 'https://github.com/mernaatef28/aura/blob/main/assets/pictures/32.png?raw=true',
    categoryName: 'AuraBeige',
    productName: 'GentleFoam Cleanser',
    price: 22,
    shortDescription: 'A gentle foaming cleanser for daily use.',
    rating: 4.6,
    discountPercentage: 0,
    isAvailable: true,
  ),

  // Aurafirozi Line
  Product(
    imageUrl: 'https://github.com/mernaatef28/aura/blob/main/assets/pictures/29.png?raw=true',
    categoryName: 'Aurafirozi',
    productName: 'FreshFoam Toner',
    price: 18,
    shortDescription: 'A refreshing toner that balances and hydrates.',
    rating: 4.7,
    discountPercentage: 0,
    isAvailable: true,
  ),

];



