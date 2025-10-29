import 'package:flutter/material.dart';
import 'package:flutter_market_sajo/model/item_model.dart';
import 'package:flutter_market_sajo/view/detail_item.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class CartItem extends StatefulWidget {
  const CartItem({super.key, required this.list, required this.onRemove});

  final List<ItemModel> list;
  final void Function(ItemModel) onRemove;

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
          onLongPress: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('상품삭제'),
                content: Text('${widget.list[index].productName}을 삭제하시겠습니까?'),
                actions: [
                  TextButton(
                    onPressed: () {
                      return Navigator.pop(context);
                    },
                    child: const Text('취소'),
                  ),
                  TextButton(
                    onPressed: () {
                      widget.onRemove(widget.list[index]);

                      Navigator.pop(context);
                      Fluttertoast.showToast(
                        msg: '${widget.list[index].productName}이 삭제되었습니다',
                        gravity: ToastGravity.CENTER,
                      );
                    },
                    child: const Text('확인'),
                  ),
                ],
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
