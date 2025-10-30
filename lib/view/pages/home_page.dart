import 'package:flutter/material.dart';
import 'package:flutter_market_sajo/model/item_model.dart';
import 'package:flutter_market_sajo/theme.dart';
import 'package:flutter_market_sajo/view/pages/add_page.dart';
import 'package:flutter_market_sajo/view/pages/cart_page.dart';
import 'package:flutter_market_sajo/view/widgets/item_list.dart';
import 'package:flutter_market_sajo/view/widgets/no_item_list.dart';

// 홈 페이지
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ItemModel> list = [];
  void onChanged() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(), // 뒤로가기 버튼 없애기
        title: Image.asset("assets/images/logo.webp", height: 200),
        actions: [
          // 장바구니 버튼
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CartPage(list: list)),
            ),
            icon: Icon(Icons.shopping_cart_outlined, size: 30),
          ),
        ],
      ),
      body: (list.isEmpty
          ? NoItemList() // 등록된 상품이 없을 때 화면
          : ItemList(list: list)), // 등록된 상품이 있을 때 화면
      // 상품 추가 버튼
      floatingActionButton: FloatingActionButton(
        backgroundColor: cRed,
        shape: CircleBorder(),
        child: Icon(Icons.add, size: 50),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return AddPage(list: list, onChanged: onChanged);
              },
            ),
          );
        },
      ),
    );
  }
}
