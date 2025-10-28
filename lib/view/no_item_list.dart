import 'package:flutter/material.dart';

class NoItemList extends StatelessWidget {
  const NoItemList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/surgery.webp", height: 200),
          SizedBox(height: 20),
          Text("등록된 상품이 없습니다.", style: TextStyle(fontSize: 22)),
        ],
      ),
    );
  }
}
