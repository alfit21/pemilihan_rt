import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pemilihan_rt/home/homePage.dart';
import 'package:pemilihan_rt/pemungutanSuara/PemungutanSuaraController.dart';
import 'package:pemilihan_rt/pemungutanSuara/PemungutanSuaraPage.dart';

class PemungutanSuaraShowPasswordPage extends StatelessWidget {
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
        body: SafeArea(
          child: Container(
            alignment: Alignment.center,
            child: masukanPassword(pemungutanSuaraC),
          ),
        ),
      ),
    );
  }

  SizedBox masukanPassword(PemungutanSuaraController pemungutanSuaraC) {
    return SizedBox(
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
                          pemungutanSuaraC.psw.text = '';
                        },
                        controller: pemungutanSuaraC.psw,
                        autofocus: true,
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
                            if (pemungutanSuaraC.psw.text == '068') {
                              Get.focusScope.unfocus();
                              pemungutanSuaraC.psw.text = '';
                              Get.offAll(() => PemungutanSuaraPage());
                            } else if (pemungutanSuaraC.psw.text == '111') {
                              Get.focusScope.unfocus();
                              pemungutanSuaraC.psw.text = '';
                              Get.offAll(() => HomePage());
                            } else {
                              Get.focusScope.unfocus();
                              pemungutanSuaraC.psw.text = '';
                              Get.offAll(
                                  () => PemungutanSuaraShowPasswordPage());
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
        ));
  }
}
