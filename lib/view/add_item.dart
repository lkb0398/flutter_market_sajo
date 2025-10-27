import 'package:flutter/material.dart';
import 'package:flutter_market_sajo/model/item_model.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddItem extends StatefulWidget {
  const AddItem({super.key, required this.list, required this.onEmptyChanged});
  // HomePage 받아오기
  final List<ItemModel> list;
  final void Function() onEmptyChanged;
  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  // select = 선택한 이미지
  // onSelectChanged = select 상태 변경 후 페이지 rebuild
  String? select;
  void onSelectChanged(newSelect) {
    setState(() => select = newSelect);
  }

  // TextField 입력값 받기
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  // 페이지 구조
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF242424),
        title: Image.asset("assets/images/logo.webp", height: 200),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 20,
            children: [
              ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(10),
                child: GridView.count(
                  padding: EdgeInsets.zero,
                  crossAxisCount: 3,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    board(select, onSelectChanged, 'bronze_board'),
                    board(select, onSelectChanged, 'diamond_board'),
                    board(select, onSelectChanged, 'gold_board'),
                    board(select, onSelectChanged, 'jade_board'),
                    board(select, onSelectChanged, 'silver_board'),
                    board(select, onSelectChanged, 'wood_board'),
                  ],
                ),
              ),
              name(context, nameController),
              price(context, priceController),
              Text('상품 설명', style: TextStyle(fontSize: 15)),
              description(context, descriptionController),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Registration(
        context,
        select,
        nameController,
        priceController,
        descriptionController,
        widget.list,
        widget.onEmptyChanged,
      ),
    );
  }
}

// 위젯
Widget board(select, onSelectChanged, String board) {
  return GestureDetector(
    onTap: () => onSelectChanged(board),
    child: Container(
      decoration: select == board
          ? BoxDecoration(border: Border.all(color: Colors.red, width: 5))
          : null,
      child: Image.asset('assets/images/$board.webp', fit: BoxFit.cover),
    ),
  );
}

Widget name(context, nameController) {
  return Row(
    spacing: 20,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text('상품 이름', style: TextStyle(fontSize: 15)),
      Expanded(
        child: Container(
          padding: EdgeInsets.only(left: 5, right: 5, bottom: 5),
          height: 30,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            controller: nameController,
            maxLines: 1,
            decoration: InputDecoration(border: InputBorder.none),
          ),
        ),
      ),
    ],
  );
}

Widget price(context, priceController) {
  return Row(
    spacing: 20,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text('상품 가격', style: TextStyle(fontSize: 15)),
      Expanded(
        child: Container(
          padding: EdgeInsets.only(left: 5, right: 5, bottom: 5),
          height: 30,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            controller: priceController,
            maxLines: 1,
            decoration: InputDecoration(border: InputBorder.none),
          ),
        ),
      ),
      Text('원', style: TextStyle(fontSize: 15)),
    ],
  );
}

Widget description(context, descriptionController) {
  return Container(
    decoration: BoxDecoration(
      border: Border.all(color: Colors.white),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        controller: descriptionController,
        maxLines: 7,
        textInputAction: TextInputAction.newline,
        decoration: InputDecoration(border: InputBorder.none),
        onTapOutside: (event) => FocusScope.of(context).unfocus(),
      ),
    ),
  );
}

Widget Registration(
  context,
  select,
  nameController,
  priceController,
  descriptionController,
  list,
  onEmptyChanged,
) {
  return GestureDetector(
    onTap: () {
      // 예외 처리
      if (select == null) {
        Fluttertoast.showToast(msg: "상품을 선택하세요", gravity: ToastGravity.CENTER);
      } else if (nameController.text.isEmpty) {
        Fluttertoast.showToast(
          msg: "상품 이름을 입력하세요",
          gravity: ToastGravity.CENTER,
        );
      } else if (priceController.text.isEmpty) {
        Fluttertoast.showToast(
          msg: "상품 가격을 입력하세요",
          gravity: ToastGravity.CENTER,
        );
      } else if (int.tryParse(priceController.text) == null) {
        Fluttertoast.showToast(
          msg: "상품 가격은 숫자로 입력해야 합니다",
          gravity: ToastGravity.CENTER,
        );
      } else if (descriptionController.text.isEmpty) {
        Fluttertoast.showToast(
          msg: "상품 설명을 입력하세요",
          gravity: ToastGravity.CENTER,
        );
      } else {
        // 정상 입력 시
        list.add(
          ItemModel(
            productName: nameController.text,
            price: int.parse(priceController.text),
            image: Image.asset('assets/images/$select.webp', height: 100),
            description: descriptionController.text,
          ),
        );
        Fluttertoast.showToast(msg: "등록되었습니다", gravity: ToastGravity.CENTER);
        Navigator.pop(context);
        onEmptyChanged();
      }
    },
    child: Container(
      height: 70,
      width: double.infinity,
      color: Color(0xFF242424),
      child: Image.asset(
        'assets/images/registration.webp',
        fit: BoxFit.contain,
      ),
    ),
  );
}
