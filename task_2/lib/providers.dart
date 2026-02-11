import 'package:flutter/material.dart';

import 'models.dart';

class ProductProvider with ChangeNotifier {
  final List<Product> _products = [
    Product(id: '1', name: 'Men Shoes', price: 609, imagePath: 'assets/images/1.png'),
    Product(id: '2', name: 'Joggers', price: 980, imagePath: 'assets/images/2.png'),
    Product(id: '3', name: 'Sneakers', price: 65, imagePath: 'assets/images/3.png'),
    Product(id: '4', name: 'Shoes', price: 99, imagePath: 'assets/images/4.png'),
    Product(id: '5', name: 'Joggers', price: 401, imagePath: 'assets/images/5.png'),
  ];

  List<Product> get items => [..._products];
}

class CartProvider with ChangeNotifier {
  final List<Product> _cartItems = [];

  List<Product> get cartItems => _cartItems;

  void addToCart(Product product) {
    _cartItems.add(product);
    notifyListeners();
  }

  void removeFromCart(Product product) {
    _cartItems.remove(product);
    notifyListeners();
  }

  double get calculateTotal {
    return _cartItems.fold(0.0, (sum, item) => sum + item.price);
  }
}

class AuthProvider with ChangeNotifier {
  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  void login() {
    _isLoggedIn = true;
    notifyListeners();
  }
}