import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/auth.dart';
import 'package:shop_app/screens/orders_screens.dart';
import 'package:shop_app/screens/product_overview_screens.dart';
import 'package:shop_app/screens/user_product_screen.dart';
class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text("Hello Friend! "),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text("Shop"),
            onTap: (){
              Navigator.of(context).pushReplacementNamed(ProductOverviewScreens.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text("Orders"),
            onTap: (){
              Navigator.of(context).pushReplacementNamed(OrdersScreens.routeName);
            },

          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.mode_edit),
            title: Text("Manage Products"),
            onTap: (){
              Navigator.of(context).pushReplacementNamed(UserProductScreen.routeName);
            },

          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text("Logout"),
            onTap: (){
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/');
              Provider.of<Auth>(context,listen: false).logout();
            },

          )
        ],
      ),
    );
  }
}
