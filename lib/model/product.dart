import "package:flutter/material.dart";

class Product {
  final String id;
  final String title;
  final String description;
  final double price;
  final String image;
  final bool favourite;
  final String userId;
  final String userEmail;
  final String imagePath;
  Product(
      {@required this.id,
      @required this.title,
      this.description,
      @required this.price,
      this.image,
      this.favourite = false,
      @required this.userId,
      this.imagePath,
      @required this.userEmail});
}
