import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mr_yummy_v2/cart_page.dart';
import 'package:mr_yummy_v2/controller/firebasecontroller.dart';
import 'package:mr_yummy_v2/controller/general_controller.dart';
import 'package:mr_yummy_v2/order_page.dart';
import 'package:mr_yummy_v2/order_product.dart';
import 'package:mr_yummy_v2/product.dart';
import 'package:mr_yummy_v2/user_cart.dart';
import 'package:mr_yummy_v2/waiting_page.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class general_page extends StatelessWidget {
  final FirebaseStorage storage = FirebaseStorage.instance;
  general_controller controller = Get.find();

  int index = 0;

  firebasecontroller firebasecontrollr = Get.find();
  user_cart user_cart_controller = Get.find();

  @override
  Widget build(BuildContext context) {
    List icons = [
      GetX<general_controller>(
        init: general_controller(),
        builder: (gen_controller) {
          return Container(
            decoration: BoxDecoration(
                color: gen_controller.currentbodyindex.value != 0
                    ? Colors.white
                    : Colors.red,
                borderRadius: BorderRadius.circular(10)),
            margin: EdgeInsets.all(5),
            width: MediaQuery.of(context).size.width * 25 / 100,
            child: Center(
                child: InkWell(
                    onTap: () async {
                      if (gen_controller.currentbodyindex.value != 0) {
                        gen_controller.currentbodyindex.value = 0;
                        gen_controller.foldername!.value = "pizza";
                      }
                    },
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            child: Image.asset("assets/icons/pizza.png"),
                            width: MediaQuery.of(context).size.width * 10 / 100,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 10 / 100,
                            child: Text(
                              "Pizza",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),
                    ))),
          );
        },
      ),
      GetX<general_controller>(
        builder: (gen_controller) {
          return Container(
            decoration: BoxDecoration(
                color: controller.currentbodyindex != 1
                    ? Colors.white
                    : Colors.red,
                borderRadius: BorderRadius.circular(10)),
            margin: EdgeInsets.all(5),
            width: MediaQuery.of(context).size.width * 25 / 100,
            child: Center(
                child: InkWell(
                    onTap: () async {
                      controller.currentbodyindex.value = 1;
                      controller.foldername!.value = "burger";
                    },
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: Image.asset("assets/icons/burger.png"),
                            width: MediaQuery.of(context).size.width * 10 / 100,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 15 / 100,
                            child: Text(
                              "Burger",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),
                    ))),
          );
        },
      ),
      GetX<general_controller>(
        builder: (gen_controller) => Container(
          decoration: BoxDecoration(
              color:
                  controller.currentbodyindex != 2 ? Colors.white : Colors.red,
              borderRadius: BorderRadius.circular(10)),
          margin: EdgeInsets.all(5),
          width: MediaQuery.of(context).size.width * 25 / 100,
          child: Center(
              child: InkWell(
                  onTap: () async {
                    if (controller.currentbodyindex != 2) {
                      controller.currentbodyindex.value = 2;
                      controller.foldername!.value = "tacos";
                    }
                  },
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          child: Image.asset("assets/icons/tacos.png"),
                          width: MediaQuery.of(context).size.width * 10 / 100,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 10 / 100,
                          child: Text(
                            "Tacos",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                  ))),
        ),
      ),
      GetX<general_controller>(
        builder: (gen_controller) => Container(
          decoration: BoxDecoration(
              color:
                  controller.currentbodyindex != 3 ? Colors.white : Colors.red,
              borderRadius: BorderRadius.circular(10)),
          margin: EdgeInsets.all(5),
          width: MediaQuery.of(context).size.width * 30 / 100,
          child: Center(
              child: InkWell(
                  onTap: () async {
                    if (controller.currentbodyindex != 3) {
                      controller.currentbodyindex.value = 3;
                      controller.foldername!.value = "sandwish";
                    }
                  },
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          child: Image.asset("assets/icons/taco.png"),
                          width: MediaQuery.of(context).size.width * 10 / 100,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 20 / 100,
                          child: Text(
                            "Sandwish",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                  ))),
        ),
      ),
      GetX<general_controller>(
        builder: (gen_controller) {
          return Container(
            decoration: BoxDecoration(
                color: controller.currentbodyindex != 4
                    ? Colors.white
                    : Colors.red,
                borderRadius: BorderRadius.circular(10)),
            margin: EdgeInsets.all(5),
            width: MediaQuery.of(context).size.width * 25 / 100,
            child: Center(
                child: InkWell(
                    onTap: () async {
                      if (controller.currentbodyindex != 4) {
                        controller.currentbodyindex.value = 4;
                        controller.foldername!.value = "signature";
                      }
                    },
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            child: Image.asset("assets/icons/signature.png"),
                            width: MediaQuery.of(context).size.width * 10 / 100,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 10 / 100,
                            child: Text(
                              "Signature",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),
                    ))),
          );
        },
      ),
      GetX<general_controller>(
        builder: (gen_controller) => Container(
          decoration: BoxDecoration(
              color:
                  controller.currentbodyindex != 5 ? Colors.white : Colors.red,
              borderRadius: BorderRadius.circular(10)),
          margin: EdgeInsets.all(5),
          width: MediaQuery.of(context).size.width * 25 / 100,
          child: Center(
              child: InkWell(
                  onTap: () async {
                    controller.currentbodyindex.value = 5;
                    controller.foldername!.value = "snacks";
                  },
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          child: Image.asset("assets/icons/snacks.png"),
                          width: MediaQuery.of(context).size.width * 10 / 100,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 10 / 100,
                          child: Text(
                            "Snacks",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                  ))),
        ),
      ),
      GetX<general_controller>(
        builder: (gen_controller) => Container(
          decoration: BoxDecoration(
              color:
                  controller.currentbodyindex != 6 ? Colors.white : Colors.red,
              borderRadius: BorderRadius.circular(10)),
          margin: EdgeInsets.all(5),
          width: MediaQuery.of(context).size.width * 25 / 100,
          child: Center(
              child: InkWell(
                  onTap: () async {
                    controller.currentbodyindex.value = 6;
                    controller.foldername!.value = "chicken";
                  },
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          child: Image.asset("assets/icons/chicken.png"),
                          width: MediaQuery.of(context).size.width * 10 / 100,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 10 / 100,
                          child: Text(
                            "Chicken",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                  ))),
        ),
      ),
      GetX<general_controller>(
        builder: (gen_controller) => Container(
          decoration: BoxDecoration(
              color:
                  controller.currentbodyindex != 7 ? Colors.white : Colors.red,
              borderRadius: BorderRadius.circular(10)),
          margin: EdgeInsets.all(5),
          width: MediaQuery.of(context).size.width * 25 / 100,
          child: Center(
              child: InkWell(
                  onTap: () async {
                    if (controller.currentbodyindex != 7)
                      controller.currentbodyindex.value = 7;
                    controller.foldername!.value = "plat";
                  },
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          child: Image.asset("assets/icons/plat.png"),
                          width: MediaQuery.of(context).size.width * 10 / 100,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 10 / 100,
                          child: Text(
                            "Plat varié",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                  ))),
        ),
      ),
      GetX<general_controller>(
        builder: (gen_controller) => Container(
          decoration: BoxDecoration(
              color:
                  controller.currentbodyindex != 8 ? Colors.white : Colors.red,
              borderRadius: BorderRadius.circular(10)),
          margin: EdgeInsets.all(5),
          width: MediaQuery.of(context).size.width * 25 / 100,
          child: Center(
              child: InkWell(
                  onTap: () async {
                    if (controller.currentbodyindex != 8)
                      controller.currentbodyindex.value = 8;
                    controller.foldername!.value = "sugar";
                  },
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          child: Image.asset("assets/icons/sugar.png"),
                          width: MediaQuery.of(context).size.width * 10 / 100,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 10 / 100,
                          child: Text(
                            "Sucré",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                  ))),
        ),
      ),
    ];

    List<Widget> pages = [
      Column(
        children: [
          Center(
              child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 2 / 100),
            width: MediaQuery.of(context).size.width * 90 / 100,
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Text(
                        "Fast Food",
                        style: TextStyle(
                            fontSize:
                                MediaQuery.of(context).size.height * 4 / 100),
                      ),
                      height: (MediaQuery.of(context).size.height * 10 / 100) *
                          40 /
                          100,
                    ),
                    Container(
                      child: Text(
                        "Fast Delivery",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize:
                                MediaQuery.of(context).size.height * 4 / 100),
                      ),
                      height: (MediaQuery.of(context).size.height * 10 / 100) *
                          60 /
                          100,
                    ),
                  ],
                ),
                Container(
                    width: 80,
                    height: MediaQuery.of(context).size.height * 10 / 100,
                    child: null)
              ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
            height: MediaQuery.of(context).size.height * 10 / 100,
            margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 1 / 100),
          )),
          Center(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15), color: Colors.white),
              width: MediaQuery.of(context).size.width * 90 / 100,
              height: MediaQuery.of(context).size.height * 6 / 100,
              child: TextField(
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.height * 3 / 100),
                cursorColor: Colors.red,
                decoration: InputDecoration(
                    hintText: "إبحث عن طعامك المفضل",
                    enabledBorder: InputBorder.none,
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 3),
                    ),
                    focusColor: Colors.red,
                    suffixIcon: Icon(
                      Icons.search,
                      color: Colors.red,
                    )),
              ),
            ),
          ),
          Center(
              child: Container(
                  height: MediaQuery.of(context).size.height * 8 / 100,
                  width: MediaQuery.of(context).size.width * 90 / 100,
                  child: Center(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return icons[index];
                      },
                      itemCount: icons.length,
                    ),
                  ))),
          Center(
            child: Container(
              child: GetX<general_controller>(builder: (contr) {
                return Container(
                    child: StreamBuilder<QuerySnapshot>(
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text("Error"),
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(color: Colors.red),
                      );
                    } else if (!snapshot.hasData ||
                        snapshot.data!.docs.isEmpty) {
                      return Center(
                        child: Text("No Products"),
                      );
                    }

                    List<QueryDocumentSnapshot> lists = snapshot.data!.docs;
                    lists.sort(
                      (a, b) {
                        return a["price"].compareTo(b["price"]);
                      },
                    );
                    return GridView.builder(
                      itemCount: lists.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 1,
                          crossAxisSpacing: 2,
                          mainAxisSpacing: 2,
                          crossAxisCount: 2),
                      itemBuilder: (context, index) {
                        return Container(
                          height: MediaQuery.of(context).size.height * 40 / 100,
                          child: InkWell(
                            onTap: () {
                              if (lists[index]["title"] ==
                                      "Broasted Chicken Meals" ||
                                  lists[index]["title"] ==
                                      "Peri Peri chicken meals") {
                                contr.foldername!.value = lists[index]["title"];
                              } else if (lists[index]["title"] ==
                                      "snacks box" ||
                                  lists[index]["title"] == "Snacks") {
                                contr.foldername!.value = lists[index]["title"];
                              } else if (lists[index]["title"] == "Burger" ||
                                  lists[index]["title"] == "Burger Box") {
                                contr.foldername!.value = lists[index]["title"];
                              } else if (lists[index]["title"] ==
                                      "Pizza Maison" ||
                                  lists[index]["title"] ==
                                      "Pizza Sauce Tomate" ||
                                  lists[index]["title"] ==
                                      "Pizza Creme fraiche") {
                                contr.foldername!.value = lists[index]["title"];
                              } else {
                                if (lists[index]["title"] == "coffee" ||
                                    lists[index]["title"] == "Tiramisu" ||
                                    lists[index]["title"] == "Milk Shake") {
                                  user_cart_controller.auxilary_product =
                                      new optional_product(
                                          selected_option: null,
                                          classe: lists[index]["classe"],
                                          amount: 1,
                                          imagepath: lists[index]["imagepath"],
                                          title: lists[index]["title"],
                                          price: lists[index]["price"],
                                          options: lists[index]["options"],
                                          options_selections: List.generate(
                                            lists[index]["options"].length,
                                            (index) {
                                              return false;
                                            },
                                          )).obs;

                                  Get.to(order_page(),
                                      transition:
                                          Transition.leftToRightWithFade);
                                } else if (lists[index]["classe"] == "burger") {
                                  user_cart_controller.auxilary_product =
                                      new burger_product(
                                    options_selections: List.generate(
                                        lists[index]["priced options"].length,
                                        (index) {
                                      return false;
                                    }),
                                    amount: 1,
                                    imagepath: lists[index]["imagepath"],
                                    title: lists[index]["title"],
                                    price: lists[index]["price"],
                                    priced_options: lists[index]
                                        ["priced options"],
                                    selected_options: null,
                                    classe: lists[index]["classe"],
                                  ).obs;

                                  Get.to(order_page(),
                                      transition:
                                          Transition.leftToRightWithFade);
                                } else if (lists[index]["classe"] == "tacos") {
                                  print("tacos");
                                } else if (lists[index]["classe"] == "pizza") {
                                  user_cart_controller
                                      .auxilary_product = new pizzaproduct(
                                          classe: lists[index]["classe"],
                                          amount: 1,
                                          imagepath: lists[index]["imagepath"],
                                          title: lists[index]["title"],
                                          price: lists[index]["price"],
                                          real_price: lists[index]["sizes"])
                                      .obs;

                                  Get.to(order_page(),
                                      transition:
                                          Transition.leftToRightWithFade);
                                } else {
                                  user_cart_controller
                                      .auxilary_product = new order_product(
                                          classe: lists[index]["classe"],
                                          amount: 1,
                                          imagepath: lists[index]["imagepath"],
                                          title: lists[index]["title"],
                                          price: lists[index]["price"])
                                      .obs;

                                  Get.to(order_page(),
                                      transition:
                                          Transition.leftToRightWithFade);
                                }
                              }
                            },
                            child: lists[index]["classe"] != "pizza"
                                ? product(context,
                                    imagePath: lists[index]["imagepath"],
                                    title: lists[index]["title"],
                                    price: lists[index]["price"],
                                    classe: lists[index]["classe"])
                                : pizza_product(context,
                                    imagePath: lists[index]["imagepath"],
                                    title: lists[index]["title"],
                                    sizes: lists[index]["sizes"],
                                    classe: lists[index]["classe"]),
                          ),
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                                offset: index % 2 == 0
                                    ? Offset(-2, 2)
                                    : Offset(2, 2),
                                color: Colors.grey,
                                spreadRadius: 2)
                          ], borderRadius: BorderRadius.circular(15)),
                        );
                      },
                    );
                  },
                  stream:
                      controller.fetch_products(controller.foldername!.value),
                ));
              }),
              height: MediaQuery.of(context).size.height * 58 / 100,
              width: MediaQuery.of(context).size.width * 90 / 100,
            ),
          )
        ],
      ),
      waiting(),
      Text("3")
    ];
    return Scaffold(
      bottomNavigationBar: Container(
        width: MediaQuery.of(context).size.width * 90 / 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 8 / 100,
              child: RaisedButton(
                color: Colors.red,
                shape: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [Image.asset("assets/menu.png"), Text("Menu")],
                ),
                onPressed: () {},
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 8 / 100,
              child: RaisedButton(
                color: Colors.transparent,
                shape: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [Image.asset("assets/moto.png"), Text("Livraison")],
                ),
                onPressed: () {
                  Get.to(waiting(), transition: Transition.fadeIn);
                },
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 8 / 100,
              child: RaisedButton(
                shape: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10)),
                color: Colors.transparent,
                child: Row(
                  children: [Image.asset("assets/panier.png"), Text("My Cart")],
                ),
                onPressed: () {
                  Get.to(cart_page(),
                      transition: Transition.leftToRightWithFade);
                },
              ),
            )
          ],
        ),
        height: MediaQuery.of(context).size.height * 13 / 100,
      ),
      body: WillPopScope(
          child: pages[0],
          onWillPop: () async {
            if (controller.foldername == "Broasted Chicken Meals" ||
                controller.foldername == "Peri Peri chicken meals") {
              controller.foldername!.value = "chicken";
            }

            if (controller.foldername == "Burger Box" ||
                controller.foldername == "Burger") {
              controller.foldername!.value = "burger";
            }
            if (controller.foldername == "snacks box" ||
                controller.foldername == "Snacks") {
              controller.foldername!.value = "snacks";
            }
            if (controller.foldername == "Pizza Maison" ||
                controller.foldername == "Pizza Creme fraiche" ||
                controller.foldername == "Pizza Sauce Tomate") {
              controller.foldername!.value = "pizza";
            }

            return false;
          }),
    );
  }
}
