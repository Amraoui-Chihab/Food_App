
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:mr_yummy_v2/details_page.dart';
import 'package:mr_yummy_v2/main.dart';
import 'package:mr_yummy_v2/order_product.dart';
import 'package:mr_yummy_v2/product.dart';

class user_cart extends GetxController {
  RxBool isloading = false.obs;
  RxList<pizzaproduct> pizzaorders = <pizzaproduct>[].obs;

  late Rx<dynamic> auxilary_product;
  RxInt extra_price = 0.obs;
  RxList<QueryDocumentSnapshot> extra = <QueryDocumentSnapshot>[].obs;
  RxList<bool> extra_selection = <bool>[].obs;
  RxList<dynamic> orders = <dynamic>[].obs;
  void get_extra() async {
    QuerySnapshot ref =
        await FirebaseFirestore.instance.collection("extra products").get();
    extra.value = ref.docs;

    for (int i = 0; i < extra.length; i++) {
      extra_selection.value.add(false);
    }
  }

  RxBool pizza_comands_confirmed = false.obs;
  void check_pizzas() {
    bool temp = true;

    for (int i = 0; i < pizzaorders.length; i++) {
      temp = temp && (pizzaorders[i].size == null ? false : true);
    }
    pizza_comands_confirmed.value = temp;
  }

  pizzaproduct copy_pizza(int i, String? Size) {
    var x = pizzaproduct(
        classe: pizzaorders[i].classe,
        amount: 1,
        imagepath: pizzaorders[i].imagepath,
        title: pizzaorders[i].title,
        price: pizzaorders[i].price,
        real_price: pizzaorders[i].real_price);
    x.size = Size;
    return x;
  }

  void clear_selected_option(int i) {
    details_orders[i] = copy(i, null).obs;
  }

  RxBool confirmed = false.obs;
  void is_all_confirmed() {
    bool temp = true;
    for (int i = 0; i < details_orders.length; i++) {
      temp = temp &&
          (details_orders[i].value.selected_option == null ? false : true);
    }
    confirmed.value = temp;
    print("called $confirmed");
  }

  void select_specific_option(int i, String option) {
    details_orders[i]..value.selected_option = option;

    // is_all_confirmed();
  }

  void delete_all_products() {
    orders.clear();
    print(orders);
  }

  dynamic calculate_totale_price_orders() {
    dynamic price = 0;

    for (var item in orders.value) {
      price = price + item.value.amount * item.value.price;
    }

    return price;
  }

  void delete_product(int i) async {
    orders.removeAt(i);
    Get.defaultDialog(
        title: "Deleting",
        content: CircularProgressIndicator(
          color: Colors.red,
        ));
    await Future.delayed(Duration(seconds: 1));
    Get.back();
  }

  void add_product(var p) {
    if (p.value is optional_product) {
      bool exist = false;
      for (int i = 0; i < orders.length; i++) {
        if (orders[i].value is optional_product) {
          optional_product temp = orders[i].value;
          if (temp.selected_option == p.value.selected_option &&
              temp.title == p.value.title) {
            exist = true;
            orders[i].value.amount = orders[i].value.amount + p.value.amount;
            print("exist");
            break;
          }
        }
      }
      if (exist == false) {
        print("pas exist");
        orders.add(p);
      }
    } else if (p.value is burger_product) {
      bool exist = false;
      for (int i = 0; i < orders.length; i++) {
        if (orders[i].value is burger_product) {
          burger_product temp = orders[i].value;

          if (temp.title == p.value.title &&
              areListsEqual(temp.selected_options, p.value.selected_options)) {
            print("burgers existed befor");
            exist = true;
            orders[i].value.amount = orders[i].value.amount + p.value.amount;

            break;
          }
        }
      }
      if (exist == false) {
        orders.add(p);
      }
    } else if (p.value is pizzaproduct) {
      print(p.value.size);
      bool exist = false;
      for (int i = 0; i < orders.length; i++) {
        if (orders[i].value is pizzaproduct) {
          pizzaproduct temp = orders[i].value;

          if (temp.title == p.value.title && temp.size == p.value.size) {
            print("we have this pizza before");
            exist = true;
            orders[i].value.amount = orders[i].value.amount + p.value.amount;

            break;
          }
        }
      }
      if (exist == false) {
        orders.add(p);
      }
    } else {
      print("extra or normal product");

      bool exist = false;
      for (int i = 0; i < orders.value.length; i++) {
        if (orders[i].value is order_product) {
          order_product temp = orders[i].value;

          if (temp.title == p.value.title) {
            orders[i].value.amount = orders[i].value.amount + p.value.amount;

            exist = true;
            break;
          }
        }
      }
      if (exist == false) {
        orders.add(p);
      }
    }
  }

