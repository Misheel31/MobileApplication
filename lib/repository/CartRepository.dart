
import '../model/CartModel.dart';

class CartRepository {
  final CartModel _cartModel = CartModel();

  void addToCart(String itemName, int quantity, String price) {
    _cartModel.addItem(itemName, quantity, price);
  }

  CartModel getCart() {
    return _cartModel;
  }

}
