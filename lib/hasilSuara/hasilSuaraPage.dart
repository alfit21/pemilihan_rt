import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:pemilihan_rt/hasilSuara/hasilSuaraController.dart';
import 'package:pemilihan_rt/home/homePage.dart';

class HasilSuaraPage extends StatelessWidget {
  final c = Get.lazyPut<HasilSuaraController>(() => HasilSuaraController());
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.landscapeLeft,
      ],
    );
    final hasilSuaraC = Get.find<HasilSuaraController>();
    return WillPopScope(
      onWillPop: () async {
        return Get.offAll(() => HomePage());
      },
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xffBDB8E3),
          onPressed: () {
            Get.offAll(() => HomePage());
          },
          child: Icon(
            Icons.arrow_back_ios_rounded,
            size: 30,
            color: Colors.white,
          ),
        ),
        backgroundColor: Color(0XFF5C5470),
        body: Container(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: hasilSuaraC.jumlahPoin(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.active) {
                        var poin = snapshot.data.docs;
                        Map<String, dynamic> dataPoin = poin[0].data();
                        return Text(
                          'Total suara ' + dataPoin['totalPoin'].toString(),
                          style: GoogleFonts.josefinSans(
                              textStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                  color: Colors.white)),
                        );
                      }
                      return Container();
                    },
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: hasilSuaraC.getData(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.active) {
                        var listAllDocs = snapshot.data.docs;

                        return SizedBox(
                          height: Get.height * 0.6,
                          width: Get.width * 0.9,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: listAllDocs.length,
                            itemBuilder: (context, index) {
                              Map<String, dynamic> data =
                                  listAllDocs[index].data();
                              return SizedBox(
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
                                              height: 100,
                                              width: 100,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          SizedBox(height: 5),
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
                                          SizedBox(height: 5),
                                          Expanded(
                                            child: FittedBox(
                                              child: Text(
                                                data['poin'].toString(),
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  color: Color(0XFF5C5470),
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
