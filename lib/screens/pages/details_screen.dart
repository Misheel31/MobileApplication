import 'package:flutter/material.dart';
import 'package:grocerystore/screens/pages/CartPage.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../viewmodels/cartViewModel.dart';
import '../components/cart_counter.dart';
import '../components/price.dart';

class DetailsScreen extends StatefulWidget {
  final String imageURL;
  final String description;
  final String price;
  final String name;

  const DetailsScreen({
    Key? key,
    required this.imageURL,
    required this.description,
    required this.price,
    required this.name,
  }) : super(key: key);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  int _counter = 1;

  double parsePrice(String price) {
    String cleanedPrice = price.replaceAll(RegExp(r'[^0-9.]'), '');
    return double.tryParse(cleanedPrice) ?? 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CartViewModel(),
      child: Scaffold(
        bottomNavigationBar: SafeArea(
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  CartViewModel cartViewModel = context.read<CartViewModel>();
                  cartViewModel.addToCart(widget.name, _counter, widget.price);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CartPage(
                        itemName: widget.name,
                        itemPrice: parsePrice(widget.price).toString(),
                        itemQuantity: _counter.toString(),
                      ),
                    ),
                  );
                },
                child: Text("Add to Cart"),
              ),
            ),
          ),
        ),
        backgroundColor: Colors.white,
        appBar: buildAppBar(),
        body: Column(
          children: [
            AspectRatio(
              aspectRatio: 1.37,
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Positioned(
                    bottom: 20,
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(widget.imageURL),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            CartCounter(quantity: _counter.toString(),
                onIncrease: () {
                  setState(() {
                    _counter++;
                  });
                },
                onDecrease: () {
                if (_counter > 1) {
                  setState(() {
                  _counter--;
                  });
                }
            }
            ),
            SizedBox(height: defaultPadding * 1.5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Row(
                children: [
                  Price(amount: widget.price),
                ],
              ),
            ),
            SizedBox(height: defaultPadding),
            Text(
              widget.description,
              style: TextStyle(
                fontSize: 14,
                color: Colors.blueGrey,
                fontWeight: FontWeight.normal,
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      leading: BackButton(
        color: Colors.black,
      ),
      backgroundColor: Color(0xFFF8F8F8),
      elevation: 0,
      centerTitle: true,
      title: Text(
        widget.name,
        style: TextStyle(color: Colors.black),
      ),

    );
  }
}
