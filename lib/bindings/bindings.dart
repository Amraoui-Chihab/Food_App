import 'package:get/get.dart';
import 'package:mr_yummy_v2/controller/firebasecontroller.dart';
import 'package:mr_yummy_v2/controller/general_controller.dart';

import 'package:mr_yummy_v2/user_cart.dart';

class mybindings extends Bindings {
  @override
  void dependencies() {
    Get.put(firebasecontroller(),permanent:true );
    Get.put(user_cart(),permanent: true);
    Get.put(general_controller(),permanent: true);
  }
}
