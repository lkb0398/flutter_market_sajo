import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_market_sajo/model/item_model.dart';
import 'package:flutter_market_sajo/theme.dart';
import 'package:flutter_market_sajo/view/widgets/title_image.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

// 상품 상세 페이지
class DetailItem extends StatefulWidget {
  const DetailItem({super.key, required this.list, required this.index});

  final List<ItemModel> list;
  final int index;

  @override
  State<DetailItem> createState() => _DetailItemState();
}

class _DetailItemState extends State<DetailItem> {
  int number = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: TitleImage()),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 상품 이미지
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                  width: double.infinity,
                  child: AspectRatio(
                    aspectRatio: 3 / 2,
                    child: Image(
                      image: widget.list[widget.index].image.image,
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              // 상품 이름
              AutoSizeText(
                widget.list[widget.index].productName,
                maxLines: 1,
                minFontSize: 14,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              // 상품 가격
              AutoSizeText(
                "${NumberFormat("#,###").format(widget.list[widget.index].price)}원", // 가격
                maxLines: 1,
                minFontSize: 12,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 30, color: Colors.red),
              ),
              SizedBox(height: 16),
              // 상품 설명
              Text(
                widget.list[widget.index].description,
                style: TextStyle(fontSize: 25),
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // 상품 수량 조절
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white24),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            number--;
                            if (number < 1) {
                              number = 99;
                            }
                          });
                        },
                        child: Icon(Icons.remove, size: 50, color: Colors.red),
                      ),
                      Text("$number개", style: TextStyle(fontSize: 30)),
                      InkWell(
                        onTap: () {
                          setState(() {
                            number++;
                            if (number > 99) {
                              number = 1;
                            }
                          });
                        },
                        child: Icon(Icons.add, size: 50, color: Colors.red),
                      ),
                    ],
                  ),
                ),
                // 총 가격
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text("총 가격"),
                    SizedBox(
                      child: AutoSizeText(
                        "${NumberFormat("#,###").format(widget.list[widget.index].price * number)}원",
                        maxLines: 1,
                        minFontSize: 5,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          // 장바구니 버튼
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(),
                backgroundColor: cRed,
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(
                      style: TextStyle(fontSize: 20),
                      "장바구니에 상품을 담으시겠습니까?",
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "취소",
                          style: TextStyle(fontSize: 20, color: Colors.grey),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            widget.list[widget.index].productCount = number;
                            widget.list[widget.index].cart = true;
                          });
                          Fluttertoast.showToast(
                            msg: "장바구니에 담겼습니다.",
                            gravity: ToastGravity.CENTER,
                          );
                          Navigator.of(context)
                            ..pop()
                            ..pop();
                        },
                        child: Text(
                          "확인",
                          style: TextStyle(fontSize: 20, color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                );
              },
              child: Image.asset("assets/images/cart.webp", height: 60),
            ),
          ),
        ],
      ),
    );
  }
}
