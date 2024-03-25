import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:mr_yummy_v2/order_product.dart';
import 'package:mr_yummy_v2/user_cart.dart';

class pizza_details extends StatelessWidget {
  const pizza_details({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    user_cart user = Get.find();
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: Container(
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Get.back();
                        Get.back();
                      },
                      icon: Icon(Icons.arrow_back)),
                  FittedBox(
                    child: Text(
                        "You Ordered ${user.auxilary_product.value.title}"),
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              ),
              width: MediaQuery.of(context).size.width * 90 / 100,
              height: MediaQuery.of(context).size.height * 5 / 100,
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 5 / 100),
            ),
          ),
          Center(
              child: Container(
            width: MediaQuery.of(context).size.width * 90 / 100,
            child: GetX<user_cart>(
              builder: (controller) => ListView.separated(
                scrollDirection: Axis.vertical,
                physics: ScrollPhysics(parent: BouncingScrollPhysics()),
                separatorBuilder: (context, index) {
                  return Divider(
                    height: 10,
                  );
                },
                itemCount: user.pizzaorders.length,
                shrinkWrap: true,
                itemBuilder: (context, index) => user.pizzaorders[index].size ==
                        null
                    ? Container(
                        child: Column(
                          children: [
                            Container(
                              width:
                                  MediaQuery.of(context).size.width * 90 / 100,
                              child: FittedBox(
                                  child: Text(
                                      "Choose Size for your pizza n°${index + 1}")),
                              height:
                                  MediaQuery.of(context).size.height * 3 / 100,
                            ),
                            Container(
                              child: Row(children: [
                                Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: List.generate(
                                        user.pizzaorders[index].real_price
                                            .length, (i) {
                                      return Container(
                                        child: RaisedButton(
                                            color: Colors.transparent,
                                            child: Container(
                                              child: Column(
                                                children: [
                                                  Container(
                                                    height: i == 0
                                                        ? MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            10 /
                                                            100
                                                        : MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            15 /
                                                            100,
                                                    child: FittedBox(
                                                        fit: BoxFit.fill,
                                                        child: CachedNetworkImage(
                                                            imageUrl: user
                                                                .pizzaorders[
                                                                    index]
                                                                .imagepath)),
                                                  ),
                                                  Container(
                                                    child: Text(
                                                        "${user.pizzaorders[index].real_price[i]["title"]}"),
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            2 /
                                                            100,
                                                  ),
                                                  Container(
                                                    child: FittedBox(
                                                      child: Text(
                                                        "${user.pizzaorders[index].real_price[i]["price"]} Da",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.green),
                                                      ),
                                                    ),
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            2 /
                                                            100,
                                                  )
                                                ],
                                              ),
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  20 /
                                                  100,
                                            ),
                                            onPressed: () {
                                              user.pizzaorders[index] =
                                                  user.copy_pizza(
                                                      index,
                                                      user.pizzaorders[index]
                                                              .real_price[i]
                                                          ["title"]);
                                              print(
                                                  user.pizza_comands_confirmed);

                                              user.check_pizzas();
                                            }),
                                        width: i == 0
                                            ? ((MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        90 /
                                                        100) *
                                                    80 /
                                                    100) *
                                                30 /
                                                100
                                            : ((MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        90 /
                                                        100) *
                                                    80 /
                                                    100) *
                                                50 /
                                                100,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                20 /
                                                100,
                                      );
                                    }),
                                  ),
                                  width: (MediaQuery.of(context).size.width *
                                          90 /
                                          100) *
                                      80 /
                                      100,
                                ),
                                Container(
                                  height: MediaQuery.of(context).size.height *
                                      20 /
                                      100,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                        width:
                                            (MediaQuery.of(context).size.width *
                                                    90 /
                                                    100) *
                                                20 /
                                                100,
                                        color: Colors.red,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                7 /
                                                100,
                                        child: IconButton(
                                            onPressed: () async {
                                              Get.defaultDialog(
                                                  title: "Deleting",
                                                  content:
                                                      CircularProgressIndicator(
                                                    color: Colors.red,
                                                  ));
                                              await Future.delayed(
                                                  Duration(seconds: 1));

                                              user.pizzaorders.removeAt(index);
                                              Get.back();
                                              user.check_pizzas();
                                            },
                                            icon: Icon(
                                              Icons.delete,
                                              color: Colors.black,
                                            )),
                                      ),
                                    ],
                                  ),
                                  width: (MediaQuery.of(context).size.width *
                                          90 /
                                          100) *
                                      20 /
                                      100,
                                )
                              ]),
                              height:
                                  MediaQuery.of(context).size.height * 20 / 100,
                            )
                          ],
                        ),
                        height: MediaQuery.of(context).size.height * 23 / 100,
                      )
                    : Container(
                        color: Colors.green,
                        height: MediaQuery.of(context).size.height * 20 / 100,
                        child: Row(
                          children: [
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset("assets/confirm.png"),
                                  Text("Order Confirmed")
                                ],
                              ),
                              width: (MediaQuery.of(context).size.width *
                                      90 /
                                      100) *
                                  80 /
                                  100,
                            ),
                            Container(
                                child: FittedBox(
                                    child: IconButton(
                                  onPressed: () {
                                    user.pizzaorders[index] =
                                        user.copy_pizza(index, null);

                                    user.check_pizzas();
                                  },
                                  icon: Icon(
                                    Icons.cancel,
                                    color: Colors.white,
                                  ),
                                )),
                                color: Colors.red,
                                width: (MediaQuery.of(context).size.width *
                                        90 /
                                        100) *
                                    20 /
                                    100)
                          ],
                        ),
                      ),
              ),
            ),
            height: MediaQuery.of(context).size.height * 70 / 100,
          )),
          Center(
            child: GetX<user_cart>(
              builder: (controller) {
                print("rebuilt");
                return Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 5 / 100),
                    width: MediaQuery.of(context).size.width * 90 / 100,
                    child: controller.pizza_comands_confirmed.value == true
                        ? RaisedButton(
                            child: Text(
                              "ADD TO CART",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            color: Colors.red,
                            shape: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(20)),
                            onPressed: () {
                              for (int i = 0;
                                  i < user.pizzaorders.length;
                                  i++) {
                                int j = user.pizzaorders[i].real_price
                                    .indexWhere((element) =>
                                        element["title"] ==
                                        user.pizzaorders[i].size);
                                pizzaproduct x = pizzaproduct(
                                    classe: user.pizzaorders[i].classe,
                                    amount: 1,
                                    imagepath: user.pizzaorders[i].imagepath,
                                    title: user.pizzaorders[i].title,
                                    price: user.pizzaorders[i].real_price[j]
                                        ["price"],
                                    real_price: user.pizzaorders[i].real_price);
                                x.size = user.pizzaorders[i].size;
                                user.add_product(x.obs);
                              }
                              Get.toNamed("/cart_page");
                            })
                        : null,
                    height: MediaQuery.of(context).size.height * 10 / 100);
              },
            ),
          )
        ],
      ),
    );
  }
}
