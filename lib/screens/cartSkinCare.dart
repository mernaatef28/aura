

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/cartSkinCare/cartLogic.dart';
import '../bloc/cartSkinCare/cartState.dart';



class Cart extends StatelessWidget {

  Widget build(BuildContext context) {
   /* late String name;
    late int price;
    late String url;

    Cart({ required this.name,required this.url,required this.price}){}*/
    int i = 1;
    return BlocProvider(
      create: (context) => Cartlogic(),
      child: BlocConsumer<Cartlogic, Cartstate>(
        listener: (context, state) {},
        builder: (context, state) {
          Cartlogic obj = BlocProvider.of(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor:Color(0xFFBBDBE2),
              elevation: 1,
              //btft7 w t8m2 el lon//
              title: Text(
                'SALVOVA',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
              leading: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Your Cart",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.grey[100],
                        ),
                        padding: EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Container(
                              width:double.infinity,
                              height: 80.0,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/images/care.jpeg'),
                                ),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Care',
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [

                                      IconButton(onPressed: () {
                                       obj.mcart();
                                      }, icon: Icon(Icons.remove)),


                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0),
                                        child: Text(
                                          '${obj.i}',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      IconButton(onPressed: () {
                                        obj.pcart();
                                      }, icon: Icon(Icons.add)),
                                      // Padding(
                                      //   padding: const EdgeInsets.only(left:30),
                                      //   child: IconButton(onPressed:(){},
                                      //       icon:Icon(   Icons.delete,size: 30,),),
                                      // )
                                    ],
                                  ),
                                  MaterialButton(onPressed: (){},
                                   minWidth:2,
                                    height: 10,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),

                                    ),
                                    color: Color(0xFFF6CAC9),

                                  child: Row(
                                    children: [
                                      IconButton(onPressed:(){}, icon: Icon(Icons.delete_outline,size: 30,)),
                                      Text('Delete',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
                                    ],
                                  ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.grey[100],
                        ),
                        padding: EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Container(
                              width: 80.0,
                              height: 80.0,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/images/care.jpeg'),
                                ),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Care',
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    children: [

                                      IconButton(onPressed: () {
                                        obj.mcart();
                                      }, icon: Icon(Icons.remove)),


                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0),
                                        child: Text(
                                          '${obj.i}',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      IconButton(onPressed: () {
                                        obj.pcart();
                                      }, icon: Icon(Icons.add))
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Divider(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Total',
                          style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                         // Spacer(),//
                          //bt3ml push leha fa bt3ml alignment a7sn
                          Text('\$ 480.00',
                            style: TextStyle(fontSize: 30),)
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Delivery charge',
                          style: TextStyle(fontSize:20),),
                        // Spacer(),//
                        //bt3ml push leha fa bt3ml alignment a7sn
                        Text('\$ 40.00',
                          style: TextStyle(fontSize: 20),)
                      ],
                    ),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('SubTotal',
                            style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                          // Spacer(),//
                          //bt3ml push leha fa bt3ml alignment a7sn
                          Text('\$ 520.00',
                            style: TextStyle(fontSize: 30),)
                        ],
                      ),
                    ),
                    SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: Colors.black,
                      ),
                      child: Center(
                        child: Text(
                          'Checkout',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
