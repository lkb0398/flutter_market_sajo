import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_market_sajo/model/item_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class ModifyItem extends StatefulWidget {
  const ModifyItem({super.key, required this.itemModel});
  final ItemModel itemModel;
  @override
  State<ModifyItem> createState() => _ModifyItemState();
}

class _ModifyItemState extends State<ModifyItem> {
  // 사용자 입력값 받기 (TextField)
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  // 앨범에서 이미지 가져오기 (ImagePicker)
  File? image;
  void selectImage() {
    ImagePicker()
        // 갤러리 열기 > return Future<XFile?>
        .pickImage(source: ImageSource.gallery)
        // 갤러리에서 파일 선택 후 실행할 코드
        .then((pickedFile) {
          if (pickedFile != null) {
            // 선택된 이미지가 있으면 File(pickedFile.path)로 변환 후 image에 저장
            setState(() => image = File(pickedFile.path));
          } else {
            Fluttertoast.showToast(msg: "이미지 선택 취소");
          }
        })
        .catchError((err) {
          Fluttertoast.showToast(msg: "이미지 선택 중 오류 발생: $err");
        });
  }
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
              GestureDetector(
                onTap: selectImage,
                child: ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(10),
                  child: AspectRatio(
                    aspectRatio: 3 / 2,
                    child: Container(
                      width: double.infinity,
                      color: Color(0xFF242424),
                      child: image != null
                          ? Image.file(image!, fit: BoxFit.cover)
                          : Center(child: Text("이미지 선택")),
                    ),
                  ),
                ),
              ),
              Name(context, nameController),
              Price(context, priceController),
              Text('상품 설명', style: TextStyle(fontSize: 15)),
              Description(context, descriptionController),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Registeration(
        context,
        image,
        nameController,
        priceController,
        descriptionController,
        widget.itemModel
      ),
    );
  }
}
// 위젯
Widget Board(select, onSelectChanged, String board) {
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
Widget Name(context, nameController) {
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
Widget Price(context, priceController) {
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
Widget Description(context, descriptionController) {
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
Widget Registeration(
  BuildContext context,
  File? image,
  TextEditingController nameController,
  TextEditingController priceController,
  TextEditingController descriptionController,
  ItemModel ItemModel,
) {
  return GestureDetector(
    onTap: () {
      if (nameController.text.isEmpty) {
        Fluttertoast.showToast(msg: "상품 이름을 입력하세요",gravity: ToastGravity.CENTER,);
      } else if (priceController.text.isEmpty) {
        Fluttertoast.showToast(msg: "상품 가격을 입력하세요",gravity: ToastGravity.CENTER,);
      } else if (int.tryParse(priceController.text) == null) {
        Fluttertoast.showToast(msg: "상품 가격은 숫자로 입력해야 합니다",gravity: ToastGravity.CENTER,);
      } else if (descriptionController.text.isEmpty) {
        Fluttertoast.showToast(msg: "상품 설명을 입력하세요",gravity: ToastGravity.CENTER);
      } else {
        ItemModel.productName = nameController.text;
        ItemModel.price = int.parse(priceController.text);
        ItemModel.image = Image.file(image!);
        ItemModel.description = descriptionController.text;

        Fluttertoast.showToast(msg: "상품이 수정되었습니다");
        Navigator.pop(context);
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