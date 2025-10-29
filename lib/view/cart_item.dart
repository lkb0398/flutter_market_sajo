import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_market_sajo/view/cart.dart';
import 'package:intl/intl.dart';
import 'package:flutter_market_sajo/model/item_model.dart';

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
        return Container(
          margin: EdgeInsets.all(10),
          child: InkWell(
            onLongPress: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text("장바구니에서 삭제하시겠습니까?"),
                  actions: [
                    TextButton(
                      onPressed: () {
                        setState(() {
                          widget.list[index].productCount = 1;
                          widget.list[index].cart = false;
                        });
                        Navigator.of(context).pop();
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => Cart(list: widget.list),
                          ),
                        );
                      },
                      child: Text("삭제"),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          Navigator.of(context).pop();
                        });
                      },
                      child: Text("취소"),
                    ),
                  ],
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.white)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
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
                          style: TextStyle(fontSize: 25, color: Colors.red),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white24),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            spacing: 5,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    widget.list[index].productCount--;
                                    if (widget.list[index].productCount < 1) {
                                      widget.list[index].productCount = 99;
                                    }
                                  });
                                },
                                child: Icon(Icons.remove, color: Colors.red),
                              ),
                              Text(
                                "${widget.list[index].productCount}개",
                                style: TextStyle(fontSize: 20),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    widget.list[index].productCount++;
                                    if (widget.list[index].productCount > 99) {
                                      widget.list[index].productCount = 1;
                                    }
                                  });
                                },
                                child: Icon(Icons.add, color: Colors.red),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
