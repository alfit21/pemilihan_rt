import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pemilihan_rt/hasilSuara/hasilSUaraPage.dart';
import 'package:pemilihan_rt/hasilSuara/hasilSuaraController.dart';

class HasilSuaraShowPasswordPage extends StatelessWidget {
  final c = Get.lazyPut<HasilSuaraController>(() => HasilSuaraController());
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.landscapeLeft,
      ],
    );
    final hasilSuaraC = Get.find<HasilSuaraController>();
    return Scaffold(
      backgroundColor: Color(0XFF5C5470),
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          child: SizedBox(
              height: Get.height * 0.8,
              width: Get.width * 0.9,
              child: Card(
                color: Color(0xffBDB8E3),
                child: Center(
                  child: Stack(
                    children: [
                      Lottie.asset(
                        'assets/lottie/password.json',
                        fit: BoxFit.cover,
                        height: double.infinity,
                        width: double.infinity,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            TextField(
                              onTap: () {
                                hasilSuaraC.psw.text = '';
                              },
                              controller: hasilSuaraC.psw,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                color: Colors.white,
                              ),
                              obscuringCharacter: '*',
                              obscureText: true,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: 'Masukan password...',
                                labelStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                  color: Color(0XFF3E065F),
                                ),
                              ),
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  if (hasilSuaraC.psw.text == '068') {
                                    Get.focusScope.unfocus();
                                    hasilSuaraC.psw.text = '';
                                    Get.offAll(() => HasilSuaraPage());
                                  } else {
                                    Get.focusScope.unfocus();
                                    hasilSuaraC.psw.text = '';
                                    Get.defaultDialog(
                                        backgroundColor: Colors.cyan,
                                        title: 'Info',
                                        middleText: 'Password Salah..',
                                        middleTextStyle: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                        titleStyle: TextStyle(
                                            color: Colors.white, fontSize: 20));
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.purple,
                                ),
                                child: Text('Ok'))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
