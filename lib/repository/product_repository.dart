import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grocerystore/model/productModel.dart';


class ProductRepository {
  final instance = FirebaseFirestore.instance.collection('Products')
      .withConverter(fromFirestore: (snapshot, options) =>
      ProductModel.fromJson(snapshot.data() as Map<String, dynamic>),
    toFirestore: (ProductModel value, options) => value.toJson(),);

  Future<List<QueryDocumentSnapshot<ProductModel>>> getData(
      List<dynamic> list) async {
    try {
      final res = (await instance.get()).docs;
      return res;
    } on Exception catch (e) {
      print(e.toString());
      // TODO
    }
    return [];
  }

}
