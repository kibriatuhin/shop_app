import 'package:flutter/material.dart';
import 'package:shop_app/models/cart.dart';
import 'package:shop_app/screens/cart_screens.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import 'package:shop_app/widgets/badge.dart';

import 'package:shop_app/widgets/grid_items.dart';
import 'package:provider/provider.dart';

enum FavoriteOption { favoriteOnly, showAll }

class ProductOverviewScreens extends StatefulWidget {
  static const routeName = "/shop";
  ProductOverviewScreens({Key? key}) : super(key: key);

  @override
  State<ProductOverviewScreens> createState() => _ProductOverviewScreensState();
}

class _ProductOverviewScreensState extends State<ProductOverviewScreens> {
  var _showfavoriteItems = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("My"),
            Text(
              "Shop",
              style: TextStyle(color: Colors.redAccent),
            ),
          ],
        ),
        actions: [
          Consumer<Cart>(
              builder: (contex, cart, ch) => Badge(
                    child: IconButton(
                      onPressed: (){
                        Navigator.of(context).pushNamed(CartScreens.routeName);
                      },
                      icon: Icon(Icons.shopping_cart,color: Colors.redAccent,),
                    ),
                    value: cart.itemCount.toString(),
                    color: Colors.redAccent,
                  ),

          ),
          PopupMenuButton(
            onSelected: (FavoriteOption selectedOption) {
              setState(() {
                if (selectedOption == FavoriteOption.favoriteOnly) {
                  _showfavoriteItems = true;
                } else {
                  _showfavoriteItems = false;
                }
              });
            },
            icon: Icon(Icons.more_vert_rounded),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text("Only Favorite"),
                value: FavoriteOption.favoriteOnly,
              ),
              PopupMenuItem(
                child: Text("Show All"),
                value: FavoriteOption.showAll,
              ),
            ],
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: GridItems(
        favoriteItems: _showfavoriteItems,
      ),
    );
  }
}
