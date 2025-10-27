import 'package:flutter/material.dart';
import 'package:flutter_market_sajo/model/item_model.dart';

class ItemList extends StatelessWidget {
  const ItemList({super.key, required this.list});
  final List<ItemModel> list;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Expanded(
          child: Row(
            children: [
              list[index].image,
              Column(
                children: [
                  Text(list[index].productName),
                  Text(list[index].price.toString()),
                  Text(list[index].description),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
