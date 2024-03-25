import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';

class product extends StatelessWidget {
  final String imagePath;
  final String title;
  final int price;
  final String classe;
  product(BuildContext context,
      {required this.imagePath,
      required this.title,
      required this.price,
      required this.classe});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 20 / 100,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 50 / 100,
              child: FittedBox(
                  child: CachedNetworkImage(
                fit: BoxFit.contain,
                imageUrl: imagePath,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Center(
                  child: CircularProgressIndicator(
                    value: downloadProgress.progress,
                    color: Colors.red,
                  ),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              )),
              height: MediaQuery.of(context).size.height * 10 / 100,
            ),
          ),
          Container(
            child: FittedBox(
              child: Text(title),
            ),
            height: MediaQuery.of(context).size.height * 2.5 / 100,
          ),
          classe != "pizza"
              ? price != 0
                  ? Container(
                      child: FittedBox(
                        child: Text(
                          "$price Da",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.green),
                        ),
                      ),
                      height: MediaQuery.of(context).size.height * 2.5 / 100,
                    )
                  : Text("")
              : Text("pizza price"),
        ],
      ),
    );
  }
}

class pizza_product extends StatelessWidget {
  final String imagePath;
  final String title;
  final List? sizes;
  final String classe;
  pizza_product(BuildContext context,
      {required this.imagePath,
      required this.title,
      required this.sizes,
      required this.classe});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 20 / 100,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 50 / 100,
              child: FittedBox(
                  child: CachedNetworkImage(
                fit: BoxFit.contain,
                imageUrl: imagePath,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Center(
                  child: CircularProgressIndicator(
                    value: downloadProgress.progress,
                    color: Colors.red,
                  ),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              )),
              height: MediaQuery.of(context).size.height * 10 / 100,
            ),
          ),
          Container(
            child: FittedBox(
              child: Text(title),
            ),
            height: MediaQuery.of(context).size.height * 2.5 / 100,
          ),
          Container(
            child: FittedBox(
              child: Row(
                children: List.generate(sizes!.length, ((index) {
                  return Row(children: [
                    Icon(Icons.point_of_sale),
                    Text(
                      "${sizes![index]["price"]} Da",
                      style: TextStyle(color: Colors.green),
                    )
                  ]);
                })),
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              ),
            ),
            height: MediaQuery.of(context).size.height * 2.5 / 100,
          ),
        ],
      ),
    );
  }
}
