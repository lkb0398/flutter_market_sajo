import 'package:flutter/material.dart';

class ItemModel {
  String? title; // 제목
  String productName; // 상품이름
  int price; // 상품 가격
  Image image; // 상품이미지
  String description; // 설명
  int? productCount;
  bool cart; // 제품 개수

  ItemModel({
    this.title,
    required this.productName,
    required this.price,
    required this.image,
    required this.description,
    this.productCount,
    this.cart = false,
  });
}