  pizzaproduct final_pizza_(int i, int y) {
    pizzaproduct x = pizzaproduct(
        classe: orders[i].value.classe,
        amount: y,
        imagepath: orders[i].value.imagepath,
        title: orders[i].value.title,
        price: orders[i].value.price,
        real_price: orders[i].value.real_price);
    x.size = orders[i].value.size;

    return x;
  }

  Future<bool> doesUserExist(String userId) async {
    try {
      final DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      return userSnapshot.exists;
    } catch (error) {
      print("Error checking user existence: $error");
      return false; // Return false in case of an error
    }
  }

  Future<void> order_to_me_please(double lat, double long) async {
    if (await doesUserExist(FirebaseAuth.instance.currentUser!.uid)) {
      DocumentReference userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid);
      DocumentSnapshot doc = await userSnapshot.get();
      final data = doc.data() as Map<String, dynamic>;
      if (data.containsKey("الطلبات")) {
        final List<dynamic> itemList = data["الطلبات"] as List<dynamic>;

        itemList.add({
          "commande": {
            "Latitude": lat,
            "Longitude": long,
            "totale_price": calculate_totale_price_orders() + delivery_price,
            "content": List.generate(
              orders.length,
              (index) {
                return {
                  "title": orders.value[index].value.title,
                  "amount": orders.value[index].value.amount,
                  "price": orders.value[index].value.price
                };
              },
            ),
            "time":
                "${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}:${DateTime.now().year}:${DateTime.now().month}:${DateTime.now().day}"
          }
        });

        userSnapshot.update({"الطلبات": itemList});
      } else {
        userSnapshot.update({
          "الطلبات": [
            {
              "commande": {
                "Latitude": lat,
                "Longitude": long,
                "totale_price":
                    calculate_totale_price_orders() + delivery_price,
                "content": List.generate(
                  orders.length,
                  (index) {
                    return {
                      "title": orders.value[index].value.title,
                      "amount": orders.value[index].value.amount,
                      "price": orders.value[index].value.price
                    };
                  },
                ),
                "time":
                    "${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}:${DateTime.now().year}:${DateTime.now().month}:${DateTime.now().day}"
              }
            }
          ]
        });
      }
    } else {}
    orders.clear();
  }

  bool areListsEqual(List? a, List? b) {
    if (a == b) {
      return true;
    }

    if (a == null || b == null || a.length != b.length) {
      return false;
    }

    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) {
        return false;
      }
    }

    return true;
  }

  optional_product final_copy_dec(int i, int x) {
    return optional_product(
        selected_option: orders[i].value.selected_option,
        classe: orders[i].value.classe,
        amount: x,
        imagepath: orders[i].value.imagepath,
        title: orders[i].value.title,
        price: orders[i].value.price,
        options: orders[i].value.options,
        options_selections: orders[i].value.options_selections);
  }

  optional_product final_copy_inc(int i, int x) {
    return optional_product(
        selected_option: orders[i].value.selected_option,
        classe: orders[i].value.classe,
        amount: x,
        imagepath: orders[i].value.imagepath,
        title: orders[i].value.title,
        price: orders[i].value.price,
        options: orders[i].value.options,
        options_selections: orders[i].value.options_selections);
  }

  void decrement_order_amount(int i) {
    int x = orders[i].value.amount;
    if (orders[i].value.amount > 1) {
      x--;

      orders[i] = final_copy_dec(i, x).obs;
    }
  }

  void increment_order_amount(int i) {
    int x = orders[i].value.amount;
    x++;

    orders[i] = final_copy_inc(i, x).obs;
  }

  void delete_details_order(int i) async {
    details_orders.removeAt(i);
    burgers_confirmations.removeAt(i);
    Get.defaultDialog(
        title: "Deleting",
        content: CircularProgressIndicator(
          color: Colors.red,
        ));
    await Future.delayed(Duration(seconds: 1));
    Get.back();
    if (details_orders.isEmpty) {
      Get.back();
    }
    is_all_confirmed();
  }

  RxList<Rx<dynamic>> details_orders = <Rx<dynamic>>[].obs;
  void clear_details() {
    details_orders.value.clear();
    burgers_confirmations.clear();
  }

  num calculate_options_price(int i) {
    num x = 0;
    for (int j = 0; j < details_orders[i].value.priced_options.length; j++) {
      if (details_orders[i].value.options_selections[j] == true) {
        x = x + details_orders[i].value.priced_options[j]["price"];
      }
    }
    return x;
  }

  burger_product copy_burger(
      int i, List<String> selected, List<bool> options2, int index) {
    if (index != -1) {
      if (options2[index] == true) {
        num y = details_orders[i].value.price;
        y = y + details_orders[i].value.priced_options[index]["price"];
        return burger_product(
            options_selections: options2,
            amount: details_orders[i].value.amount,
            imagepath: details_orders[i].value.imagepath,
            title: details_orders[i].value.title,
            price: y as int,
            priced_options: details_orders[i].value.priced_options,
            selected_options: selected,
            classe: details_orders[i].value.classe);
      } else {
        num y = details_orders[i].value.price;
        y = y - details_orders[i].value.priced_options[index]["price"];
        return burger_product(
            options_selections: options2,
            amount: details_orders[i].value.amount,
            imagepath: details_orders[i].value.imagepath,
            title: details_orders[i].value.title,
            price: y as int,
            priced_options: details_orders[i].value.priced_options,
            selected_options: selected,
            classe: details_orders[i].value.classe);
      }
    } else {
      return burger_product(
          options_selections: options2,
          amount: details_orders[i].value.amount,
          imagepath: details_orders[i].value.imagepath,
          title: details_orders[i].value.title,
          price: details_orders[i].value.price,
          priced_options: details_orders[i].value.priced_options,
          selected_options: selected,
          classe: details_orders[i].value.classe);
    }
  }

  optional_product copy(int i, String? option) {
    return optional_product(
        selected_option: option,
        classe: details_orders[i].value.classe,
        amount: details_orders[i].value.amount,
        imagepath: details_orders[i].value.imagepath,
        title: details_orders[i].value.title,
        price: details_orders[i].value.price,
        options: details_orders[i].value.options,
        options_selections: details_orders[i].value.options_selections);
  }

  void add_details(order_product p) {
    details_orders.value.add(p.obs);
  }

  bool is_all_burgers_ok() {
    return !burgers_confirmations.contains(false);
  }

  RxList<bool> burgers_confirmations = <bool>[].obs;
  void fill_burgers_confirmations() {
    burgers_confirmations.value = List.generate(
      details_orders.length,
      (index) {
        return false;
      },
    );
  }

  late int delivery_price;
  void get_delivery_price() async {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection("Delivery")
        .doc("delivery")
        .get();
    delivery_price = doc["price"];
  }

  burger_product plus_burger(int i, y) {
    return burger_product(
        options_selections: orders[i].value.options_selections,
        amount: y,
        imagepath: orders[i].value.imagepath,
        title: orders[i].value.title,
        price: orders[i].value.price,
        priced_options: orders[i].value.priced_options,
        selected_options: orders[i].value.selected_options,
        classe: orders[i].value.classe);
  }

  order_product maximize_product_amount(int i, int y) {
    return order_product(
        classe: orders[i].value.classe,
        amount: y,
        imagepath: orders[i].value.imagepath,
        title: orders[i].value.title,
        price: orders[i].value.price);
  }

  order_product minimize_product_amount(int i, int y) {
    return order_product(
        classe: orders[i].value.classe,
        amount: y,
        imagepath: orders[i].value.imagepath,
        title: orders[i].value.title,
        price: orders[i].value.price);
  }

  @override
  void onInit() {
    get_extra();
    get_delivery_price();
    super.onInit();
  }

  void renew_extra() {
    extra_price.value = 0;
    for (int i = 0; i < extra.length; i++) {
      extra_selection[i] = false;
    }
  }

  RxBool loading = false.obs;

  void set_auxilary_product(var p) {
    if (p is optional_product) {
      auxilary_product.value = optional_product(
          selected_option: p.selected_option,
          options_selections: p.options_selections,
          classe: p.classe,
          amount: p.amount,
          imagepath: p.imagepath,
          title: p.title,
          price: p.price,
          options: p.options);
    } else if (p is burger_product) {
      auxilary_product.value = burger_product(
          options_selections: p.options_selections,
          selected_options: null,
          amount: p.amount,
          imagepath: p.imagepath,
          title: p.title,
          price: p.price,
          priced_options: p.priced_options,
          classe: p.classe);
      print("burger");
    } else {
      auxilary_product = p;

      print("here");
    }
  }

  List<burger_product> burgers = [];
  void add_burgers(burger_product p) {
    burgers.add(p);
  }

  void add_extra(int i, int x) {
    extra_selection[i] = true;

    extra_price = extra_price + x;
  }

  void select_option(int i) {
    auxilary_product.value.options_selections[i] =
        !auxilary_product.value.options_selections[i];
    for (int j = 0; j < auxilary_product.value.options_selections.length; j++) {
      if (j != i) {
        auxilary_product.value.options_selections[j] = false;
      }
    }
  }

  void deal_with_last_one() async {
    last_one.value =
        await Geolocator.checkPermission() == LocationPermission.always ||
            await Geolocator.checkPermission() == LocationPermission.whileInUse;

            print("-----------------*");
            print(last_one.value);

  }

  RxBool last_one = false.obs;
}
