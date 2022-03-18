import 'package:flutter/material.dart';
import 'package:shop_app/models/cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItems> products;
  final DateTime dateTime;

  OrderItem({
    required this.id,
    required this.amount,
    required this.products,
    required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }
  int get ordersCount{
    return _orders.length;
  }

  void addOrder(List<CartItems> cardProduct, double total) {
    _orders.insert(
        0,
        OrderItem(
          id: DateTime.now().toString(),
          amount: total,
          products: cardProduct,
          dateTime: DateTime.now(),
        ));
    notifyListeners();
  }
}
