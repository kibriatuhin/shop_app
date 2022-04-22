import 'package:flutter/material.dart';
import 'package:shop_app/models/auth.dart';
import 'package:shop_app/models/cart.dart';
import 'package:shop_app/models/orders.dart';
import 'package:shop_app/screens/auth_screens.dart';
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
          ChangeNotifierProvider.value(value: Auth()),
          /*   ProxyProvider<Auth, Products>(
            update: (context, auth, previousProducts) => Products(auth.token,
                previousProducts == null ? [] : previousProducts.items),
          ),*/
          ChangeNotifierProxyProvider<Auth, Products>(
              create: (_) => Products('', [], ''),
              update: (context, auth, previousProducts) => Products(
                    auth.token,
                    previousProducts == null ? [] : previousProducts.items,
                    auth.userId,
                  )),
          /* ChangeNotifierProvider(
            create: (context) => Products(),
          ),*/
          ChangeNotifierProvider(
            create: (context) => Cart(),
          ),
          ChangeNotifierProxyProvider<Auth, Orders>(
              create: (_) => Orders('', [], ''),
              update: (context, auth, previousProducts) => Orders(
                    auth.token,
                    previousProducts == null ? [] : previousProducts.orders,
                    auth.userId,
                  )),
        ],
        child: Consumer<Auth>(
          builder: (context, authData, _) => MaterialApp(
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
                )),
            home: authData.isAuth ? ProductOverviewScreens() : AuthMode(),
            routes: {
              AuthMode.routeName: (context) => AuthMode(),
              ProductDetails.routeName: (context) => ProductDetails(),
              CartScreens.routeName: (context) => CartScreens(),
              OrdersScreens.routeName: (context) => OrdersScreens(),
              ProductOverviewScreens.routeName: (context) =>
                  ProductOverviewScreens(),
              UserProductScreen.routeName: (context) => UserProductScreen(),
              EditProductScreens.routeName: (context) => EditProductScreens(),
            },
          ),
        ));
  }
}
