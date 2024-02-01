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

//   CollectionReference<ProductModel> productRef =
//   FirebaseService.db.collection("products").withConverter<ProductModel>(
//     fromFirestore: (snapshot, _) {
//       return ProductModel.fromFirebaseSnapshot(snapshot);
//     },
//     toFirestore: (model, _) => model.toJson(),
//   );
//
//   Future<List<QueryDocumentSnapshot<ProductModel>>> getAllProducts() async {
//     try {
//       final response = await productRef.get();
//       var products = response.docs;
//       return products;
//     } catch (err) {
//       print(err);
//       rethrow;
//     }
//   }
//
//   Future<List<QueryDocumentSnapshot<ProductModel>>> getMyProducts(
//       String userId) async {
//     try {
//       final response =
//       await productRef.where("user_id", isEqualTo: userId).get();
//       var products = response.docs;
//       return products;
//     } catch (err) {
//       print(err);
//       rethrow;
//     }
//   }
//
// //
//   Future<bool?> addProducts({required ProductModel product}) async {
//     try {
//       final response = await productRef.add(product);
//       return true;
//     } catch (err) {
//       return false;
//     }
//   }
//
// //
//   Future<bool?> editProduct(
//       {required ProductModel product, required String productId}) async {
//     try {
//       final response = await productRef.doc(productId).set(product);
//       return true;
//     } catch (err) {
//       return false;
//     }
//   }
//
// //
//   Future<bool> removeProduct(String productId, String userId) async {
//     try {
//       final response = await productRef.doc(productId).get();
//       if (response.data()!.userId != userId) {
//         return false;
//       }
//       await productRef.doc(productId).delete();
//       return true;
//     } catch (err) {
//       print(err);
//       rethrow;
//     }
//   }
//
// //
//   Future<List<QueryDocumentSnapshot<ProductModel>>> getProductFromList(
//       List<String> productIds) async {
//     try {
//       final response = await productRef
//           .where(FieldPath.documentId, whereIn: productIds)
//           .get();
//       var products = response.docs;
//       return products;
//     } catch (err) {
//       print(err);
//       rethrow;
//     }
//   }
// }
//   //
// //
