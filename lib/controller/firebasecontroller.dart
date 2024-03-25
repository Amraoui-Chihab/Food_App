import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mr_yummy_v2/controller/usermodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mr_yummy_v2/general_page.dart';
import 'package:mr_yummy_v2/main.dart';
import 'package:mr_yummy_v2/otp_page.dart';

class firebasecontroller extends GetxController {
  bool did_orders=false;
  String? otp_code;
  usermodel? user;
  String? verification_id;
  final db = FirebaseFirestore.instance;
  phone_auth(usermodel user) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      timeout: Duration(seconds: 60),
      phoneNumber: "+213${user.phone_number}",
      verificationCompleted: ((phoneAuthCredential) {
        print("completed");
      }),
      verificationFailed: (FirebaseAuthException) {
        print("----------------------------------------------");
        print(FirebaseAuthException.message);
        print("--------------------------------------------00");

        Get.snackbar("خطأ", "",
            messageText: Text("هناك ضغط يرجى إعادة المحاولة لاحقا",
                style: TextStyle(fontSize: 25)),
            backgroundColor: Colors.red);
      },
      codeSent: (verificationId, forceResendingToken) {
        Get.snackbar("إشعار", "",
            messageText: Text("لقد تم إرسال كود التفعيل الخاص بك",
                style: TextStyle(fontSize: 25)),
            backgroundColor: Colors.red);
        this.verification_id = verificationId;
        Get.toNamed("/otp");
      },
      codeAutoRetrievalTimeout: (verificationId) {
        print("dernier");
      },
    );
  }

  Future<void> verifyOTP(String verificationId, String otpCode) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: otpCode,
    );

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      // OTP verification successful, you can now sign in the user or perform other actions.
      // Access the user with 'userCredential.user'.
      Get.snackbar("إشعار", "",
          messageText:
              Text("تم التحقق من كود التفعيل", style: TextStyle(fontSize: 25)),
          backgroundColor: Colors.red);
      createuser(user!);
    } catch (e) {
      // Handle verification failure.
      Get.snackbar("خطأ", "",
          messageText: Text("كود التفعيل خاطئ", style: TextStyle(fontSize: 25)),
          backgroundColor: Colors.red);
    }
  }
  

  Future<bool> isPhoneNumberUnique(String phoneNumber) async {
    final QuerySnapshot result = await db
        .collection('users')
        .where('رقم الهاتف', isEqualTo: phoneNumber)
        .get();

    return result.docs.isEmpty;
  }

  createuser(usermodel user) async {
    if (await isPhoneNumberUnique(user.phone_number)) {
      await db
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set(user.toJson())
          .whenComplete(() {
        Get.snackbar("Success", "",
            messageText:
                Text("لقد تم تسجيلك بنجاح", style: TextStyle(fontSize: 25)),
            backgroundColor: Colors.red);
        prefs!.setString("login", FirebaseAuth.instance.currentUser!.uid);

        Get.offNamed("/general_page");
      }).catchError((error, stackTrace) {
        Get.snackbar("خطأ", "",
            messageText: Text("هناك خطأ", style: TextStyle(fontSize: 25)),
            backgroundColor: Colors.red);
      });
    } else {
      Get.snackbar("خطأ", "",
          messageText: Text("رقم الهاتف خاص بمستخدم اخر لا تستطيع التسجيل به",
              style: TextStyle(fontSize: 25)),
          backgroundColor: Colors.red);
    }
  }
}
