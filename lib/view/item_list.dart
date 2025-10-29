import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_market_sajo/model/item_model.dart';
import 'package:flutter_market_sajo/view/detail_item.dart';
import 'package:flutter_market_sajo/view/modify_item.dart';
import 'package:intl/intl.dart';

class ItemList extends StatefulWidget {
  const ItemList({super.key, required this.list});

  final List<ItemModel> list;
  @override
  State<ItemList> createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
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
          onLongPress: () async {
            final updatedItem = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ModifyItem(itemModel: widget.list[index]),
              ),
            );
            if (updatedItem != null) {
              setState(() {
                widget.list[index] = updatedItem;
              });
            }
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
                      Text(
                        widget.list[index].productName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),

                      Text(
                        widget.list[index].price == 0
                            ? "무료"
                            : "${NumberFormat("#,###").format(widget.list[index].price)} 원",
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
