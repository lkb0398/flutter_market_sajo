import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_market_sajo/model/item_model.dart';
import 'package:flutter_market_sajo/view/pages/detail_page.dart';
import 'package:flutter_market_sajo/view/pages/modify_page.dart';
import 'package:intl/intl.dart';

// 등록된 상품이 있을 때 화면
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
          // 상품 탭 > 상품 상세 페이지로 이동
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    DetailPage(list: widget.list, index: index),
              ),
            );
          },
          // 상품 길게 탭 > 상품 수정 페이지로 이동
          onLongPress: () async {
            final updatedItem = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ModifyPage(itemModel: widget.list[index]),
              ),
            );
            if (updatedItem != null) {
              setState(() {
                widget.list[index] = updatedItem;
              });
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              spacing: 15,
              children: [
                // 상품 이미지
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: widget.list[index].image,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    spacing: 10,
                    children: [
                      //상품명
                      AutoSizeText(
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        widget.list[index].productName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                      // 가격
                      AutoSizeText(
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        minFontSize: 5,
                        widget.list[index].price == 0
                            ? "무료"
                            : "${NumberFormat("#,###").format(widget.list[index].price)}원",
                        style: TextStyle(fontSize: 25, color: Colors.red),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
