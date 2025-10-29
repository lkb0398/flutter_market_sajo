import 'package:flutter/material.dart';
import 'package:flutter_market_sajo/model/item_model.dart';
import 'package:flutter_market_sajo/view/cart_item.dart';
import 'package:flutter_market_sajo/view/no_cart_item.dart';
import 'package:flutter_market_sajo/view/title_image.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class Cart extends StatefulWidget {
  const Cart({super.key, required this.list});
  final List<ItemModel> list;
  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
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
        onTap: () {
          if (cartItems.isEmpty) {
            Fluttertoast.showToast(
              msg: "장바구니가 비어 있습니다",
              gravity: ToastGravity.CENTER,
            );
            return;
          } else {
            int totalPirce = 0;
            for (var item in cartItems) {
              totalPirce += item.price * item.productCount;
            }
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text(
                  style: TextStyle(fontSize: 20),
                  "총 구매 금액은 ${NumberFormat("#,###").format(totalPirce)}원 입니다. 정말로 구매 하시겠습니까?",
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "취소",
                      style: TextStyle(fontSize: 20, color: Colors.grey),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        // cart == true인 상품만 필터링

                        final count = cartItems.length;
                        // 구매 처리 (cart 상태 초기화)
                        setState(() {
                          for (var item in cartItems) {
                            item.cart = false; // 구매 완료 후 비우기
                            item.productCount = 1;
                          }
                        });
                        Fluttertoast.showToast(
                          msg: "$count개 상품이 구매되었습니다",
                          gravity: ToastGravity.CENTER,
                        );
                        Navigator.pop(context); // 홈으로 복귀
                      });
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "구매",
                      style: TextStyle(fontSize: 20, color: Colors.red),
                    ),
                  ),
                ],
              ),
            );
          }
        },
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
