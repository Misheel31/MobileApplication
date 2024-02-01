import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocerystore/model/productModel.dart';
import 'package:grocerystore/repository/product_repository.dart';

class ProductViewModel with ChangeNotifier {
  ProductRepository _productRepository = ProductRepository();
  List<ProductModel> _product = [];
  List<ProductModel> get product => _product;
  Future<void> getCategories() async {
    _product = [];
    try {
      var response = await _productRepository.getData(product);
      for (var element in response) {
        print(element.id);
        _product.add(element.data());
      }
      notifyListeners();
    } catch (e) {
      print(e);
      _product = [];
      notifyListeners();
    }
  }
}
