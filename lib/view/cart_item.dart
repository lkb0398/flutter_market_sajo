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
                builder: (context) => DetailItem(list: widget.list, index: index),
              ),
            );
          },
          // onLongPress: () async {
          //   final updatedItem = await Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //       builder: (context) => ModifyItem(itemModel: widget.list[index]),
          //     ),
          //   );
          //   if (updatedItem != null) {
          //     setState(() {
          //       widget.list[index] = updatedItem;
          //     });
          //   }
          // },
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
                    Text(
                      widget.list[index].productName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),

                    Text(
                      "${NumberFormat("#,###").format(widget.list[index].price * widget.list[index].productCount)}원",
                      style: TextStyle(fontSize: 15),
                    ),
                    Text(
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
