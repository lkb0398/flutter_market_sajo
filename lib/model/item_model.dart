import 'package:flutter/material.dart';

class ItemModel {
  String productName; // 상품이름
  int price; // 상품 가격
  Image image; // 상품 이미지
  String description; // 상품 설명
  int productCount; // 상품 수량
  bool cart; // 장바구니 추가 여부

  ItemModel({
    required this.productName,
    required this.price,
    required this.image,
    required this.description,
    this.productCount = 1,
    this.cart = false,
  });
}
