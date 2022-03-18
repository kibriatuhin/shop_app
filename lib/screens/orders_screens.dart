import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/orders.dart';
import 'package:shop_app/models/orders.dart' as or;
import 'package:shop_app/widgets/app_drawer.dart';
import 'package:shop_app/widgets/order_item_widgets.dart';

class OrdersScreens extends StatelessWidget {
  static const routeName = "/order";
  const OrdersScreens({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<or.Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Your Orders",
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemBuilder: (context, index) => OrderItemWidget(order: orderData.orders[index],),
        itemCount: orderData.orders.length,
      ),
    );
  }
}
