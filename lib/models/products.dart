import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shop_app/models/http_exception.dart';
import 'package:shop_app/models/product.dart';
import 'package:http/http.dart' as http;

class Products with ChangeNotifier {
  List<Product> _items = [
    /*  Product(
      id: 'p1',
      title: 'Red T-Shirt',
      description: 'Batter quality of world',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Black T-Shirt',
      description: 'A nice pair of Shirt.',
      price: 59.99,
      imageUrl:
          'https://images.unsplash.com/photo-1583743814966-8936f5b7be1a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80',
    ),
    Product(
      id: 'p3',
      title: 'Shirt',
      description: 'A Chicken - A nice food!',
      price: 19.99,
      imageUrl:
          'https://images.unsplash.com/photo-1596755094514-f87e34085b2c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=388&q=80',
    ),
    Product(
      id: 'p4',
      title: 'Formal Shirt',
      description: 'A Pizza - A nice food!',
      price: 49.99,
      imageUrl:
          'https://images.unsplash.com/photo-1598032895397-b9472444bf93?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=580&q=80',
    ),
    Product(
      id: 'p5',
      title: 'Styling Shirt',
      description: 'A Sandwich - A good food.',
      price: 49.99,
      imageUrl:
          'https://images.unsplash.com/photo-1607345366928-199ea26cfe3e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80',
    ),*/
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

  List<Product> get items {
    /*  if(_showFavoriteScreens){
      return _items.where((prouductId) => prouductId.isFavorite).toList();
    }*/
    return [..._items];
  }

  //favorite items
  List<Product> get favoriteItems {
    return _items.where((element) => element.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  Future<void> fatchAndSetProduct() async {
    const url =
        'https://flutter-update-55935-default-rtdb.firebaseio.com/products.json';

    try {
      final response = await http.get(Uri.parse(url));

      // print(json.decode(response.body));
      final extractData = json.decode(response.body) as Map<String, dynamic>;
      if(extractData == null){
        return;
      }
      final List<Product> loadedProduct = [];
      extractData.forEach((prodId, prodData) {
        loadedProduct.add(
          Product(
            id: prodId,
            title: prodData['title'],
            description: prodData['description'],
            price: prodData['price'],
            imageUrl: prodData['imageUrl'],
            isFavorite: prodData['isFavorite'],
          ),
        );
        _items = loadedProduct;
        notifyListeners();
      });
    } catch (e) {
      throw e;
    }
  }

  Future<void> addProduct(Product product) async {
    const url =
        'https://flutter-update-55935-default-rtdb.firebaseio.com/products.json';
    try {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode(
          {
            "title": product.title,
            "description": product.description,
            "price": product.price,
            "imageUrl": product.imageUrl,
            "isFavorite": false,
          },
        ),
      );
      //print(json.decode(response.body));
      final newProduct = Product(
        id: json.decode(response.body)['name'],
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
      );
      _items.add(newProduct);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> updateProduct(String id, Product newProduct) async {
    final productIndex = _items.indexWhere((element) => element.id == id);
    if (productIndex >= 0) {
      final url =
          'https://flutter-update-55935-default-rtdb.firebaseio.com/products/$id.json';
      try {
        await http.patch(Uri.parse(url),
            body: json.encode({
              "title": newProduct.title,
              "description": newProduct.description,
              "price": newProduct.price,
              "imageUrl": newProduct.imageUrl,
            }));
      } catch (e) {
        print(e);
      }
      _items[productIndex] = newProduct;
    } else {
      print('...');
    }

    notifyListeners();
  }

  Future<void> deleteProduct(String id) async {
    final url =
        'https://flutter-update-55935-default-rtdb.firebaseio.com/products/$id.json';
    final existingProductIndex =
        _items.indexWhere((element) => element.id == id);
    Product? existingProduct = _items[existingProductIndex];
    _items.removeAt(existingProductIndex);
    notifyListeners();

    final response = await http.delete(Uri.parse(url));

    if (response.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException("Could not delete product.");
    }
    //print(response.statusCode);
    existingProduct = null;
  }
}
