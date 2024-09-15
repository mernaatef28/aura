import 'package:aura/screens/cartSkinCare.dart';
import 'package:flutter/material.dart';
import 'package:aura/localVariables/local_variables.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:aura/localVariables/styles.dart';
import 'package:flutter_product_card/flutter_product_card.dart';
class ProductHomePage extends StatefulWidget {
  @override
  State<ProductHomePage> createState() => _ProductHomePageState();
}

class _ProductHomePageState extends State<ProductHomePage> {
  @override
  Widget build(BuildContext context) {
    var controller = TextEditingController();
    return Scaffold(
        appBar: AppBar(
            title: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.only(right: 0.8, top: 0.8),
                    child: Container(
                        width: 150,
                        height: 150,
                        child: Image.asset("assets/pictures/6.png")),
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
                Expanded(
                  flex: 2,
                  child: TextFormField(
                      decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      color: firozi,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: babyGray,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: firozi,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    hintText: "what are you looking for ?",
                    hintStyle: TextStyle(color: Colors.white),
                    filled: true,
                    fillColor: babyGray.withOpacity(0.8),
                  )),
                ),
              ],
            ),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.shopping_cart,
                  size: 40,
                  color: firozi,
                ),
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Cart()));
                },
              )
            ]),
        body: Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CarouselSlider(
                    items: mySlides,
                    options: CarouselOptions(
                        autoPlay: true,
                        height: 200,
                        onPageChanged: (index, reason) {
                          setState(() {
                            currentIndex = index;
                          });
                        })),
                Padding(
                  padding: const EdgeInsets.only(left:8.0 , right: 8.0 , top: 8.0),
                  child: Text("Categories" ,
                    style: auraFontFayrozi30,
                  ),
                ) ,
                Padding(
                  padding: const EdgeInsets.only(left:8.0 , right: 8.0 , top: 8.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                       for (int i =0 ; i < categories.length ;i++)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              InkWell(
                                child: CircleAvatar(

                                  backgroundImage: categories[i],
                                  radius: 40,

                                ),
                                onTap: (){},
                              ),
                              Text(cartegories_names[i] , style: TextStyle(color: firozi , fontSize: 17),)
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left:8.0 , right: 8.0 , top: 8.0),
                  child: Text("recommended for you" ,
                    style: auraFontFayrozi30,
                  ),
                ) ,
            GridView.builder(
              shrinkWrap: true, // Allows GridView to take the minimum space
              physics: NeverScrollableScrollPhysics(), // Disables GridView's scrolling
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                return ProductCard(
                  imageUrl: products[index].imageUrl,
                  categoryName: products[index].categoryName,
                  productName: products[index].productName,
                  price: products[index].price,
                  shortDescription: products[index].shortDescription,
                  rating: products[index].rating,
                  discountPercentage: products[index].discountPercentage,
                  isAvailable: products[index].isAvailable,
                  cardColor: Colors.white,
                  textColor: Colors.black,
                  borderRadius: 8.0,
                  onTap: () {
                    // Handle product tap
                  },
                  onFavoritePressed: () {
                    // Handle favorite button pressed
                  },
                );
              },
            )


            ],
            ),
          ),

        )

    );
  }
}
