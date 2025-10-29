import 'package:flutter/material.dart';
import 'package:flutter_market_sajo/model/item_model.dart';
import 'package:flutter_market_sajo/view/cart_item.dart';
import 'package:flutter_market_sajo/view/no_cart_item.dart';
import 'package:flutter_market_sajo/view/title_image.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Cart extends StatefulWidget {
  const Cart({super.key, required this.list});
  final List<ItemModel> list;
  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  void _buyItems() {
    // cart == true인 상품만 필터링
    final cartItems = widget.list.where((item) => item.cart == true).toList();
    if (cartItems.isEmpty) {
      Fluttertoast.showToast(
        msg: "장바구니가 비어 있습니다",
        gravity: ToastGravity.CENTER,
      );
      return;
    }
    final count = cartItems.length;
    // 구매 처리 (cart 상태 초기화)
    setState(() {
      for (var item in cartItems) {
        item.cart = false; // 구매 완료 후 비우기
      }
    });
    Fluttertoast.showToast(
      msg: "$count개 상품이 구매되었습니다",
      gravity: ToastGravity.CENTER,
    );
    Navigator.pop(context); // 홈으로 복귀
  }

  @override
  Widget build(BuildContext context) {
    // cart == true 인 상품만 화면에 표시
    final cartItems = widget.list.where((item) => item.cart == true).toList();
    return Scaffold(
      appBar: AppBar(title: const TitleImage()),
      body: cartItems.isEmpty
          ? const NoCartItem()
          : CartItem(list: cartItems), // 필터링된 상품만 보여줌
      bottomNavigationBar: GestureDetector(
        onTap: _buyItems,
        child: Container(
          height: 70,
          width: double.infinity,
          color: const Color(0xFFA70E0E),
          child: Image.asset('assets/images/buy.webp', fit: BoxFit.contain),
        ),
      ),
    );
  }
}
