import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:pemilihan_rt/pemungutanSuara/PemungutanSuaraController.dart';

class PemungutanSuaraPage extends StatelessWidget {
  final c =
      Get.lazyPut<PemungutanSuaraController>(() => PemungutanSuaraController());
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.landscapeLeft,
      ],
    );
    final pemungutanSuaraC = Get.find<PemungutanSuaraController>();
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: Color(0XFF5C5470),
        body: Container(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  child: FittedBox(
                    child: Text(
                      'Untuk memilih silakan sentuh gambar atau nama',
                      style: GoogleFonts.josefinSans(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 35,
                              color: Colors.white)),
                    ),
                  ),
                ),
                FutureBuilder<QuerySnapshot>(
                  future: pemungutanSuaraC.getData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      var listAllDocs = snapshot.data.docs;
                      return SizedBox(
                        height: Get.height * 0.7,
                        width: Get.width * 0.9,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: listAllDocs.length,
                          itemBuilder: (context, index) {
                            Map<String, dynamic> data =
                                listAllDocs[index].data();
                            return TextButton(
                              onPressed: () {
                                pemungutanSuaraC.kirimData(
                                  listAllDocs[index].id,
                                );
                              },
                              child: SizedBox(
                                width: 215,
                                child: Card(
                                    color: Color(0xffBDB8E3),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          ClipOval(
                                            child: Image.network(
                                              data['urlGambar'].toString(),
                                              height: 180,
                                              width: 180,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          Expanded(
                                            child: FittedBox(
                                              child: Text(
                                                data['nama'].toString(),
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                              ),
                            );
                          },
                        ),
                      );
                    }
                    return Center(
                      child: Lottie.asset('assets/lottie/loadingText.json'),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
