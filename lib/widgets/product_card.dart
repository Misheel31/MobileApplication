import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String name;
  final double price;

  ProductCard({required this.name, required this.price});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10.0),
      child: ListTile(
        title: Text(name),
        subtitle: Text('\$${price.toString()}'),
        trailing: IconButton(
          icon: Icon(Icons.add_shopping_cart),
          onPressed: (

              ) {

            // Implement cart functionality (add item to cart)
          },
        ),
      ),
    );
  }
}
