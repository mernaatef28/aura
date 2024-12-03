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
  Product(
    imageUrl: 'https://i.pinimg.com/564x/51/c0/52/51c052a217fb0be5c34c1b245cb7174c.jpg',
    categoryName: 'Electronics',
    productName: 'Smartphone',
    price: 599.99,
    shortDescription: 'Latest model with advanced features',
    rating: 4.5,
    discountPercentage: 10,
    isAvailable: true,
  ),
  Product(
    imageUrl: 'https://i.pinimg.com/564x/51/c0/52/51c052a217fb0be5c34c1b245cb7174c.jpg',
    categoryName: 'Fashion',
    productName: 'Designer Shirt',
    price: 79.99,
    shortDescription: 'Stylish and comfortable',
    rating: 4.0,
    discountPercentage: 5,
    isAvailable: true,
  ),
  Product(
    imageUrl: 'https://i.pinimg.com/564x/51/c0/52/51c052a217fb0be5c34c1b245cb7174c.jpg',
    categoryName: 'Fashion',
    productName: 'Designer Shirt',
    price: 79.99,
    shortDescription: 'Stylish and comfortable',
    rating: 4.0,
    discountPercentage: 5,
    isAvailable: true,
  ),Product(
    imageUrl: 'https://i.pinimg.com/564x/51/c0/52/51c052a217fb0be5c34c1b245cb7174c.jpg',
    categoryName: 'Fashion',
    productName: 'Designer Shirt',
    price: 79.99,
    shortDescription: 'Stylish and comfortable',
    rating: 4.0,
    discountPercentage: 5,
    isAvailable: true,
  ),Product(
    imageUrl: 'https://i.pinimg.com/564x/51/c0/52/51c052a217fb0be5c34c1b245cb7174c.jpg',
    categoryName: 'Fashion',
    productName: 'Designer Shirt',
    price: 79.99,
    shortDescription: 'Stylish and comfortable',
    rating: 4.0,
    discountPercentage: 5,
    isAvailable: true,
  ),Product(
    imageUrl: 'https://i.pinimg.com/564x/51/c0/52/51c052a217fb0be5c34c1b245cb7174c.jpg',
    categoryName: 'Fashion',
    productName: 'Designer Shirt',
    price: 79.99,
    shortDescription: 'Stylish and comfortable',
    rating: 4.0,
    discountPercentage: 5,
    isAvailable: true,
  ),
  // Add more products as needed
];
List<Product> productLists2 = [
  Product(
  imageUrl: 'assets/pictures/17.png',
  categoryName: 'faceCare',
  productName: 'cleanser',
  price: 79.99,
  shortDescription: 'forallskintype',
  rating: 4.0,
  discountPercentage: 5,
  isAvailable: true,
  ),
  Product(
    imageUrl: 'assets/pictures/14.png',
    categoryName: 'faceCare',
    productName: 'cleanser',
    price: 79.99,
    shortDescription: 'forallskintype',
    rating: 4.0,
    discountPercentage: 5,
    isAvailable: true,
  ),
  Product(
    imageUrl: 'assets/pictures/14.png',
    categoryName: 'faceCare',
    productName: 'cleanser',
    price: 79.99,
    shortDescription: 'forallskintype',
    rating: 4.0,
    discountPercentage: 5,
    isAvailable: true,
  ),
];



