import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';

import '../model/get_storage_key.dart';
import '../model/user_model.dart';

class FirestoreUtils {
  static final FirebaseFirestore _client = FirebaseFirestore.instance;
  final collectionUsers = _client
      .collection("users")
      .doc('gbuv')
      .collection(GetStorage().read(GetStorageKey.platform));

  //USERS

  Future<void> createUser(UserModel repertoryData) async {
    await collectionUsers
        .doc(repertoryData.uid)
        .set(repertoryData.toJson())
        .whenComplete(() => Fluttertoast.showToast(msg: "Donné ajouté"))
        .onError((error, stackTrace) => onError(error, stackTrace));
  }

  Future<void> updateUser(UserModel repertoryData) async {
    await collectionUsers
        .doc(repertoryData.uid)
        .set(repertoryData.toJson())
        .whenComplete(() => Fluttertoast.showToast(msg: "Donné modifié"))
        .onError((error, stackTrace) => onError(error, stackTrace));
  }

  Future<List<UserModel>> fetchUsers() async {
    List<UserModel> list = [];
    var documentSnapshot = await collectionUsers.get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs =
        documentSnapshot.docs;
    docs.forEach((e) {
      list.add(UserModel.fromJson(e.data()));
    });
    return list;
  }

  //ON ERROR
  Future<void> onError(Object? error, StackTrace stackTrace) async {
    if (error.toString().contains('TimeoutException')) {
      Fluttertoast.showToast(msg: "Mise en cache");
      return;
    }
    Fluttertoast.showToast(msg: "Erreur : $error");
  }
}
