import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:mr_yummy_v2/general_page.dart';
import 'package:mr_yummy_v2/order_product.dart';
import 'package:mr_yummy_v2/user_cart.dart';
import 'package:geolocator/geolocator.dart';

Future<void> _checkLocationPermission() async {
  print("***********************************************************");
  final LocationPermission permission = await Geolocator.requestPermission();
  print(permission);
  if (permission == LocationPermission.deniedForever) {
    await Get.snackbar(
        "message", "يرجى تفعيل خدمة تحديد المواقع من الإعدادات Permission",
        backgroundColor: Colors.red);
    await Future.delayed(Duration(seconds: 4));
    await Geolocator.openAppSettings();
  }
  if (permission == LocationPermission.always ||
      permission == LocationPermission.whileInUse) {
    _getUserLocation();
  }
}

Future<void> _getUserLocation() async {
  Get.defaultDialog(
      title: "Ordering Please Wait",
      content: CircularProgressIndicator(
        color: Colors.red,
      ));
  print("here here ");
  try {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    user_cart user_cart_controller = Get.find();
    print('Latitude: ${position.latitude}, Longitude: ${position.longitude}');
    await user_cart_controller.order_to_me_please(
        position.latitude, position.longitude);
    Get.back();
    Get.back();
    Get.back();
    Get.snackbar("alert", "تم تنفيذ طلبك بنجاح", backgroundColor: Colors.red);
  } catch (e) {
    await Get.snackbar("message", "يرجى إعادة المحاولة لم يتم قبول طلبك",
        backgroundColor: Colors.red);
    Get.back();
  }
}

