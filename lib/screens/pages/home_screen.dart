import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:grocerystore/provider/productProvider.dart';
import 'package:grocerystore/screens/pages/CartPage.dart';
import 'package:provider/provider.dart';
import '../account/account_screen.dart';
import 'details_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ProductProvider _productProvider;
  int _currentIndex = 0;


  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _productProvider = Provider.of<ProductProvider>(context, listen: false);
      _productProvider.fetchProducts();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // FutureBuilder to wait for product data
          Consumer<ProductProvider>(
            builder: (context, snapshot, child) {
              return CarouselSlider(
                options: CarouselOptions(
                  height: 200.0,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  aspectRatio: 2.0,
                ),
                items: snapshot.productsList.map((e) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Builder(
                        builder: (context) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                              color: Colors.black26,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Image.asset(
                                    'assets/images/slider2.jpg',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  );
                }).toList(),
              );
            },
          ),
          // Products Text
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Products',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          // Products List
          Expanded(
            child: Consumer<ProductProvider>(
              builder: (context, value, child) {
                return ListView(
                  children: value.productsList.map((e) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailsScreen(
                              imageURL: e.data().imageURL ?? "",
                              description: e.data().description ?? "",
                              price: e.data().price ?? "",
                              name: e.data().name ?? "",
                            ),
                          ),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 20),
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              leading: Container(
                                child: Image.network(e.data().imageURL ?? ""),
                              ),
                              title: Text(e.data().name ?? ""),
                            ),
                            Text(
                              '${e.data().price ?? ""}',
                              style:
                              TextStyle(fontSize: 25, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          if (index == 1) {
            // Navigate to CartPage when the Cart icon is tapped
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CartPage(itemName: '', itemPrice: '', itemQuantity: '',),
              ),
            );
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
