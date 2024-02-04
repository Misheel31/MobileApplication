class CartModel {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items => _items;

  num parsePrice(String price) {
    return double.tryParse(price.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0.0;
  }

  void addItem(String name, int quantity, String price) {
    if (_items.containsKey(name)) {
      _items[name]!.quantity += quantity;
    } else {
      _items[name] = CartItem(name: name, quantity: quantity, price: parsePrice(price));
    }
  }

  void removeItem(String name) {
    _items.remove(name);
  }

  void updateQuantity(String name, int quantity) {
    if (_items.containsKey(name)) {
      _items[name]!.quantity = quantity;
    }
  }

  int getTotalItems() {
    return _items.values.fold(0, (sum, item) => sum + item.quantity);
  }

  int getItemQuantity(String name) {
    return _items[name]?.quantity ?? 0;
  }

  num getItemTotalPrice(String name) {
    return _items[name]?.totalPrice ?? 0;
  }

  void incrementItemQuantity(String itemName) {
    if (_items.containsKey(itemName)) {
      _items[itemName]!.quantity++;
    }
  }

  void decrementItemQuantity(String itemName) {
    if (_items.containsKey(itemName) && _items[itemName]!.quantity > 1) {
      _items[itemName]!.quantity--;
    } else if (_items.containsKey(itemName) && _items[itemName]!.quantity == 1) {
      removeItem(itemName);
    }
  }
}

class CartItem {
  String name;
  int quantity;
  num price;

  CartItem({required this.name, required this.quantity, required this.price});

  num get totalPrice => quantity * price;
}
