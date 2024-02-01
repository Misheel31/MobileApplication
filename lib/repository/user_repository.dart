import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../model/user_model.dart';
import '../services/firebase_service.dart';

class AuthRepository {
  CollectionReference<UserModel> userRef =
  FirebaseService.db.collection("User").withConverter<UserModel>(
    fromFirestore: (snapshot, _) {
      return UserModel.fromFirebaseSnapshot(snapshot);
    },
    toFirestore: (model, _) => model.toJson(),
  );
  Future<UserCredential?> register(UserModel user) async {
    try {
      final response =
      await userRef.where("username", isEqualTo: user.username!).get();
      if (response.size != 0) {
        throw Exception("Username already exists");
      }
      UserCredential uc = await FirebaseService.firebaseAuth
          .createUserWithEmailAndPassword(
          email: user.email!, password: user.password!);

      user.username = uc.user!.uid;
      // insert into firestore user table
      await userRef.doc(uc.user!.uid).set(user);
      return uc;
    } catch (err) {
      rethrow;
    }
  }

  Future<UserCredential> login(String email, String password) async {
    try {
      UserCredential uc = await FirebaseService.firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return uc;
    } catch (err) {
      rethrow;
    }
  }

  Future<UserModel> getUserDetail(String id, String? token) async {
    try {

      final response = await userRef.doc(id).get();
      var user = response.data()!;
      await userRef.doc(user.username).set(user);
      return user;
    } catch (err) {
      rethrow;
    }
  }

  Future<bool> resetPassword(String email) async {
    try {
      var res = await FirebaseService.firebaseAuth
          .sendPasswordResetEmail(email: email);
      return true;
    } catch (err) {
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      await FirebaseService.firebaseAuth.signOut();
    } catch (err) {
      rethrow;
    }
  }
}

class UserRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserModel?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      UserModel? user = result.user != null
          ? UserModel(userId: result.user!.uid, username: result.user!.displayName ?? "")
          : null;

      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
