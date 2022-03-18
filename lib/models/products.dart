import 'package:flutter/material.dart';
import 'package:shop_app/models/product.dart';

class Products with ChangeNotifier{
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Red T-Shirt',
      description: 'Batter quality of world',
      price: 29.99,
      imageUrl: 'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Black T-Shirt',
      description: 'A nice pair of Shirt.',
      price: 59.99,
      imageUrl:'https://images.unsplash.com/photo-1583743814966-8936f5b7be1a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80',
    ),
    Product(
      id: 'p3',
      title: 'Shirt',
      description: 'A Chicken - A nice food!',
      price: 19.99,
      imageUrl:  'https://images.unsplash.com/photo-1596755094514-f87e34085b2c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=388&q=80',
    ),
    Product(
      id: 'p4',
      title: 'Formal Shirt',
      description: 'A Pizza - A nice food!',
      price: 49.99,
      imageUrl: 'https://images.unsplash.com/photo-1598032895397-b9472444bf93?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=580&q=80',
    ),
    Product(
      id: 'p4',
      title: 'Styling Shirt',
      description: 'A Sandwich - A good food.',
      price: 49.99,
      imageUrl: 'https://images.unsplash.com/photo-1607345366928-199ea26cfe3e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80',
    ),
  ];
//

 /* //favorite product screen
  void favoriteItems(){
    _showFavoriteScreens = true;
    notifyListeners();
  }
  //all product screen
  void showAll(){
    _showFavoriteScreens = false;
    notifyListeners();
  }*/

  List<Product> get items{
  /*  if(_showFavoriteScreens){
      return _items.where((prouductId) => prouductId.isFavorite).toList();
    }*/
    return [..._items];

  }
  //favorite items
  List<Product> get favoriteItems{
    return _items.where((element) => element.isFavorite).toList();

  }
  Product findById(String id){
    return _items.firstWhere((element) => element.id == id);

  }
  void addProduct(){
    //..
    notifyListeners();
  }
}