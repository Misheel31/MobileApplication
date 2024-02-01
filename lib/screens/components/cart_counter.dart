import 'package:flutter/material.dart';

class CartCounter extends StatelessWidget {
  final String quantity;
  final VoidCallback? onIncrease;
  final VoidCallback? onDecrease;

  const CartCounter({
    required this.quantity,
    this.onIncrease,
    this.onDecrease,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: Icon(Icons.remove),
          onPressed: onDecrease,
        ),
        Text(quantity),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: onIncrease,
        ),
      ],
    );
  }
}
