import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:pemilihan_rt/hasilSuara/hasilSuaraShowPasswordPage.dart';
import 'package:pemilihan_rt/home/homeController.dart';
import 'package:pemilihan_rt/pemungutanSuara/PemungutanSuaraShowPasswordPage.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class HomePage extends StatelessWidget {
  final c = Get.lazyPut<HomeController>(() => HomeController());
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.landscapeLeft,
      ],
    );
    final homeC = Get.find<HomeController>();

    return Obx(
      () => WillPopScope(
        onWillPop: () async {
          return Get.defaultDialog(
            backgroundColor: Color(0XFFC996CC),
            title: '',
            middleText: 'Anda akan keluar?',
            onConfirm: () {
              SystemNavigator.pop();
            },
            onCancel: () {
              return false;
            },
          ).then((value) => false);
        },
        child: Scaffold(
          backgroundColor: Color(0XFFC996CC),
          bottomNavigationBar: SalomonBottomBar(
            currentIndex: homeC.currentIndex.value,
            onTap: (i) {
              if (i == 2) {
                Get.to(() => PemungutanSuaraShowPasswordPage());
              } else {
                homeC.currentIndex.value = i;
              }
            },
            items: [
              SalomonBottomBarItem(
                icon: Icon(Icons.home),
                title: Text("Home"),
                selectedColor: Color(0XFF1E5128),
              ),
              SalomonBottomBarItem(
                icon: Icon(Icons.view_list_sharp),
                title: Text("Hasil Suara"),
                selectedColor: Colors.purple,
              ),
              SalomonBottomBarItem(
                icon: Icon(Icons.recent_actors),
                title: Text("Pemungutan Suara"),
                selectedColor: Colors.pink,
              ),
            ],
          ),
          body: homeC.currentIndex.value == 0
              ? SafeArea(
                  child: Container(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8, right: 8),
                            child: FittedBox(
                              child: Text(
                                'Selamat datang disistem pemilihan rt 6/8 Jatijajar - Tapos - Depok',
                                style: GoogleFonts.arvo(
                                    textStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Colors.white)),
                              ),
                            ),
                          ),
                          Expanded(
                            child: SizedBox(
                                height: MediaQuery.of(context).size.width * 0.7,
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: Card(
                                  color: Color(0XFFF0E3E3),
                                  child: Stack(
                                    children: [
                                      Align(
                                        alignment: Alignment.center,
                                        child: Container(
                                          height: double.infinity,
                                          width: double.infinity,
                                          child: Lottie.asset(
                                            'assets/lottie/kumpulanorangngobrol.json',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topCenter,
                                        child: SizedBox(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              StreamBuilder<QuerySnapshot>(
                                                stream: homeC.jumlahPoin(),
                                                builder: (context, snapshot) {
                                                  if (snapshot
                                                          .connectionState ==
                                                      ConnectionState.active) {
                                                    var poin =
                                                        snapshot.data.docs;
                                                    Map<String, dynamic>
                                                        dataPoin =
                                                        poin[0].data();
                                                    return Text(
                                                      dataPoin['totalPoin']
                                                          .toString(),
                                                      style: GoogleFonts.arvo(
                                                          textStyle: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 80,
                                                              color: Color(
                                                                  0XFF3F3351))),
                                                    );
                                                  }
                                                  return Container();
                                                },
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                'Total Suara Pemilih',
                                                style: GoogleFonts.arvo(
                                                    textStyle: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 25,
                                                        color:
                                                            Color(0XFF3F3351))),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                        ],
                      )),
                )
              : HasilSuaraShowPasswordPage(),
        ),
      ),
    );
  }
}
