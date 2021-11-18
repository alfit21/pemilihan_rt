import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HasilSuaraController extends GetxController {
  TextEditingController psw = TextEditingController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Stream<QuerySnapshot<Object>> getData() {
    CollectionReference calonRt = firestore.collection("calonRt");
    return calonRt.orderBy('poin', descending: true).snapshots();
  }

  Stream<QuerySnapshot<Object>> jumlahPoin() {
    CollectionReference jumlahPoin = firestore.collection("poin");
    return jumlahPoin.snapshots();
  }

  @override
  void onClose() {
    psw.dispose();
    super.onClose();
  }
}
