import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class order_product {
  int amount;
  final String imagepath;
  final int price;
  final String classe;
  final String title;

  order_product({
    required this.classe,
    required this.amount,
    required this.imagepath,
    required this.title,
    required this.price,
  });
}

class pizzaproduct extends order_product {
  String? size;
  final List real_price;
  pizzaproduct(
      {required super.classe,
      required super.amount,
      required super.imagepath,
      required super.title,
      required super.price,
      required this.real_price});
}

class optional_product extends order_product {
  List<dynamic> options;
  List<bool> options_selections;
  String? selected_option;

  optional_product({
    required this.selected_option,
    required super.classe,
    required super.amount,
    required super.imagepath,
    required super.title,
    required super.price,
    required this.options,
    required this.options_selections,
  });
}

class burger_product extends order_product {
  List<dynamic> priced_options;

  List<String>? selected_options = [];
  List<bool> options_selections;

  burger_product({
    required this.options_selections,
    required super.amount,
    required super.imagepath,
    required super.title,
    required super.price,
    required this.priced_options,
    required this.selected_options,
    required super.classe,
  });
}

class tacos_product {}
