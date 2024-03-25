import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:mr_yummy_v2/controller/firebasecontroller.dart';
import 'package:mr_yummy_v2/controller/usermodel.dart';
import 'package:mr_yummy_v2/main.dart';
import 'package:mr_yummy_v2/otp_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class sign_up extends StatefulWidget {
  const sign_up({Key? key}) : super(key: key);

  @override
  State<sign_up> createState() => _sign_upState();
}

class _sign_upState extends State<sign_up> {
  final RegExp regex = RegExp(r"^(0)(5|6|7)[0-9]{8}$");

  final controller1 = TextEditingController();
  final controller2 = TextEditingController();
  final controller3 = TextEditingController();
  firebasecontroller controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        reverse: true,
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Center(
              child: Container(
                child: Image.asset(
                  "assets/logo.png",
                  scale: 2,
                ),
                height: MediaQuery.of(context).size.height * 20 / 100,
              ),
            ),
            Center(
              child: Container(
                child: Text("مرحبا بك عند مستر يامي \n إنشاء حساب",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 4 / 100,
                      fontWeight: FontWeight.bold,
                    )),
                height: MediaQuery.of(context).size.height * 10 / 100,
              ),
            ),
            Center(
              child: Container(
                height: MediaQuery.of(context).size.height * 4 / 100,
                padding: EdgeInsets.only(
                    right: MediaQuery.of(context).size.width * 5 / 100),
                width: MediaQuery.of(context).size.width,
                child: Text(
                  "الإسم",
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.height * 3 / 100),
                ),
              ),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 1 / 100,
                    bottom: MediaQuery.of(context).size.height * 1 / 100),
                width: MediaQuery.of(context).size.width * 90 / 100,
                child: TextFormField(
                    controller: controller1,
                    cursorColor: Colors.red,
                    textDirection: TextDirection.rtl,
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.red, width: 2)),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 2)))),
                height: MediaQuery.of(context).size.height * 10 / 100,
              ),
            ),
            Center(
              child: Container(
                height: MediaQuery.of(context).size.height * 4 / 100,
                padding: EdgeInsets.only(
                    right: MediaQuery.of(context).size.width * 5 / 100),
                width: MediaQuery.of(context).size.width,
                child: Text(
                  "اللقب",
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.height * 3 / 100),
                ),
              ),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 1 / 100,
                    bottom: MediaQuery.of(context).size.height * 1 / 100),
                width: MediaQuery.of(context).size.width * 90 / 100,
                child: TextFormField(
                  controller: controller2,
                  cursorColor: Colors.red,
                  textDirection: TextDirection.rtl,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 2)),
                      border:
                          OutlineInputBorder(borderSide: BorderSide(width: 2))),
                ),
                height: MediaQuery.of(context).size.height * 10 / 100,
              ),
            ),
            Center(
              child: Container(
                padding: EdgeInsets.only(
                    right: MediaQuery.of(context).size.width * 5 / 100),
                width: MediaQuery.of(context).size.width,
                child: Text(
                  "رقم الهاتف",
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.height * 3 / 100),
                ),
                height: MediaQuery.of(context).size.height * 5 / 100,
              ),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 2 / 100,
                ),
                width: MediaQuery.of(context).size.width * 90 / 100,
                child: TextFormField(
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                  controller: controller3,
                  cursorColor: Colors.red,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 2)),
                      border:
                          OutlineInputBorder(borderSide: BorderSide(width: 2))),
                  textDirection: TextDirection.rtl,
                ),
                height: MediaQuery.of(context).size.height * 10 / 100,
              ),
            ),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 50 / 100,
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 5.5 / 100,
                    bottom: MediaQuery.of(context).size.height * 5.5 / 100),
                child: RaisedButton(
                    color: Colors.red,
                    shape: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                        borderSide: BorderSide.none),
                    onPressed: () async {
                      if (controller1.text == "" ||
                          controller2.text == "" ||
                          controller3.text == "") {
                        Get.snackbar("خطأ", "",
                            messageText: Text("الرجاء إدخال جميع البيانات",
                                style: TextStyle(fontSize: 25)),
                            backgroundColor: Colors.red);
                        print("controller one : ${controller1.text}");
                        print("controller two : ${controller2.text}");
                        print("controller three : ${controller3.text}");
                      } else {
                        if (!regex.hasMatch(controller3.text)) {
                          Get.snackbar("Error", "",
                              messageText: Text(
                                "الرجاء إدخال رقم هاتف صحيح",
                                style: TextStyle(fontSize: 25),
                              ),
                              backgroundColor: Colors.red);
                        } else {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return Center(
                                  child: CircularProgressIndicator(
                                      color: Colors.red),
                                );
                              });

                          if (await controller
                              .isPhoneNumberUnique(controller3.text)) {
                            controller.user = usermodel(
                                name: controller1.text,
                                last_name: controller2.text,
                                phone_number: controller3.text);
                            await controller.phone_auth(controller.user!);
                          } else {
                            Get.snackbar("خطأ", "",
                                messageText: Text(
                                    "رقم الهاتف خاص بمستخدم اخر لا تستطيع التسجيل به",
                                    style: TextStyle(fontSize: 25)),
                                backgroundColor: Colors.red);
                            Navigator.of(context).pop();
                          }
                        }
                      }
                    },
                    child: Text(
                      "تسجيل",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize:
                              MediaQuery.of(context).size.height * 3 / 100),
                    )),
                height: MediaQuery.of(context).size.height * 10 / 100,
              ),
            )
          ],
        ),
      ),
    );
  }
}
// keep going bro / don't lose so much time on social media / you have to sacrifice  with sochial media to get what you want if you dont sacriface you will be like small programmer that's the bill you have to pay it its a big bill i know but if you pay it you will be successful