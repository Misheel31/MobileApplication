import 'package:flutter/cupertino.dart';

import '../model/CartModel.dart';

class CartViewModel with ChangeNotifier {
  CartModel _cartModel = CartModel();

  CartModel get cartModel => _cartModel;

  void addToCart(String itemName, int quantity, String price) {
    _cartModel.addItem(itemName, quantity, price);
    notifyListeners();
  }

  void removeFromCart(String itemName) {
    _cartModel.removeItem(itemName);
    notifyListeners();
  }

}