class cart_page extends StatelessWidget {
  user_cart user_cart_controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: Container(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 5 / 100),
              width: MediaQuery.of(context).size.width * 90 / 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        //  Get.toNamed("/general_page");
                        Future.delayed(Duration.zero, () {
                          Get.offAllNamed("/general_page");
                        });
                      },
                      icon: Icon(Icons.arrow_back)),
                  CircleAvatar(
                    child: InkWell(
                      child: Icon(
                        CupertinoIcons.trash,
                        color: Colors.white,
                      ),
                      onTap: () {
                        user_cart_controller.delete_all_products();
                      },
                    ),
                    radius: 20,
                    backgroundColor: Colors.red,
                  )
                ],
              ),
              height: MediaQuery.of(context).size.height * 10 / 100,
            ),
          ),
          Center(
            child: Container(
              margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 2 / 100),
              height: MediaQuery.of(context).size.height * 3 / 100,
              child: FittedBox(
                child: Text(
                  "My Cart",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          Center(
              child: Container(
            height: MediaQuery.of(context).size.height * 55 / 100,
            child: GetX<user_cart>(
              builder: (controller) {
                if (controller.orders.value.isEmpty == false)
                  return ListView.separated(
                    separatorBuilder: (context, index) {
                      return Divider(
                        height: MediaQuery.of(context).size.height * 3 / 100,
                      );
                    },
                    itemCount: controller.orders.value.length,
                    itemBuilder: (context, index) {
                      return Container(
                        height: MediaQuery.of(context).size.height * 15 / 100,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(-2, 2),
                                  spreadRadius: 2,
                                  blurRadius: 2,
                                  color: Color.fromARGB(201, 210, 195, 195))
                            ],
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(5)),
                        child: controller.orders.value[index].value
                                is optional_product
                            ? Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                        bottom: 1,
                                        top: 1,
                                        right:
                                            (MediaQuery.of(context).size.width *
                                                    90 /
                                                    100) *
                                                5 /
                                                100,
                                        left:
                                            (MediaQuery.of(context).size.width *
                                                    90 /
                                                    100) *
                                                1 /
                                                100),
                                    child: Image.network(controller
                                        .orders.value[index].value.imagepath),
                                    width: (MediaQuery.of(context).size.width *
                                            90 /
                                            100) *
                                        20 /
                                        100,
                                  ),
                                  Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              15 /
                                              100,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    1 /
                                                    100),
                                            child: FittedBox(
                                                child: Text(
                                              controller.orders.value[index]
                                                  .value.title,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            )),
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                3 /
                                                100,
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    1 /
                                                    100,
                                                bottom: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    1 /
                                                    100),
                                            child: FittedBox(
                                                child: Text(
                                              "option : ${controller.orders[index].value.selected_option}",
                                            )),
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                2 /
                                                100,
                                          ),
                                          Container(
                                            width: (MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    90 /
                                                    100) *
                                                35 /
                                                100,
                                            child: Row(
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      7 /
                                                      100,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                                bottom: 10),
                                                        width: (MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                90 /
                                                                100) *
                                                            (20 / 3) /
                                                            100,
                                                        decoration: BoxDecoration(
                                                            color: Colors
                                                                .grey[400],
                                                            borderRadius: BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        20),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        20))),
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            8 /
                                                            100,
                                                        child: InkWell(
                                                          child: Icon(
                                                              Icons.minimize),
                                                          onTap: () {
                                                            if (controller
                                                                    .orders[
                                                                        index]
                                                                    .value
                                                                    .amount >
                                                                1) {
                                                              controller
                                                                  .decrement_order_amount(
                                                                      index);
                                                            }
                                                          },
                                                        ),
                                                      ),
                                                      Container(
                                                        width: (MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                90 /
                                                                100) *
                                                            (20 / 3) /
                                                            100,
                                                        color: Colors.white,
                                                        child: FittedBox(
                                                            child: Text(
                                                                "${controller.orders[index].value.amount}")),
                                                      ),
                                                      Container(
                                                        width: (MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                90 /
                                                                100) *
                                                            (20 / 3) /
                                                            100,
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            5 /
                                                            100,
                                                        decoration: BoxDecoration(
                                                            color: Colors
                                                                .grey[400],
                                                            borderRadius: BorderRadius.only(
                                                                topRight: Radius
                                                                    .circular(
                                                                        20),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        20))),
                                                        child: InkWell(
                                                          child:
                                                              Icon(Icons.add),
                                                          onTap: () {
                                                            controller
                                                                .increment_order_amount(
                                                                    index);
                                                          },
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  width: (MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          90 /
                                                          100) *
                                                      20 /
                                                      100,
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      left: (MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              90 /
                                                              100) *
                                                          2.5 /
                                                          100),
                                                  width: (MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          90 /
                                                          100) *
                                                      10 /
                                                      100,
                                                  child: FittedBox(
                                                      child: Text(
                                                    "${controller.orders.value[index].value.price * controller.orders.value[index].value.amount} Da",
                                                    style: TextStyle(
                                                        color: Colors.red,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )),
                                                )
                                              ],
                                            ),
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                5 /
                                                100,
                                          ),
                                        ],
                                      ),
                                      width:
                                          (MediaQuery.of(context).size.width *
                                                  90 /
                                                  100) *
                                              54 /
                                              100),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(5),
                                            topLeft: Radius.circular(5))),
                                    width: ((MediaQuery.of(context).size.width *
                                                90 /
                                                100) *
                                            20 /
                                            100) /
                                        2,
                                    margin: EdgeInsets.only(
                                        left: ((MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    90 /
                                                    100) *
                                                20 /
                                                100) /
                                            2,
                                        top: (MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                15 /
                                                100) *
                                            60 /
                                            100),
                                    child: InkWell(
                                      child: Icon(
                                        CupertinoIcons.trash,
                                        color: Colors.white,
                                      ),
                                      onTap: () {
                                        controller.delete_product(index);
                                      },
                                    ),
                                    height:
                                        (MediaQuery.of(context).size.height *
                                                15 /
                                                100) *
                                            40 /
                                            100,
                                  )
                                ],
                              )
                            : (controller.orders.value[index].value
                                    is burger_product)
                                ? Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                            bottom: 1,
                                            top: 1,
                                            right: (MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    90 /
                                                    100) *
                                                5 /
                                                100,
                                            left: (MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    90 /
                                                    100) *
                                                1 /
                                                100),
                                        child: Image.network(controller.orders
                                            .value[index].value.imagepath),
                                        width:
                                            (MediaQuery.of(context).size.width *
                                                    90 /
                                                    100) *
                                                20 /
                                                100,
                                      ),
                                      Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              15 /
                                              100,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(
                                                    top: MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                        1 /
                                                        100),
                                                child: FittedBox(
                                                    child: Text(
                                                  controller.orders.value[index]
                                                      .value.title,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    3 /
                                                    100,
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(
                                                    top: MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                        1 /
                                                        100,
                                                    bottom:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            1 /
                                                            100),
                                                child: FittedBox(
                                                    child: Text(
                                                  "Options : ${controller.orders[index].value.selected_options}",
                                                )),
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    2 /
                                                    100,
                                              ),
                                              Container(
                                                width: (MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        90 /
                                                        100) *
                                                    35 /
                                                    100,
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20)),
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              7 /
                                                              100,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Container(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    bottom: 10),
                                                            width: (MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    90 /
                                                                    100) *
                                                                (20 / 3) /
                                                                100,
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                    .grey[400],
                                                                borderRadius: BorderRadius.only(
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            20),
                                                                    bottomLeft:
                                                                        Radius.circular(
                                                                            20))),
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                8 /
                                                                100,
                                                            child: InkWell(
                                                              child: Icon(Icons
                                                                  .minimize),
                                                              onTap: () {
                                                                int y = controller
                                                                    .orders[
                                                                        index]
                                                                    .value
                                                                    .amount;
                                                                if (y > 1) {
                                                                  y--;

                                                                  controller.orders[
                                                                          index] =
                                                                      controller
                                                                          .plus_burger(
                                                                              index,
                                                                              y)
                                                                          .obs;
                                                                }
                                                              },
                                                            ),
                                                          ),
                                                          Container(
                                                            width: (MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    90 /
                                                                    100) *
                                                                (20 / 3) /
                                                                100,
                                                            color: Colors.white,
                                                            child: FittedBox(
                                                                child: Text(
                                                                    "${controller.orders[index].value.amount}")),
                                                          ),
                                                          Container(
                                                            width: (MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    90 /
                                                                    100) *
                                                                (20 / 3) /
                                                                100,
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                5 /
                                                                100,
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                    .grey[400],
                                                                borderRadius: BorderRadius.only(
                                                                    topRight: Radius
                                                                        .circular(
                                                                            20),
                                                                    bottomRight:
                                                                        Radius.circular(
                                                                            20))),
                                                            child: InkWell(
                                                              child: Icon(
                                                                  Icons.add),
                                                              onTap: () {
                                                                int y = controller
                                                                    .orders[
                                                                        index]
                                                                    .value
                                                                    .amount;
                                                                y++;
                                                                controller.orders[
                                                                        index] =
                                                                    controller
                                                                        .plus_burger(
                                                                            index,
                                                                            y)
                                                                        .obs;
                                                              },
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      width: (MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              90 /
                                                              100) *
                                                          20 /
                                                          100,
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          left: (MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  90 /
                                                                  100) *
                                                              2.5 /
                                                              100),
                                                      width: (MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              90 /
                                                              100) *
                                                          10 /
                                                          100,
                                                      child: FittedBox(
                                                          child: Text(
                                                        "${controller.orders.value[index].value.price * controller.orders.value[index].value.amount} Da",
                                                        style: TextStyle(
                                                            color: Colors.red,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      )),
                                                    )
                                                  ],
                                                ),
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    5 /
                                                    100,
                                              ),
                                            ],
                                          ),
                                          width: (MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  90 /
                                                  100) *
                                              54 /
                                              100),
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius: BorderRadius.only(
                                                bottomRight: Radius.circular(5),
                                                topLeft: Radius.circular(5))),
                                        width: ((MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    90 /
                                                    100) *
                                                20 /
                                                100) /
                                            2,
                                        margin: EdgeInsets.only(
                                            left: ((MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        90 /
                                                        100) *
                                                    20 /
                                                    100) /
                                                2,
                                            top: (MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    15 /
                                                    100) *
                                                60 /
                                                100),
                                        child: InkWell(
                                          child: Icon(
                                            CupertinoIcons.trash,
                                            color: Colors.white,
                                          ),
                                          onTap: () {
                                            controller.delete_product(index);
                                          },
                                        ),
                                        height: (MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                15 /
                                                100) *
                                            40 /
                                            100,
                                      )
                                    ],
                                  )
                                : controller.orders.value[index].value
                                        is pizzaproduct
                                    ? Row(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(
                                                bottom: 1,
                                                top: 1,
                                                right: (MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        90 /
                                                        100) *
                                                    5 /
                                                    100,
                                                left: (MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        90 /
                                                        100) *
                                                    1 /
                                                    100),
                                            child: Image.network(controller
                                                .orders
                                                .value[index]
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
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  15 /
                                                  100,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        top: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            1 /
                                                            100),
                                                    child: FittedBox(
                                                        child: Text(
                                                      controller
                                                          .orders
                                                          .value[index]
                                                          .value
                                                          .title,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )),
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            3 /
                                                            100,
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        top: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            1 /
                                                            100,
                                                        bottom: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            1 /
                                                            100),
                                                    child: FittedBox(
                                                        child: Text(
                                                      "Size : ${controller.orders[index].value.size}",
                                                    )),
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            2 /
                                                            100,
                                                  ),
                                                  Container(
                                                    width:
                                                        (MediaQuery.of(context)
                                                                    .size
                                                                    .width *
                                                                90 /
                                                                100) *
                                                            35 /
                                                            100,
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20)),
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              7 /
                                                              100,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Container(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        bottom:
                                                                            10),
                                                                width: (MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        90 /
                                                                        100) *
                                                                    (20 / 3) /
                                                                    100,
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                            .grey[
                                                                        400],
                                                                    borderRadius: BorderRadius.only(
                                                                        topLeft:
                                                                            Radius.circular(
                                                                                20),
                                                                        bottomLeft:
                                                                            Radius.circular(20))),
                                                                height: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    8 /
                                                                    100,
                                                                child: InkWell(
                                                                  child: Icon(Icons
                                                                      .minimize),
                                                                  onTap: () {
                                                                    int y = controller
                                                                        .orders[
                                                                            index]
                                                                        .value
                                                                        .amount;
                                                                    if (y > 1) {
                                                                      y--;

                                                                      controller.orders[index] = controller
                                                                          .final_pizza_(
                                                                              index,
                                                                              y)
                                                                          .obs;
                                                                    }
                                                                  },
                                                                ),
                                                              ),
                                                              Container(
                                                                width: (MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        90 /
                                                                        100) *
                                                                    (20 / 3) /
                                                                    100,
                                                                color: Colors
                                                                    .white,
                                                                child: FittedBox(
                                                                    child: Text(
                                                                        "${controller.orders[index].value.amount}")),
                                                              ),
                                                              Container(
                                                                width: (MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        90 /
                                                                        100) *
                                                                    (20 / 3) /
                                                                    100,
                                                                height: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    5 /
                                                                    100,
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                            .grey[
                                                                        400],
                                                                    borderRadius: BorderRadius.only(
                                                                        topRight:
                                                                            Radius.circular(
                                                                                20),
                                                                        bottomRight:
                                                                            Radius.circular(20))),
                                                                child: InkWell(
                                                                  child: Icon(
                                                                      Icons
                                                                          .add),
                                                                  onTap: () {
                                                                    int y = controller
                                                                        .orders[
                                                                            index]
                                                                        .value
                                                                        .amount;
                                                                    y++;

                                                                    controller.orders[
                                                                            index] =
                                                                        controller
                                                                            .final_pizza_(index,
                                                                                y)
                                                                            .obs;
                                                                  },
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          width: (MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  90 /
                                                                  100) *
                                                              20 /
                                                              100,
                                                        ),
                                                        Container(
                                                          margin: EdgeInsets.only(
                                                              left: (MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      90 /
                                                                      100) *
                                                                  2.5 /
                                                                  100),
                                                          width: (MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  90 /
                                                                  100) *
                                                              10 /
                                                              100,
                                                          child: FittedBox(
                                                              child: Text(
                                                            "${controller.orders.value[index].value.price * controller.orders.value[index].value.amount} Da",
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.red,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          )),
                                                        )
                                                      ],
                                                    ),
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            5 /
                                                            100,
                                                  ),
                                                ],
                                              ),
                                              width: (MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      90 /
                                                      100) *
                                                  54 /
                                                  100),
                                          Container(
                                            decoration: BoxDecoration(
                                                color: Colors.red,
                                                borderRadius: BorderRadius.only(
                                                    bottomRight:
                                                        Radius.circular(5),
                                                    topLeft:
                                                        Radius.circular(5))),
                                            width: ((MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        90 /
                                                        100) *
                                                    20 /
                                                    100) /
                                                2,
                                            margin: EdgeInsets.only(
                                                left: ((MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            90 /
                                                            100) *
                                                        20 /
                                                        100) /
                                                    2,
                                                top: (MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                        15 /
                                                        100) *
                                                    60 /
                                                    100),
                                            child: InkWell(
                                              child: Icon(
                                                CupertinoIcons.trash,
                                                color: Colors.white,
                                              ),
                                              onTap: () {
                                                controller
                                                    .delete_product(index);
                                              },
                                            ),
                                            height: (MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    15 /
                                                    100) *
                                                40 /
                                                100,
                                          )
                                        ],
                                      )
                                    : Row(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(
                                                bottom: 1,
                                                top: 1,
                                                right: (MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        90 /
                                                        100) *
                                                    5 /
                                                    100,
                                                left: (MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        90 /
                                                        100) *
                                                    1 /
                                                    100),
                                            child: Image.network(controller
                                                .orders[index].value.imagepath),
                                            width: (MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    90 /
                                                    100) *
                                                20 /
                                                100,
                                          ),
                                          Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  15 /
                                                  100,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        top: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            1 /
                                                            100),
                                                    child: FittedBox(
                                                        child: Text(
                                                      controller.orders[index]
                                                          .value.title,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )),
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            3 /
                                                            100,
                                                  ),
                                                  Container(
                                                    width:
                                                        (MediaQuery.of(context)
                                                                    .size
                                                                    .width *
                                                                90 /
                                                                100) *
                                                            35 /
                                                            100,
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20)),
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              7 /
                                                              100,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Container(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        bottom:
                                                                            10),
                                                                width: (MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        90 /
                                                                        100) *
                                                                    (20 / 3) /
                                                                    100,
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                            .grey[
                                                                        400],
                                                                    borderRadius: BorderRadius.only(
                                                                        topLeft:
                                                                            Radius.circular(
                                                                                20),
                                                                        bottomLeft:
                                                                            Radius.circular(20))),
                                                                height: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    8 /
                                                                    100,
                                                                child: InkWell(
                                                                  child: Icon(Icons
                                                                      .minimize),
                                                                  onTap: () {
                                                                    int y = controller
                                                                        .orders[
                                                                            index]
                                                                        .value
                                                                        .amount;
                                                                    if (y > 1) {
                                                                      y--;
                                                                      controller.orders[index] = controller
                                                                          .minimize_product_amount(
                                                                              index,
                                                                              y)
                                                                          .obs;
                                                                    }
                                                                  },
                                                                ),
                                                              ),
                                                              Container(
                                                                width: (MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        90 /
                                                                        100) *
                                                                    (20 / 3) /
                                                                    100,
                                                                color: Colors
                                                                    .white,
                                                                child: FittedBox(
                                                                    child: Text(
                                                                        "${controller.orders.value[index].value.amount}")),
                                                              ),
                                                              Container(
                                                                width: (MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        90 /
                                                                        100) *
                                                                    (20 / 3) /
                                                                    100,
                                                                height: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    5 /
                                                                    100,
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                            .grey[
                                                                        400],
                                                                    borderRadius: BorderRadius.only(
                                                                        topRight:
                                                                            Radius.circular(
                                                                                20),
                                                                        bottomRight:
                                                                            Radius.circular(20))),
                                                                child: InkWell(
                                                                  child: Icon(
                                                                      Icons
                                                                          .add),
                                                                  onTap: () {
                                                                    int y = controller
                                                                        .orders[
                                                                            index]
                                                                        .value
                                                                        .amount;
                                                                    y++;
                                                                    controller.orders[
                                                                            index] =
                                                                        controller
                                                                            .maximize_product_amount(index,
                                                                                y)
                                                                            .obs;
                                                                  },
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          width: (MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  90 /
                                                                  100) *
                                                              20 /
                                                              100,
                                                        ),
                                                        Container(
                                                          margin: EdgeInsets.only(
                                                              left: (MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      90 /
                                                                      100) *
                                                                  2.5 /
                                                                  100),
                                                          width: (MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  90 /
                                                                  100) *
                                                              10 /
                                                              100,
                                                          child: FittedBox(
                                                              child: Text(
                                                            "${controller.orders.value[index].value.price * controller.orders.value[index].value.amount} Da",
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.red,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          )),
                                                        )
                                                      ],
                                                    ),
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            5 /
                                                            100,
                                                  ),
                                                ],
                                              ),
                                              width: (MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      90 /
                                                      100) *
                                                  54 /
                                                  100),
                                          Container(
                                            decoration: BoxDecoration(
                                                color: Colors.red,
                                                borderRadius: BorderRadius.only(
                                                    bottomRight:
                                                        Radius.circular(5),
                                                    topLeft:
                                                        Radius.circular(5))),
                                            width: ((MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        90 /
                                                        100) *
                                                    20 /
                                                    100) /
                                                2,
                                            margin: EdgeInsets.only(
                                                left: ((MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            90 /
                                                            100) *
                                                        20 /
                                                        100) /
                                                    2,
                                                top: (MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                        15 /
                                                        100) *
                                                    60 /
                                                    100),
                                            child: InkWell(
                                              child: Icon(
                                                CupertinoIcons.trash,
                                                color: Colors.white,
                                              ),
                                              onTap: () {
                                                controller
                                                    .delete_product(index);
                                              },
                                            ),
                                            height: (MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    15 /
                                                    100) *
                                                40 /
                                                100,
                                          )
                                        ],
                                      ),
                      );
                    },
                  );
                else
                  return Center(
                    child: Text("No Orders Yet"),
                  );
              },
            ),
            width: MediaQuery.of(context).size.width * 90 / 100,
          )),
          Center(
            child: GetX<user_cart>(
              builder: (controller) {
                return Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 2 / 100),
                  child: controller.orders.value.isEmpty == false
                      ? Column(
                          children: [
                            Container(
                              width:
                                  MediaQuery.of(context).size.width * 90 / 100,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      "Selected items (${controller.orders.value.length})"),
                                  Text(
                                      "${controller.calculate_totale_price_orders()} Da",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ))
                                ],
                              ),
                              height:
                                  MediaQuery.of(context).size.height * 5 / 100,
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Prix Livraison"),
                                  Text(
                                    "${controller.delivery_price} Da",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              height:
                                  MediaQuery.of(context).size.height * 5 / 100,
                            ),
                            Container(
                              child: Column(
                                children: [
                                  Container(
                                    child: FittedBox(
                                      child: Text(
                                          "-------------------------------------"),
                                    ),
                                    height: MediaQuery.of(context).size.height *
                                        5 /
                                        100,
                                  ),
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        5 /
                                        100,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Subtotal"),
                                        Text(
                                          "${controller.delivery_price + controller.calculate_totale_price_orders()} Da",
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              height:
                                  MediaQuery.of(context).size.height * 10 / 100,
                            ),
                            Container(
                              child: RaisedButton(
                                  color: Colors.red,
                                  shape: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Text(
                                    "Check Out",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () async {
                                    user_cart_controller.deal_with_last_one();
                                    await Get.defaultDialog(
                                        title:
                                            "Please Select delivery Location",
                                        content: Column(
                                          children: [
                                            Image.asset("assets/delivery.jpg"),
                                            Container(
                                              height: 45,
                                              child: RaisedButton(
                                                  color: Colors.red,
                                                  shape: OutlineInputBorder(
                                                      borderSide:
                                                          BorderSide.none,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  onPressed: () async {
                                                    await _checkLocationPermission();
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Icon(
                                                        CupertinoIcons
                                                            .location_circle,
                                                      ),
                                                      Text(
                                                        "Select My Location",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      )
                                                    ],
                                                  )),
                                            ),
                                          ],
                                        ));
                                  }),
                              width:
                                  MediaQuery.of(context).size.width * 90 / 100,
                              height:
                                  MediaQuery.of(context).size.height * 6 / 100,
                            )
                          ],
                        )
                      : null,
                  width: MediaQuery.of(context).size.width * 90 / 100,
                  height: MediaQuery.of(context).size.height * 28 / 100,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
