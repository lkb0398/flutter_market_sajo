import 'package:flutter/material.dart';
import 'package:flutter_market_sajo/model/item_model.dart';
import 'package:flutter_market_sajo/view/item_list.dart';
import 'package:flutter_market_sajo/view/no_cart_item.dart';
class Cart extends StatefulWidget {
  const Cart({super.key, required this.list});
  final List<ItemModel>list;
  @override
  State<Cart> createState() => _CartState();
}
class _CartState extends State<Cart> {
  List<ItemModel> Cartlist = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF242424),
        title: Image.asset("assets/images/logo.webp", height: 200),
      ),
      body: Cartlist.isEmpty ? NoCartItem() : ItemList(list: Cartlist),
    );
  }
}











