import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_market_sajo/model/item_model.dart';
import 'package:flutter_market_sajo/view/detail_item.dart';
import 'package:intl/intl.dart';

class CartItem extends StatefulWidget {
  const CartItem({super.key, required this.list});
  final List<ItemModel> list;
  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.list.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    DetailItem(list: widget.list, index: index),
              ),
            );
          },
          child: Container(
            margin: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: widget.list[index].image,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  spacing: 10,
                  children: [
                    AutoSizeText(
                      maxLines: 1,
                      widget.list[index].productName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    AutoSizeText(
                      maxLines: 1,
                      "${NumberFormat("#,###").format(widget.list[index].price * widget.list[index].productCount)}원",
                      style: TextStyle(fontSize: 15),
                    ),
                    AutoSizeText(
                      maxLines: 1,
                      "${NumberFormat("#,###").format(widget.list[index].productCount)}개",
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
