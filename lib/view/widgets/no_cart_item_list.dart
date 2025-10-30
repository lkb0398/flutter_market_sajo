import 'package:flutter/material.dart';

// 장바구니에 상품이 없을 때 화면
class NoCartItem extends StatelessWidget {
  const NoCartItem({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: Column(
        spacing: 20,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/pumpkin.webp", height: 200),
          Text("장바구니에 상품이 없습니다", style: TextStyle(fontSize: 22)),
        ],
      ),
    );
  }
}
