import 'package:flutter/material.dart';
import 'package:flutter_market_sajo/model/item_model.dart';
import 'package:flutter_market_sajo/view/item_list.dart';
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
    if (widget.list.isEmpty) {
      Fluttertoast.showToast(
        msg: "장바구니가 비어 있습니다",
        gravity: ToastGravity.CENTER,
      );
      return;
    }

    final count = widget.list.length;

    setState(() {
      widget.list.clear();
    });

    Fluttertoast.showToast(
      msg: "$count개 상품이 구매되었습니다",
      gravity: ToastGravity.CENTER,
    );

    Navigator.pop(context); // 홈으로 복귀
  }

  @override
  Widget build(BuildContext context) {
    final cartList = widget.list;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF242424),
        title: const TitleImage(),
      ),
      body: cartList.isEmpty
          ? const NoCartItem()
          : ItemList(list: cartList),

      bottomNavigationBar: GestureDetector(
        onTap: _buyItems,
        child: Container(
          height: 70,
          width: double.infinity,
          color: const Color(0xFF242424),
          child: Image.asset(
            'assets/images/registration.webp',
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
