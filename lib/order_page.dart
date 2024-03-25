import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:mr_yummy_v2/order_product.dart';
import 'package:mr_yummy_v2/pizza_details.dart';
import 'package:mr_yummy_v2/user_cart.dart';

class order_page extends StatelessWidget {
  user_cart user_cart_controller = Get.find();
  order_page() {
    print("init order page");
  }

  @override
  Widget build(BuildContext context) {
    user_cart_controller.renew_extra();

    return Scaffold(
      body: Column(children: [
        Center(
          child: Container(
            margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 1 / 100),
            child: FittedBox(
              child: Text("Order Page"),
            ),
            height: MediaQuery.of(context).size.height * 4 / 100,
          ),
        ),
        Center(
          child: Container(
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 35 / 100,
                  child: CachedNetworkImage(
                    fit: BoxFit.fill,
                    imageUrl:
                        user_cart_controller.auxilary_product.value.imagepath,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => Center(
                      child: CircularProgressIndicator(
                        value: downloadProgress.progress,
                        color: Colors.red,
                      ),
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                  width:
                      (MediaQuery.of(context).size.width * 90 / 100) * 50 / 100,
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: (MediaQuery.of(context).size.width * 90 / 100) *
                          2 /
                          100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            top: (MediaQuery.of(context).size.height *
                                    40 /
                                    100) *
                                5 /
                                100),
                        height:
                            (MediaQuery.of(context).size.height * 35 / 100) *
                                10 /
                                100,
                        child: FittedBox(
                            child: Text(
                                "Food Name : ${user_cart_controller.auxilary_product.value.title}")),
                      ),
                      Container(
                        child: Row(
                          children: [
                            Text(
                              "Food Price : ",
                            ),
                            Text(
                                "${user_cart_controller.auxilary_product.value.price} Da",
                                style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold))
                          ],
                        ),
                        height:
                            (MediaQuery.of(context).size.height * 35 / 100) *
                                10 /
                                100,
                      ),
                      Container(
                        child: FittedBox(
                          child: Text("Description : \n here description"),
                        ),
                        height:
                            (MediaQuery.of(context).size.height * 35 / 100) *
                                50 /
                                100,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 45 / 100,
                        child: Row(
                          children: [
                            Container(
                              height: (MediaQuery.of(context).size.height *
                                      35 /
                                      100) *
                                  25 /
                                  100,
                              child: RaisedButton(
                                shape: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                color: Colors.red,
                                child: Icon(Icons.minimize),
                                onPressed: () {
                                  if (user_cart_controller
                                          .auxilary_product.value.amount >
                                      1) {
                                    user_cart_controller.auxilary_product
                                        .update((val) {
                                      val.amount--;
                                    });
                                  }
                                },
                              ),
                              width: ((MediaQuery.of(context).size.width *
                                          90 /
                                          100) *
                                      45 /
                                      100) *
                                  35 /
                                  100,
                            ),
                            GetX<user_cart>(
                              builder: (controller1) {
                                return Container(
                                  child: FittedBox(
                                      child: Text(
                                          "${controller1.auxilary_product.value.amount}")),
                                  width: ((MediaQuery.of(context).size.width *
                                              90 /
                                              100) *
                                          45 /
                                          100) *
                                      30 /
                                      100,
                                );
                              },
                            ),
                            Container(
                              height: (MediaQuery.of(context).size.height *
                                      35 /
                                      100) *
                                  25 /
                                  100,
                              child: RaisedButton(
                                shape: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                color: Colors.red,
                                child: Icon(Icons.add),
                                onPressed: () {
                                  user_cart_controller.auxilary_product
                                      .update((val) {
                                    val.amount++;
                                  });
                                },
                              ),
                              width: ((MediaQuery.of(context).size.width *
                                          90 /
                                          100) *
                                      45 /
                                      100) *
                                  35 /
                                  100,
                            )
                          ],
                        ),
                        height:
                            (MediaQuery.of(context).size.height * 35 / 100) *
                                25 /
                                100,
                      )
                    ],
                  ),
                  width:
                      (MediaQuery.of(context).size.width * 90 / 100) * 45 / 100,
                )
              ],
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            ),
            height: MediaQuery.of(context).size.height * 40 / 100,
            width: MediaQuery.of(context).size.width * 90 / 100,
          ),
        ),
        Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 90 / 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 1 / 100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: FittedBox(
                          child: Text(
                            "Extra Products",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        height:
                            (MediaQuery.of(context).size.height * 20 / 100) *
                                20 /
                                100,
                      ),
                      Container(
                        child: GetX<user_cart>(
                          builder: (controller3) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                for (int i = 0;
                                    i < user_cart_controller.extra.value.length;
                                    i++)
                                  Container(
                                    child: RaisedButton(
                                      color: user_cart_controller
                                                  .extra_selection.value[i] ==
                                              true
                                          ? Colors.green
                                          : Colors.transparent,
                                      child: Column(
                                        children: [
                                          Container(
                                            width: (MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    90 /
                                                    100) *
                                                (100 /
                                                        controller3.extra.value
                                                            .length -
                                                    1) /
                                                100,
                                            height: ((MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                        20 /
                                                        100) *
                                                    80 /
                                                    100) *
                                                40 /
                                                100,
                                            child: FittedBox(
                                                child: Image.network(
                                              controller3.extra.value[i]
                                                  ["imagepath"],
                                            )),
                                          ),
                                          Container(
                                            width: (MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    90 /
                                                    100) *
                                                (100 /
                                                        controller3.extra.value
                                                            .length -
                                                    1) /
                                                100,
                                            child: Text(controller3
                                                .extra.value[i]["title"]),
                                            height: ((MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                        20 /
                                                        100) *
                                                    80 /
                                                    100) *
                                                40 /
                                                100,
                                          ),
                                          Container(
                                            width: (MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    90 /
                                                    100) *
                                                (100 /
                                                        controller3.extra.value
                                                            .length -
                                                    1) /
                                                100,
                                            child: FittedBox(
                                                child: Text(
                                              "${controller3.extra[i]["price"]} Da",
                                              style: TextStyle(
                                                  color: controller3
                                                              .extra_selection
                                                              .value[i] ==
                                                          true
                                                      ? Colors.white
                                                      : Colors.green,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                            height: ((MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                        20 /
                                                        100) *
                                                    80 /
                                                    100) *
                                                10 /
                                                100,
                                          )
                                        ],
                                      ),
                                      onPressed: () {
                                        if (controller3
                                                .extra_selection.value[i] ==
                                            true) {
                                          controller3.extra_selection[i] =
                                              false;

                                          controller3.extra_price =
                                              controller3.extra_price -
                                                  controller3.extra[i]["price"];
                                        } else {
                                          controller3.extra_selection[i] = true;
                                          controller3.extra_price =
                                              controller3.extra_price +
                                                  controller3.extra.value[i]
                                                      ["price"];
                                        }
                                      },
                                    ),
                                    width: (MediaQuery.of(context).size.width *
                                            90 /
                                            100) *
                                        (100 /
                                                user_cart_controller
                                                    .extra.value.length -
                                            1) /
                                        100,
                                  )
                              ],
                            );
                          },
                        ),
                        height:
                            (MediaQuery.of(context).size.height * 20 / 100) *
                                80 /
                                100,
                      )
                    ],
                  ),
                  height: MediaQuery.of(context).size.height * 20 / 100,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 3),
                  width: MediaQuery.of(context).size.width * 90 / 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: (MediaQuery.of(context).size.width * 90 / 100) *
                            30 /
                            100,
                        child: FittedBox(
                          child: GetX<user_cart>(
                            builder: (controller) {
                              return Text(
                                "Total Price : ${controller.auxilary_product.value.amount * controller.auxilary_product.value.price + controller.extra_price.value} Da",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green),
                              );
                            },
                          ),
                        ),
                        height: MediaQuery.of(context).size.height * 10 / 100,
                      ),
                      Container(
                        width: (MediaQuery.of(context).size.width * 90 / 100) *
                            40 /
                            100,
                        height: MediaQuery.of(context).size.height * 7 / 100,
                        child: RaisedButton(
                          color: Colors.red,
                          shape: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(
                            "ADD TO CART",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {
                            if (user_cart_controller.auxilary_product.value
                                is optional_product) {
                              user_cart_controller.clear_details();

                              for (int i = 0;
                                  i <
                                      user_cart_controller
                                          .auxilary_product.value.amount;
                                  i++) {
                                user_cart_controller.add_details(optional_product(
                                    selected_option: null,
                                    classe: user_cart_controller
                                        .auxilary_product.value.classe,
                                    amount: 1,
                                    imagepath: user_cart_controller
                                        .auxilary_product.value.imagepath,
                                    title: user_cart_controller
                                        .auxilary_product.value.title,
                                    price: user_cart_controller
                                        .auxilary_product.value.price,
                                    options: user_cart_controller
                                        .auxilary_product.value.options,
                                    options_selections: user_cart_controller
                                        .auxilary_product
                                        .value
                                        .options_selections));
                              }

                              for (int i = 0;
                                  i <
                                      user_cart_controller
                                          .extra_selection.length;
                                  i++) {
                                if (user_cart_controller
                                        .extra_selection.value[i] ==
                                    true) {
                                  user_cart_controller.add_product(
                                      order_product(
                                              classe: "extra",
                                              amount: 1,
                                              imagepath: user_cart_controller
                                                  .extra[i]["imagepath"],
                                              title: user_cart_controller
                                                  .extra[i]["title"],
                                              price: user_cart_controller
                                                  .extra[i]["price"])
                                          .obs);
                                }
                              }
                              Get.toNamed("/details_page");
                            } else if (user_cart_controller
                                .auxilary_product.value is burger_product) {
                              for (int i = 0;
                                  i <
                                      user_cart_controller
                                          .extra_selection.length;
                                  i++) {
                                if (user_cart_controller
                                        .extra_selection.value[i] ==
                                    true) {
                                  user_cart_controller.add_product(
                                      order_product(
                                              classe: "extra",
                                              amount: 1,
                                              imagepath: user_cart_controller
                                                  .extra[i]["imagepath"],
                                              title: user_cart_controller
                                                  .extra[i]["title"],
                                              price: user_cart_controller
                                                  .extra[i]["price"])
                                          .obs);
                                }
                              }
                              user_cart_controller.details_orders.clear();
                              for (int i = 0;
                                  i <
                                      user_cart_controller
                                          .auxilary_product.value.amount;
                                  i++)
                                user_cart_controller.add_details(burger_product(
                                  options_selections: List.generate(
                                      user_cart_controller
                                          .auxilary_product
                                          .value
                                          .priced_options
                                          .length, (index) {
                                    return false;
                                  }),
                                  amount: 1,
                                  imagepath: user_cart_controller
                                      .auxilary_product.value.imagepath,
                                  title: user_cart_controller
                                      .auxilary_product.value.title,
                                  price: user_cart_controller
                                      .auxilary_product.value.price,
                                  priced_options: user_cart_controller
                                      .auxilary_product.value.priced_options,
                                  selected_options: [],
                                  classe: user_cart_controller
                                      .auxilary_product.value.classe,
                                ));
                              Get.toNamed("/details_page");
                            } else if (user_cart_controller
                                .auxilary_product.value is tacos_product) {
                              print("tacos");
                            } else if (user_cart_controller
                                .auxilary_product.value is pizzaproduct) {
                              user_cart_controller.pizzaorders.clear();
                              user_cart_controller
                                  .pizza_comands_confirmed.value = false;

                              for (int i = 0;
                                  i <
                                      user_cart_controller
                                          .auxilary_product.value.amount;
                                  i++) {
                                user_cart_controller.pizzaorders.add(
                                    pizzaproduct(
                                        classe: user_cart_controller
                                            .auxilary_product.value.classe,
                                        amount: 1,
                                        imagepath:
                                            user_cart_controller.auxilary_product
                                                .value.imagepath,
                                        title:
                                            user_cart_controller
                                                .auxilary_product.value.title,
                                        price:
                                            user_cart_controller
                                                .auxilary_product.value.price,
                                        real_price: user_cart_controller
                                            .auxilary_product
                                            .value
                                            .real_price));
                              }
                              for (int i = 0;
                                  i <
                                      user_cart_controller
                                          .extra_selection.length;
                                  i++) {
                                if (user_cart_controller
                                        .extra_selection.value[i] ==
                                    true) {
                                  user_cart_controller.add_product(
                                      order_product(
                                              classe: "extra",
                                              amount: 1,
                                              imagepath: user_cart_controller
                                                  .extra[i]["imagepath"],
                                              title: user_cart_controller
                                                  .extra[i]["title"],
                                              price: user_cart_controller
                                                  .extra[i]["price"])
                                          .obs);
                                }
                              }
                              Get.to(pizza_details(),
                                  transition: Transition.size);
                            } else {
                              for (int i = 0;
                                  i <
                                      user_cart_controller
                                          .extra_selection.length;
                                  i++) {
                                if (user_cart_controller
                                        .extra_selection.value[i] ==
                                    true) {
                                  user_cart_controller.add_product(
                                      order_product(
                                              classe: "extra",
                                              amount: 1,
                                              imagepath: user_cart_controller
                                                  .extra[i]["imagepath"],
                                              title: user_cart_controller
                                                  .extra[i]["title"],
                                              price: user_cart_controller
                                                  .extra[i]["price"])
                                          .obs);
                                }
                              }

                              user_cart_controller.add_product(order_product(
                                      classe: user_cart_controller
                                          .auxilary_product.value.classe,
                                      amount: user_cart_controller
                                          .auxilary_product.value.amount,
                                      imagepath: user_cart_controller
                                          .auxilary_product.value.imagepath,
                                      title: user_cart_controller
                                          .auxilary_product.value.title,
                                      price: user_cart_controller
                                          .auxilary_product.value.price)
                                  .obs);

                              Get.toNamed("/cart_page");
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  height: MediaQuery.of(context).size.height * 14 / 100,
                )
              ],
            ),
            height: MediaQuery.of(context).size.height * 55 / 100,
          ),
        )
      ]),
    );
  }
}
