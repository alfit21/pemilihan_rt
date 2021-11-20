import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:pemilihan_rt/home/homePage.dart';
import 'package:pemilihan_rt/pemungutanSuara/PemungutanSuaraShowPasswordPage.dart';

class PemungutanSuaraController extends GetxController {
  TextEditingController psw = TextEditingController();

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  kirimData(id) async {
    DocumentReference editCalonRt = firestore.collection('calonRt').doc(id);
// ambil poin calon rt
    var dataCalonRt = await editCalonRt.get();
    int poin = (dataCalonRt.data() as Map<String, dynamic>)['poin'];
    // setelah dapat tambah 1
    int hasilPoint = poin + 1;

    // ambil total suara
    CollectionReference totalSuara = firestore.collection("poin");
    var data = await totalSuara.get();
    var idPoin = data.docs[0].id;
// setelah dapat ditambah1
    int hasilSuara = data.docs[0]['totalPoin'] + 1;
// proses edit point
    DocumentReference editPoint = firestore.collection('poin').doc(idPoin);

    try {
      await editCalonRt.update({
        "poin": hasilPoint,
      });

      await editPoint.update({
        "totalPoin": hasilSuara,
      });

      successMemilih();
    } catch (e) {
      Get.defaultDialog(
        title: e.toString(),
        onConfirm: () {
          Get.to(() => HomePage());
        },
        textConfirm: 'OK',
      );
    }
  }

  Future<QuerySnapshot<Object>> getData() async {
    CollectionReference calonRt = firestore.collection("calonRt");

    return calonRt.get();
  }

  successMemilih() {
    Get.defaultDialog(
      backgroundColor: Colors.teal,
      title: '',
      titleStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      buttonColor: Colors.white,
      content: Container(
        height: Get.height * 0.5,
        width: Get.width,
        child: Row(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: FittedBox(
                child: Text(
                  'Terimakasih, anda telah memilih'.toString(),
                  style: GoogleFonts.josefinSans(
                      textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Colors.white)),
                ),
              ),
            ),
            Lottie.asset('assets/lottie/jempolLike.json'),
          ],
        ),
      ),
    ).then((_) {
      Get.to(() => PemungutanSuaraShowPasswordPage());
    });
  }

  @override
  void onClose() {
    psw.dispose();
    super.onClose();
  }
}
