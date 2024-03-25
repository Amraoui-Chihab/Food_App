import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/scheduler.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:mr_yummy_v2/order_product.dart';
import 'package:mr_yummy_v2/user_cart.dart';

void _showMultiSelect(BuildContext context) async {
  await showModalBottomSheet(
    isScrollControlled: true, // required for min/max child size
    context: context,
    builder: (ctx) {
      return MultiSelectChipDisplay(
        items: [],
      );
    },
  );
}

class details_page extends StatelessWidget {
  user_cart user_cart_controller = Get.find();

  @override
  Widget build(BuildContext context) {
    user_cart_controller.fill_burgers_confirmations();

    return Scaffold(
      body: Column(
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 5 / 100),
              width: MediaQuery.of(context).size.width * 90 / 100,
              child: GetX<user_cart>(
                init: user_cart(),
                builder: (controller) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 10 / 100,
                        child: InkWell(
                          child: Icon(Icons.arrow_back),
                          onTap: () {
                            /*   Get.back();

                            Get.back();
                            */
                            print("object");
                            Future.delayed(Duration.zero, () {
                              Get.offNamed("/order_page");
                            });
                          },
                        ),
                        width: (MediaQuery.of(context).size.width * 90 / 100) *
                            20 /
                            100,
                      ),
                      Container(
                        child: FittedBox(
                            child: Text(
                                "You Ordered ${controller.details_orders.value.length} ${controller.auxilary_product.value.title} \n Please Select Options")),
                        width: (MediaQuery.of(context).size.width * 90 / 100) *
                            60 /
                            100,
                        height: MediaQuery.of(context).size.height * 10 / 100,
                      )
                    ],
                  );
                },
              ),
              height: MediaQuery.of(context).size.height * 10 / 100,
            ),
          ),
          Center(
            child: Container(
              height: MediaQuery.of(context).size.height * 70 / 100,
              child: GetX<user_cart>(
                builder: (controller) {
                  return ListView.separated(
                      itemBuilder: (context, i) {
                        return controller.details_orders.value[i].value
                                is optional_product
                            ? Container(
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          offset: Offset(-2, 2),
                                          color: Colors.grey,
                                          spreadRadius: 2)
                                    ],
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(10)),
                                child: controller.details_orders.value[i].value
                                            .selected_option ==
                                        null
                                    ? Column(
                                        children: [
                                          Container(
                                            child: FittedBox(
                                                child: Text(
                                                    "select option for : ${controller.details_orders.value[i].value.title} n°${i + 1}")),
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                5 /
                                                100,
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                width: (MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        90 /
                                                        100) *
                                                    80 /
                                                    100,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: List.generate(
                                                      controller
                                                          .details_orders
                                                          .value[i]
                                                          .value
                                                          .options
                                                          .length, (index) {
                                                    return Container(
                                                      width: (MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              90 /
                                                              100) *
                                                          (80 /
                                                                  controller
                                                                      .details_orders
                                                                      .value[i]
                                                                      .value
                                                                      .options
                                                                      .length -
                                                              2) /
                                                          100,
                                                      child: FittedBox(
                                                          child: RaisedButton(
                                                              onPressed: () {
                                                                controller.details_orders[i] = controller
                                                                    .copy(
                                                                        i,
                                                                        controller
                                                                            .details_orders
                                                                            .value[i]
                                                                            .value
                                                                            .options[index]["title"])
                                                                    .obs;
                                                                controller
                                                                    .is_all_confirmed();
                                                              },
                                                              child: Column(
                                                                children: [
                                                                  Container(
                                                                    width: (MediaQuery.of(context).size.width *
                                                                            90 /
                                                                            100) *
                                                                        (80 / controller.details_orders.value[i].value.options.length -
                                                                            2) /
                                                                        100,
                                                                    child: FittedBox(
                                                                        child: Image.network(controller
                                                                            .details_orders
                                                                            .value[i]
                                                                            .value
                                                                            .options[index]["image"])),
                                                                    height: (MediaQuery.of(context).size.height *
                                                                            13 /
                                                                            100) *
                                                                        80 /
                                                                        100,
                                                                  ),
                                                                  Container(
                                                                    child: FittedBox(
                                                                        child: Text(
                                                                            "${controller.details_orders.value[i].value.options[index]["title"]}")),
                                                                    height: (MediaQuery.of(context).size.height *
                                                                            13 /
                                                                            100) *
                                                                        20 /
                                                                        100,
                                                                  )
                                                                ],
                                                              ))),
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              13 /
                                                              100,
                                                    );
                                                  }),
                                                ),
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    15 /
                                                    100,
                                              ),
                                              Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    8 /
                                                    100,
                                                width: (MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        90 /
                                                        100) *
                                                    15 /
                                                    100,
                                                margin: EdgeInsets.only(
                                                    left:
                                                        (MediaQuery.of(context)
                                                                    .size
                                                                    .width *
                                                                90 /
                                                                100) *
                                                            3 /
                                                            100),
                                                child: RaisedButton(
                                                  child: Icon(
                                                    CupertinoIcons.trash,
                                                    color: Colors.white,
                                                  ),
                                                  color: Colors.red,
                                                  onPressed: () {
                                                    user_cart_controller
                                                        .delete_details_order(
                                                            i);
                                                  },
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      )
                                    : Container(
                                        color: Colors.green,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  9 /
                                                  100,
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Image.asset(
                                                        "assets/confirm.png"),
                                                    Text(
                                                      "Order Confirmed",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )
                                                  ]),
                                              width: (MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      90 /
                                                      100) *
                                                  80 /
                                                  100,
                                            ),
                                            Container(
                                              child: RaisedButton(
                                                  shape: OutlineInputBorder(
                                                      borderSide:
                                                          BorderSide.none,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                  child: Icon(
                                                    Icons.cancel,
                                                    color: Colors.white,
                                                  ),
                                                  color: Colors.red,
                                                  onPressed: () {
                                                    user_cart_controller
                                                        .clear_selected_option(
                                                            i);
                                                    user_cart_controller
                                                        .is_all_confirmed();
                                                  }),
                                              margin: EdgeInsets.only(
                                                  top: (MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                          20 /
                                                          100) *
                                                      70 /
                                                      100),
                                              height: (MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      20 /
                                                      100) *
                                                  30 /
                                                  100,
                                              width: (MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      90 /
                                                      100) *
                                                  20 /
                                                  100,
                                            )
                                          ],
                                        ),
                                      ),
                                height: MediaQuery.of(context).size.height *
                                    20 /
                                    100)
                            : Container(
                                width: MediaQuery.of(context).size.width *
                                    90 /
                                    100,
                                child: GetX<user_cart>(
                                  builder: (controller) {
                                    if (controller.burgers_confirmations[i] ==
                                        false) {
                                      return Container(
                                        decoration: BoxDecoration(),
                                        child: Row(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(
                                                  right: (MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          90 /
                                                          100) *
                                                      2 /
                                                      100,
                                                  left: (MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          90 /
                                                          100) *
                                                      2 /
                                                      100),
                                              child: CachedNetworkImage(
                                                  progressIndicatorBuilder:
                                                      (context, url,
                                                              progress) =>
                                                          Center(
                                                            child:
                                                                CircularProgressIndicator(
                                                              value: progress
                                                                  .progress,
                                                              color: Colors.red,
                                                            ),
                                                          ),
                                                  imageUrl: controller
                                                      .details_orders[i]
                                                      .value
                                                      .imagepath),
                                              width: (MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      90 /
                                                      100) *
                                                  20 /
                                                  100,
                                            ),
                                            Container(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  FittedBox(
                                                    child: Text(
                                                      "Options",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                  Container(
                                                    width:
                                                        (MediaQuery.of(context)
                                                                    .size
                                                                    .width *
                                                                90 /
                                                                100) *
                                                            50 /
                                                            100,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            15 /
                                                            100,
                                                    child: controller
                                                            .details_orders[i]
                                                            .value
                                                            .selected_options
                                                            .isEmpty
                                                        ? Center(
                                                            child: Column(
                                                              children: [
                                                                FittedBox(
                                                                  child: Text(
                                                                      "No options selected \n click here to add "),
                                                                ),
                                                                Container(
                                                                  child:
                                                                      RaisedButton(
                                                                          child:
                                                                              Row(
                                                                            children: [
                                                                              Icon(Icons.add),
                                                                              Text("Add Option")
                                                                            ],
                                                                          ),
                                                                          onPressed:
                                                                              () {
                                                                            List<String>
                                                                                already_selected =
                                                                                user_cart_controller.details_orders[i].value.selected_options;
                                                                            List<bool>
                                                                                already_bool =
                                                                                List.generate(
                                                                              user_cart_controller.details_orders[i].value.options_selections.length,
                                                                              (index) {
                                                                                return false;
                                                                              },
                                                                            );

                                                                            user_cart_controller.details_orders[i] =
                                                                                user_cart_controller.copy_burger(i, already_selected, already_bool, -1).obs;

                                                                            Get.bottomSheet(Container(
                                                                              color: Colors.white,
                                                                              child: Column(
                                                                                children: [
                                                                                  Container(
                                                                                    width: MediaQuery.of(context).size.width * 90 / 100,
                                                                                    child: FittedBox(child: Text("Choose option for your ${user_cart_controller.details_orders[i].value.title} n°${i + 1}")),
                                                                                    height: MediaQuery.of(context).size.height * 5 / 100,
                                                                                  ),
                                                                                  Container(
                                                                                    height: MediaQuery.of(context).size.height * 20 / 100,
                                                                                    child: GetX<user_cart>(
                                                                                      builder: (controller) {
                                                                                        return Row(
                                                                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                            children: List.generate(
                                                                                              user_cart_controller.details_orders[i].value.priced_options.length,
                                                                                              (index) {
                                                                                                return Container(
                                                                                                  height: MediaQuery.of(context).size.height * 20 / 100,
                                                                                                  child: RaisedButton(
                                                                                                      color: controller.details_orders[i].value.options_selections[index] == true ? Colors.blue : Colors.transparent,
                                                                                                      child: Container(
                                                                                                        child: Center(
                                                                                                            child: Column(
                                                                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                                                                          children: [
                                                                                                            Text("${user_cart_controller.details_orders[i].value.priced_options[index]["title"]}"),
                                                                                                            Text(
                                                                                                              "${user_cart_controller.details_orders[i].value.priced_options[index]["price"]} Da",
                                                                                                              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                                                                                                            )
                                                                                                          ],
                                                                                                        )),
                                                                                                      ),
                                                                                                      onPressed: () {
                                                                                                        List<String> already_selected = user_cart_controller.details_orders[i].value.selected_options;
                                                                                                        List<bool> already_bool = user_cart_controller.details_orders[i].value.options_selections;

                                                                                                        already_bool[index] = !already_bool[index];

                                                                                                        if (already_bool[index] == true) {
                                                                                                          already_selected.add(user_cart_controller.details_orders[i].value.priced_options[index]["title"]);
                                                                                                        } else {
                                                                                                          already_selected.remove(user_cart_controller.details_orders[i].value.priced_options[index]["title"]);
                                                                                                        }

                                                                                                        user_cart_controller.details_orders[i] = user_cart_controller.copy_burger(i, already_selected, already_bool, index).obs;
                                                                                                      }),
                                                                                                  width: MediaQuery.of(context).size.width / 4 - 5,
                                                                                                );
                                                                                              },
                                                                                            ));
                                                                                      },
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              height: MediaQuery.of(context).size.height * 30 / 100,
                                                                            ));
                                                                          }),
                                                                  padding: EdgeInsets
                                                                      .symmetric(
                                                                          horizontal:
                                                                              10),
                                                                )
                                                              ],
                                                            ),
                                                          )
                                                        : Wrap(
                                                            crossAxisAlignment:
                                                                WrapCrossAlignment
                                                                    .start,
                                                            direction:
                                                                Axis.vertical,
                                                            children: List.generate(
                                                                user_cart_controller
                                                                    .details_orders[
                                                                        i]
                                                                    .value
                                                                    .selected_options
                                                                    .length,
                                                                (index) {
                                                              return Container(
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    90 /
                                                                    100 *
                                                                    40 /
                                                                    100,
                                                                margin: EdgeInsets
                                                                    .symmetric(
                                                                        vertical:
                                                                            2),
                                                                height: ((MediaQuery.of(context).size.height *
                                                                            15 /
                                                                            100) /
                                                                        4) -
                                                                    5,
                                                                child:
                                                                    FittedBox(
                                                                        fit: BoxFit
                                                                            .fill,
                                                                        child:
                                                                            RaisedButton(
                                                                          child: Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                Icon(Icons.cancel),
                                                                                Text(user_cart_controller.details_orders[i].value.selected_options[index])
                                                                              ]),
                                                                          onPressed:
                                                                              () {
                                                                            List<String>
                                                                                already_selected =
                                                                                user_cart_controller.details_orders[i].value.selected_options;
                                                                            List<bool>
                                                                                already_bool =
                                                                                user_cart_controller.details_orders[i].value.options_selections;
                                                                            already_bool[index] =
                                                                                false;
                                                                            already_selected.remove(user_cart_controller.details_orders[i].value.selected_options[index]);

                                                                            user_cart_controller.details_orders[i] =
                                                                                user_cart_controller.copy_burger(i, already_selected, already_bool, -1).obs;
                                                                          },
                                                                        )),
                                                              );
                                                            }),
                                                          ),
                                                  ),
                                                ],
                                              ),
                                              width: (MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      90 /
                                                      100) *
                                                  50 /
                                                  100,
                                            ),
                                            Center(
                                                child: Container(
                                                    child: Column(
                                                      children: [
                                                        FittedBox(
                                                          child: Text(
                                                            "${controller.details_orders[i].value.price}  Da",
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.red),
                                                          ),
                                                        ),
                                                        RaisedButton(
                                                            textColor:
                                                                Colors.white,
                                                            color: Colors.green,
                                                            child: FittedBox(
                                                                child:
                                                                    Text("Ok")),
                                                            onPressed: () {
                                                              controller
                                                                      .burgers_confirmations[
                                                                  i] = true;
                                                              controller
                                                                  .is_all_burgers_ok();
                                                            }),
                                                        RaisedButton(
                                                            textColor:
                                                                Colors.black,
                                                            color: Colors.red,
                                                            child: FittedBox(
                                                                child: Text(
                                                                    "Delete")),
                                                            onPressed: () {
                                                              controller
                                                                  .delete_details_order(
                                                                      i);
                                                            })
                                                      ],
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                    ),
                                                    width:
                                                        (MediaQuery.of(context)
                                                                    .size
                                                                    .width *
                                                                90 /
                                                                100) *
                                                            20 /
                                                            100,
                                                    margin: EdgeInsets.only(
                                                        right: (MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                90 /
                                                                100) *
                                                            2 /
                                                            100,
                                                        left: (MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                90 /
                                                                100) *
                                                            4 /
                                                            100)))
                                          ],
                                        ),
                                      );
                                    }
                                    return Container(
                                      color: Colors.green,
                                      child: Center(
                                        child: Row(
                                          children: [
                                            Container(
                                              child: Row(
                                                children: [
                                                  Image.asset(
                                                      "assets/confirm.png"),
                                                  Text(("Order Confirmed"))
                                                ],
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                              ),
                                              width: (MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      90 /
                                                      100) *
                                                  80 /
                                                  100,
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  right: (MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          90 /
                                                          100) *
                                                      5 /
                                                      100),
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  5 /
                                                  100,
                                              child: RaisedButton(
                                                color: Colors.red,
                                                child: Icon(Icons.cancel),
                                                onPressed: () {
                                                  controller
                                                          .burgers_confirmations[
                                                      i] = false;
                                                  controller.is_all_confirmed();
                                                },
                                              ),
                                              width: (MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      90 /
                                                      100) *
                                                  15 /
                                                  100,
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                height: MediaQuery.of(context).size.height *
                                    20 /
                                    100);
                      },
                      separatorBuilder: (context, index) {
                        return Divider(
                          height:
                              MediaQuery.of(context).size.height * 2.5 / 100,
                        );
                      },
                      itemCount:
                          user_cart_controller.details_orders.value.length);
                },
              ),
              width: MediaQuery.of(context).size.width * 90 / 100,
            ),
          ),
          Center(child: GetX<user_cart>(
            builder: (controller) {
              return Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 5 / 100),
                child: (controller.details_orders[0].value is optional_product)
                    ? controller.confirmed.value == true
                        ? RaisedButton(
                            child: Text(
                              "Add To Cart",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            color: Colors.red,
                            shape: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(20)),
                            onPressed: () {
                              for (int i = 0;
                                  i < controller.details_orders.value.length;
                                  i++) {
                                user_cart_controller.add_product(
                                    user_cart_controller
                                        .details_orders.value[i]);
                              }

                              Get.toNamed("/cart_page");
                            })
                        : null
                    : controller.is_all_burgers_ok() == true
                        ? RaisedButton(
                            child: Text(
                              "Add To Cart ",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            color: Colors.red,
                            shape: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(20)),
                            onPressed: () {
                              for (int i = 0;
                                  i < controller.details_orders.value.length;
                                  i++) {
                                user_cart_controller.add_product(
                                    user_cart_controller
                                        .details_orders.value[i]);
                              }

                              Get.toNamed("/cart_page");
                            })
                        : null,
                height: MediaQuery.of(context).size.height * 10 / 100,
                width: MediaQuery.of(context).size.width * 90 / 100,
              );
            },
          ))
        ],
      ),
    );
  }
}
