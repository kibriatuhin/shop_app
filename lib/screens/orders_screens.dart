import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/orders.dart';
import 'package:shop_app/models/orders.dart' as or;
import 'package:shop_app/widgets/app_drawer.dart';
import 'package:shop_app/widgets/order_item_widgets.dart';

class OrdersScreens extends StatelessWidget {
  static const routeName = "/order";

  @override
  Widget build(BuildContext context) {
    //final orderData = Provider.of<or.Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Your Orders",
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: Provider.of<Orders>(context, listen: false).fatchAndSetOrders(),
        builder: (contex, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.error != null) {
              return Center(
                child: Text("Have an error"),
              );
            } else {
              return Consumer<Orders>(
                builder: (context, orderData, child) => ListView.builder(
                  itemBuilder: (context, index) => OrderItemWidget(
                    order: orderData.orders[index],
                  ),
                  itemCount: orderData.orders.length,
                ),
              );
            }
          }
        },
      ),
    );
  }
}
