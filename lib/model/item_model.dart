import 'package:flutter/material.dart';

class ItemModel {
  String productName; // 상품이름
  int price; // 상품 가격
  Image image; // 상품이미지
  String description; // 설명
  int productCount; // 제품 개수
  bool? isCart = false; // 카드 여부

  ItemModel({
    required this.productName,
    required this.price,
    required this.image,
    required this.description,
    required this.productCount,
    required this.isCart,
  });
}
