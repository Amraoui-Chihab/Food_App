import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:mr_yummy_v2/product.dart';

class general_controller extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  RxInt currentbodyindex = 0.obs;
  RxString? foldername = "pizza".obs;

  Stream<QuerySnapshot> fetch_products(String foldername) {
    if (foldername == "Broasted Chicken Meals" ||
        foldername == "Peri Peri chicken meals") {
      CollectionReference ref = FirebaseFirestore.instance
          .collection("products")
          .doc("rzXHANvDHRF38a1iTPWY")
          .collection("chicken")
          .doc(foldername)
          .collection(foldername);
      return ref.snapshots();
    } else if (foldername == "Burger Box" || foldername == "Burger") {
      CollectionReference ref = FirebaseFirestore.instance
          .collection("products")
          .doc("rzXHANvDHRF38a1iTPWY")
          .collection("burger")
          .doc(foldername)
          .collection(foldername);
      return ref.snapshots();
    } else if (foldername == "snacks box" || foldername == "Snacks") {
      CollectionReference ref = FirebaseFirestore.instance
          .collection("products")
          .doc("rzXHANvDHRF38a1iTPWY")
          .collection("snacks")
          .doc(foldername)
          .collection(foldername);
      return ref.snapshots();
    } else if (foldername == "Pizza Maison" ||
        foldername == "Pizza Creme fraiche" ||
        foldername == "Pizza Sauce Tomate") {
      CollectionReference ref = FirebaseFirestore.instance
          .collection("products")
          .doc("rzXHANvDHRF38a1iTPWY")
          .collection("pizza")
          .doc(foldername)
          .collection(foldername);
      return ref.snapshots();
    }  else {
      CollectionReference ref = FirebaseFirestore.instance
          .collection("products")
          .doc("rzXHANvDHRF38a1iTPWY")
          .collection(foldername);
      return ref.snapshots();
    }
  }
}
