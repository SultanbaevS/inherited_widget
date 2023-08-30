import 'package:flutter/cupertino.dart';

class Product {
  final String id;
  final String pictureURL;
  final String title;
  final TextSpan description;

  Product({
    required this.id,
    required this.pictureURL,
    required this.title,
    required this.description,
  });
}
