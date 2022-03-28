import 'package:flutter/material.dart';
import 'package:shop_app/models/cart.dart';
import 'package:shop_app/models/orders.dart';
import 'package:shop_app/screens/cart_screens.dart';
import 'package:shop_app/screens/edit_Product_screens.dart';
import 'package:shop_app/screens/orders_screens.dart';

import 'package:shop_app/screens/product_details_screens.dart';
import 'package:shop_app/screens/product_overview_screens.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/user_product_screen.dart';

import 'models/products.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context)=> Products(),
        ),
        ChangeNotifierProvider(
          create: (context)=> Cart(),
        ),
        ChangeNotifierProvider(
          create: (context)=> Orders(),
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primaryColor: Colors.redAccent,
            //errorColor: Colors.red,

            primarySwatch: Colors.red,
            fontFamily: 'lato',
            appBarTheme: AppBarTheme(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
            )
          ),
          home: ProductOverviewScreens(),
          routes: {
            ProductDetails.routeName : (context)=> ProductDetails(),
            CartScreens.routeName : (context) => CartScreens(),
            OrdersScreens.routeName : (context) => OrdersScreens(),
            ProductOverviewScreens.routeName : (context) => ProductOverviewScreens(),
            UserProductScreen.routeName : (context) => UserProductScreen(),
            EditProductScreens.routeName : (context) => EditProductScreens(),

          },
        ),
    );

  }
}


