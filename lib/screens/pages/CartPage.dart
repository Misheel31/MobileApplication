import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/CartModel.dart';
import '../../viewmodels/cartViewModel.dart';
import '../components/cart_counter.dart';

class CartPage extends StatelessWidget {
  final String itemName;
  final String itemPrice;
  final String itemQuantity;

  // Add the constructor with named parameters
  const CartPage({
    Key? key,
    required this.itemName,
    required this.itemPrice,
    required this.itemQuantity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CartViewModel cartViewModel = context.watch<CartViewModel>();
    CartModel cartModel = cartViewModel.cartModel;

    return Scaffold(
      appBar: AppBar(
        title: Text('Cart Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Cart Items: ${cartModel.getTotalItems()}'),
            Column(
              children: cartModel.items.keys.map((itemName) {
                int quantity = cartModel.getItemQuantity(itemName);
                double totalPrice = cartModel.getItemTotalPrice(itemName).toDouble();

                return ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('$itemName - Quantity: $quantity'),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.remove),
                            onPressed: () {
                              cartViewModel.decrementQuantity(itemName);
                            },
                          ),
                          Text('$quantity'),
                          IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () {
                              cartViewModel.incrementQuantity(itemName);
                            },
                          ),
                        ],
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          cartViewModel.removeFromCart(itemName);
                        },
                      ),
                    ],
                  ),
                  subtitle: Text('Total Price: \$${totalPrice.toStringAsFixed(2)}'),
                );
              }).toList(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/home');
          } else if (index == 2) {
            Navigator.pushReplacementNamed(context, '/profile');
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
