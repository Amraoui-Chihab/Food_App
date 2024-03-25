

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:mr_yummy_v2/controller/firebasecontroller.dart';
import 'package:pinput/pinput.dart';

class otp extends StatefulWidget {
  const otp({Key? key}) : super(key: key);

  @override
  State<otp> createState() => _otpState();
}

class _otpState extends State<otp> {
  firebasecontroller controller = Get.find();
  bool isloading = false;

  String? otp;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 80 / 100,
                child: Image.asset(
                  "assets/sms.png",
                  fit: BoxFit.fitHeight,
                ),
                height: MediaQuery.of(context).size.height * 40 / 100,
              ),
            ),
            Center(
              child: Container(
                  child: Text(
                    "Verfication",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  height: MediaQuery.of(context).size.height * 8 / 100),
            ),
            Center(
              child: Container(
                  child: Text(
                    "أدخل كود التفعيل الذي تم إرساله إلى هاتفك ",
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 2 / 100,
                        fontWeight: FontWeight.bold),
                  ),
                  height: MediaQuery.of(context).size.height * 5 / 100),
            ),
            Center(
                child: Container(
              height: MediaQuery.of(context).size.height * 10 / 100,
              child: Pinput(
                defaultPinTheme: PinTheme(
                    height: MediaQuery.of(context).size.height * 10 / 100,
                    width: MediaQuery.of(context).size.width * 10 / 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.grey[400]),
                    textStyle: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.red)),
                onCompleted: ((value) {
                  setState(() {
                    otp = value;
                  });
                }),
                length: 6,
                showCursor: true,
              ),
            )),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 50 / 100,
                child: RaisedButton(
                    child: isloading == false
                        ? Text(
                            "التحقق",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          )
                        : CircularProgressIndicator(color: Colors.black),
                    color: Colors.red,
                    shape: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                        borderSide: BorderSide.none),
                    onPressed: () async {
                      if (otp != null) {
                        setState(() {
                          isloading = true;
                        });
                        await Future.delayed(Duration(seconds: 2), () {
                          controller.verifyOTP(
                              controller.verification_id!, otp!);
                          setState(() {
                            isloading = false;
                          });
                        });
                      } else {
                        Get.snackbar("خطأ", "",
                            messageText: Text("الرجاء إدخال 6 أرقام",
                                style: TextStyle(fontSize: 25)),
                            backgroundColor: Colors.red);
                      }
                    }),
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 5 / 100),
                height: MediaQuery.of(context).size.height * 10 / 100,
              ),
            )
          ],
        ),
        reverse: true,
      ),
    );
  }
}
