import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_market_sajo/model/item_model.dart';
import 'package:flutter_market_sajo/view/text_input_box.dart';
import 'package:flutter_market_sajo/view/title_image.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class AddItem extends StatefulWidget {
  const AddItem({super.key, required this.list, required this.onEmptyChanged});
  // HomePage 받아오기
  final List<ItemModel> list;
  final void Function() onEmptyChanged;

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
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
            Fluttertoast.showToast(
              msg: "이미지 선택 취소",
              gravity: ToastGravity.CENTER,
            );
          }
        })
        .catchError((err) {
          Fluttertoast.showToast(
            msg: "이미지 선택 중 오류 발생: $err",
            gravity: ToastGravity.CENTER,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Color(0xFF242424), title: TitleImage()),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 20,
            children: [
              // 이미지 선택 영역
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
              // 상품 이름 입력
              Row(
                spacing: 20,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('상품 이름', style: TextStyle(fontSize: 15)),
                  Expanded(
                    child: TextInputBox(
                      maxLines: 1,
                      controller: nameController,
                    ),
                  ),
                ],
              ),
              // 상품 가격 입력
              Row(
                spacing: 20,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('상품 가격', style: TextStyle(fontSize: 15)),
                  Expanded(
                    child: TextInputBox(
                      maxLines: 1,
                      controller: priceController,
                    ),
                  ),
                  Text('원', style: TextStyle(fontSize: 15)),
                ],
              ),
              // 상품 설명 입력
              Text('상품 설명', style: TextStyle(fontSize: 15)),
              TextInputBox(maxLines: 7, controller: descriptionController),
            ],
          ),
        ),
      ),
      // 수정하기 버튼
      bottomNavigationBar: GestureDetector(
        onTap: () {
          // 예외 처리
          if (nameController.text.isEmpty) {
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
          } else if (int.parse(priceController.text) < 0 ||
              100000000000000000 < int.parse(priceController.text)) {
            Fluttertoast.showToast(
              msg: "잘못된 가격입니다",
              gravity: ToastGravity.CENTER,
            );
          } else if (descriptionController.text.isEmpty) {
            Fluttertoast.showToast(
              msg: "상품 설명을 입력하세요",
              gravity: ToastGravity.CENTER,
            );
          } else {
            // 정상 입력 시
            widget.list.add(
              ItemModel(
                productName: nameController.text,
                price: int.parse(priceController.text),
                image: Image.file(
                  image!,
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
                description: descriptionController.text,
              ),
            );
            Fluttertoast.showToast(
              msg: "등록되었습니다",
              gravity: ToastGravity.CENTER,
            );
            Navigator.pop(context);
            widget.onEmptyChanged();
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
      ),
    );
  }
}
