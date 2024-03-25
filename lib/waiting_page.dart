import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:mr_yummy_v2/user_cart.dart';

Stream<DocumentSnapshot<Object?>> getmyorders() {
  return FirebaseFirestore.instance
      .collection("users")
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .snapshots();
}

void from_orders_to_history(Map e) async {
  CollectionReference col =
      await FirebaseFirestore.instance.collection('history_products');
  DocumentSnapshot doc =
      await col.doc(FirebaseAuth.instance.currentUser!.uid).get();

  if (doc.exists) {
    print("exist");
    Map<String, dynamic>? documentData = doc.data() as Map<String, dynamic>?;

    documentData!["commandes"].add({"commande": e});

    col.doc(FirebaseAuth.instance.currentUser!.uid).set(documentData);
  } else {
    print("don't exist yet");
    col.doc(FirebaseAuth.instance.currentUser!.uid).set({
      "commandes": [
        {"commande": e}
      ]
    });
  }
}

class waiting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Center(
              child: Container(
                  child: FittedBox(
                      child: Text(
                    "Here are all of your Orders are in the road",
                  )),
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 5 / 100),
                  height: MediaQuery.of(context).size.height * 10 / 100),
            ),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 90 / 100,
                child: StreamBuilder<DocumentSnapshot>(
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(color: Colors.red),
                      );
                    } else if (snapshot.hasError) {
                      return Text("error");
                    } else if (!snapshot.hasData || !snapshot.data!.exists) {
                      return Center(
                        child: Text("YOU HAVE ANY ORDER IN PROGRESS"),
                      );
                    }
                    final userData =
                        snapshot.data!.data() as Map<String, dynamic>;

                    if (!userData.containsKey("الطلبات")) {
                      return Center(
                        child: Text("YOU HAVE ANY ORDER IN PROGRESS"),
                      );
                    }
                    final ordersList = userData['الطلبات'] as List<dynamic>;
                    if (ordersList.isEmpty) {
                      return Center(
                        child: Text("YOU HAVE ANY ORDER IN PROGRESS"),
                      );
                    }
                    return ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, i) {
                          return Container(
                            child: ListTile(
                              onTap: () {
                                Get.defaultDialog(
                                    title: "Commande Details",
                                    content: Column(
                                      children: List.generate(
                                          ordersList[i]["commande"]['content']
                                                  .length +
                                              1, (index) {
                                        if (index <
                                            ordersList[i]["commande"]['content']
                                                .length) {
                                          return Row(
                                            children: [
                                              Text(
                                                  "${ordersList[i]["commande"]['content'][index]["amount"]} ",
                                                  style: TextStyle(
                                                      color: Colors.green,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              Text(
                                                  "${ordersList[i]["commande"]['content'][index]["title"]} : "),
                                              Text(
                                                "${ordersList[i]["commande"]['content'][index]["price"] * ordersList[i]["commande"]['content'][index]["amount"]} Da",
                                                style: TextStyle(
                                                    color: Colors.green,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            ],
                                          );
                                        } else {
                                          return Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    "Prix Livrason : ",
                                                  ),
                                                  Text("200  Da",
                                                      style: TextStyle(
                                                          color: Colors.green,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ],
                                              ),
                                              Container(
                                                margin:
                                                    EdgeInsets.only(top: 10),
                                                height: 50,
                                                width: 150,
                                                child: RaisedButton(
                                                  color: Colors.green,
                                                  child: FittedBox(
                                                      child: Row(
                                                    children: [
                                                      Icon(Icons.check),
                                                      Text("Order Received")
                                                    ],
                                                  )),
                                                  onPressed: () async {
                                                    Get.back();
                                                    Get.defaultDialog(
                                                        title: "Confirming",
                                                        content:
                                                            CircularProgressIndicator(
                                                          color: Colors.red,
                                                        ));
                                                    await Future.delayed(
                                                        Duration(seconds: 1));
                                                    Get.back();
                                                    print(ordersList[i]
                                                        ["commande"]);
                                                    from_orders_to_history(
                                                        ordersList[i]
                                                            ["commande"]);
                                                    CollectionReference col2 =
                                                        await FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                'users');
                                                    col2
                                                        .doc(FirebaseAuth
                                                            .instance
                                                            .currentUser!
                                                            .uid)
                                                        .get()
                                                        .then((value) {
                                                      Map<String, dynamic>
                                                          inter = value.data()
                                                              as Map<String,
                                                                  dynamic>;
                                                      List en = inter["الطلبات"]
                                                          as List;
                                                      en.removeAt(i);
                                                      print(en);
                                                      inter["الطلبات"] = en;
                                                      col2
                                                          .doc(FirebaseAuth
                                                              .instance
                                                              .currentUser!
                                                              .uid)
                                                          .update(inter);
                                                    });
                                                  },
                                                ),
                                              )
                                            ],
                                          );
                                        }
                                      }),
                                    ));
                              },
                              title: Text(
                                  "Commande ${i + 1} - ${ordersList[i]["commande"]['totale_price']} DA"),
                              tileColor: Colors.grey,
                              subtitle: Text("Tap here to show more details"),
                              trailing: Image.asset("assets/moto.png"),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return Divider(
                            color: Colors.red,
                            height: 5,
                          );
                        },
                        itemCount: ordersList.length);
                  },
                  stream: getmyorders(),
                ),
                height: MediaQuery.of(context).size.height * 76 / 100,
              ),
            )
          ],
        ),
        height: MediaQuery.of(context).size.height * 86 / 100,
      ),
    );
  }
}
