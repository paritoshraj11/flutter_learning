import "package:flutter/material.dart";

class Product {
  final String title;
  final String description;
  final double price;
  final String image;
  final bool favourite;
  Product(
      {@required this.title,
      this.description,
      @required this.price,
      this.image,
      this.favourite = false});
}
