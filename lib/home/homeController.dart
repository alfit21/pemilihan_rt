import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var currentIndex = 0.obs;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Object>> jumlahPoin() {
    CollectionReference jumlahPoin = firestore.collection("poin");
    return jumlahPoin.snapshots();
  }

  @override
  void onInit() {
    currentIndex.value = 0;
    super.onInit();
  }
}
