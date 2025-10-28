import 'package:flutter/material.dart';
import 'package:flutter_market_sajo/model/item_model.dart';
import 'package:flutter_market_sajo/view/add_item.dart';
import 'package:flutter_market_sajo/view/cart.dart';
import 'package:flutter_market_sajo/view/item_list.dart';
import 'package:flutter_market_sajo/view/no_item_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ItemModel> list = [];
  void onEmptyChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset("assets/images/logo.webp", height: 200),
        actions: [
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Cart(list: list)),
            ),
            icon: Icon(Icons.shopping_cart_outlined, size: 30),
          ),
        ],
      ),
      body: list.isEmpty ? NoItemList() : ItemList(list: list),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFFA70E0E),
        shape: CircleBorder(),
        child: Icon(Icons.add, size: 50),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return AddItem(list: list, onEmptyChanged: onEmptyChanged);
              },
            ),
          );
        },
      ),
    );
  }
}
