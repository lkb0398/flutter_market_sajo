import 'package:flutter/material.dart';
import 'package:flutter_market_sajo/model/item_model.dart';
import 'package:flutter_market_sajo/theme.dart';
import 'package:flutter_market_sajo/view/widgets/cart_item_list.dart';
import 'package:flutter_market_sajo/view/widgets/no_cart_item_list.dart';
import 'package:flutter_market_sajo/view/widgets/title_image.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

// 장바구니 페이지
class CartPage extends StatefulWidget {
  const CartPage({super.key, required this.list});

  final List<ItemModel> list;

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    // bool cart == true 인 상품만 필터링
    final cartItems = widget.list.where((item) => item.cart == true).toList();
    return Scaffold(
      appBar: AppBar(title: const TitleImage()),
      body: cartItems.isEmpty
          ? const NoCartItem() // 장바구니에 상품이 없을 때 화면
          : CartItem(list: cartItems), // 장바구니에 상품이 있을 때 화면
      // 구매하기 버튼
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
          color: cRed,
          child: Image.asset('assets/images/buy.webp', fit: BoxFit.contain),
        ),
      ),
    );
  }
}
