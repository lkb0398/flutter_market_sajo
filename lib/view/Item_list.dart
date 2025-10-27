import 'package:flutter/material.dart';
import 'package:flutter_market_sajo/model/item_model.dart';
import 'package:flutter_market_sajo/view/detail_item.dart';

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
                builder: (context) => DetailItem(itemModel: widget.list[index]),
              ),
            );
          },
          child: Row(
            children: [
              widget.list[index].image,
              Column(
                children: [
                  Text(widget.list[index].productName),
                  Text(widget.list[index].price.toString()),
                  Text(widget.list[index].description),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
