class Product {
  final String imageUrl;
  final String categoryName;
  final String productName;
  final double price;
  final String? shortDescription;
  final double? rating;
  final double? discountPercentage;
  final bool isAvailable;
  final String ProductDetailsDescription ;

  Product( {
    required this.imageUrl,
    required this.categoryName,
    required this.productName,
    required this.price,
    this.shortDescription,
    this.rating,
    this.discountPercentage,
    this.isAvailable = true,
   this.ProductDetailsDescription = "A soothing toner for sensitive skin.",
  });
}
