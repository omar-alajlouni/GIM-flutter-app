import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:gim/controllers/orderController.dart';
import 'dart:ffi';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class myOrder extends StatefulWidget {

  final bool isReg;
  const myOrder({Key? key , required this.isReg}) : super(key: key);
  @override
  _myOrderState createState() => _myOrderState();
}

class _myOrderState extends State<myOrder> {



  OrderController _order = Get.put(OrderController());

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //throw UnimplementedError();
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/order.png',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(
                          top: 30.0,
                        ),
                        child: const Text(
                          'Report filling form',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30.0,
                              fontWeight: FontWeight.w900,
                              shadows: <Shadow>[
                                Shadow(
                                  offset: Offset(5.0, 5.0),
                                  blurRadius: 8.8,
                                  color: Color.fromARGB(125, 0, 0, 255),
                                ),
                              ]),
                        ),
                      ),
                    ],
                  ),
                  SingleChildScrollView(
                    child: Padding(
                      padding:  EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.1,
                  left: 30,
                  right: 30,
                  ),
                      child: Column(
                        children: [
                          SizedBox(height: 15.0),
                          Visibility(
                             visible: widget.isReg,
                            child: TextField(
                              controller: _order.phone,
                              maxLength: 10,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(6),
                                //contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
                                fillColor: Color.fromRGBO(243, 242, 245, 0.471),
                                filled: true,
                                labelText: 'text_phone'.tr,
                                hintText: '07XXXXXXXX',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 226, 12, 12),
                                  ),
                                ),
                              ),
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                            ),
                          ),


                          TextField(
                            controller: _order.note,
                            maxLength: 500,
                            maxLines: 10,
                            minLines: 2,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(6),
                              //contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
                              fillColor: Color.fromRGBO(243, 242, 245, 0.471),
                              filled: true,
                              labelText: 'note_text'.tr,
                              hintText: 'note_hint'.tr,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 226, 12, 12),
                                ),
                              ),
                            ),
                            keyboardType: TextInputType.text,

                          ),
                          SizedBox(height: 0.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              DropdownButtonHideUnderline(
                                child: DropdownButton2(
                                  isExpanded: true,
                                  hint: Row(
                                    children: const [
                                      Icon(
                                        Icons.list,
                                        size: 22,
                                        color: Colors.yellow,
                                      ),
                                      SizedBox(
                                        width: 3,
                                      ),
                                      Expanded(
                                        child: Text(
                                          ' حدد البلدة/ اللواء',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.yellow,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  items: _order.items_cnt
                                      .map((item) => DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(
                                              item,
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ))
                                      .toList(),
                                  value: _order.selectedValue,
                                  onChanged: (value) {
                                    setState(() {
                                      _order.selectedValue = value as String;
                                      _order.checkFull(widget.isReg);
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.keyboard_double_arrow_down_sharp,
                                  ),
                                  iconSize: 22,
                                  iconEnabledColor: Colors.yellow,
                                  iconDisabledColor: Colors.grey,
                                  buttonHeight: 50,
                                  buttonWidth: MediaQuery.of(context).size.width /
                                      1.22, //322,
                                  buttonPadding:
                                      const EdgeInsets.only(left: 14, right: 14),
                                  buttonDecoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Colors.black26,
                                    ),
                                    color: Color.fromARGB(255, 36, 4, 168),
                                  ),
                                  buttonElevation: 2,
                                  itemHeight: 40,
                                  itemPadding:
                                      const EdgeInsets.only(left: 14, right: 14),
                                  dropdownMaxHeight: 300,
                                  dropdownWidth: MediaQuery.of(context).size.width /
                                      1.22, //322,
                                  dropdownPadding: null,
                                  dropdownDecoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    color: Color.fromARGB(255, 36, 4, 168),
                                  ),
                                  dropdownElevation: 8,
                                  scrollbarRadius: const Radius.circular(40),
                                  scrollbarThickness: 7,
                                  scrollbarAlwaysShow: true,
                                  offset: const Offset(0, 0),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 5.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              DropdownButtonHideUnderline(
                                child: DropdownButton2(
                                  isExpanded: true,
                                  hint: Row(
                                    children: const [
                                      Icon(
                                        Icons.list,
                                        size: 22,
                                        color: Colors.yellow,
                                      ),
                                      SizedBox(
                                        width: 3,
                                      ),
                                      Expanded(
                                        child: Text(
                                          ' حدد فرع العطل',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.yellow,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  items: _order.items_dep
                                      .map((item) => DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(
                                              item,
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ))
                                      .toList(),
                                  value: _order.selectedValue2,
                                  onChanged: (value) {
                                    setState(() {
                                      _order.selectedValue2 = value as String;
                                      _order.checkFull(widget.isReg);
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.keyboard_double_arrow_down_sharp,
                                  ),
                                  iconSize: 22,
                                  iconEnabledColor: Colors.yellow,
                                  iconDisabledColor: Colors.grey,
                                  buttonHeight: 50,
                                  buttonWidth: MediaQuery.of(context).size.width /
                                      1.22, //322,
                                  buttonPadding:
                                      const EdgeInsets.only(left: 14, right: 14),
                                  buttonDecoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Colors.black26,
                                    ),
                                    color: Color.fromARGB(255, 36, 4, 168),
                                  ),
                                  buttonElevation: 2,
                                  itemHeight: 40,
                                  itemPadding:
                                      const EdgeInsets.only(left: 14, right: 14),
                                  dropdownMaxHeight: 300,
                                  dropdownWidth: MediaQuery.of(context).size.width /
                                      1.22, //322,
                                  dropdownPadding: null,
                                  dropdownDecoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    color: Color.fromARGB(255, 36, 4, 168),
                                  ),
                                  dropdownElevation: 8,
                                  scrollbarRadius: const Radius.circular(40),
                                  scrollbarThickness: 7,
                                  scrollbarAlwaysShow: true,
                                  offset: const Offset(0, 0),
                                ),
                              ),
                            ],
                          ),

                        const  SizedBox(height: 5.0),


                          Container(
                              height: 150.0,
                              width:
                                  MediaQuery.of(context).size.width / 1.22, //322,
                              child: Obx(
                                 () {
                                  return ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: _order.imagefiles.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      return Stack(

                                        children: [


                                          Image.file(
                                              File(_order.imagefiles[index].path)),
                                          Positioned(
                                           top: 0,left: 0,
                                            child: IconButton(onPressed: (){
                                              setState(() {
                                                _order.imagefiles.removeAt(index);
                                                _order.count = (_order.count! - 1);
                                                _order.checkFull(widget.isReg);
                                              });

                                            },
                                                icon: Icon(Icons.delete_forever_sharp,color: Colors.red
                                                  ,)),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                              )),
                          SizedBox(height: 15.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                              //  color: Color.fromARGB(255, 172, 42, 85),
                                child: const Text(
                                  "حدد من المعرض",
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () {
                                  if (_order.count! <= 2) {


                                      _order.openImages(ImageSource.gallery);
                                      _order.checkFull(widget.isReg);


                                  } else {
                                    Fluttertoast.showToast(
                                        msg:
                                            "error_photo_no".tr,
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                  }
                                  setState(() {

                                  });
                                  debugPrint("Button clicked!");
                                },
                              ),
                              TextButton(
                              //  color: Color.fromARGB(255, 172, 42, 85),
                                child: const Text(
                                  "التقط من الكاميرا",
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () async {
                                  if (_order.count! <= 2) {
                                    _order.openImages(ImageSource.camera);
                                    _order.checkFull(widget.isReg);
                                  } else {
                                    Fluttertoast.showToast(
                                        msg:
                                            "error_photo_no".tr,
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                  }
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: 60.0),

                        ],
                      ),
                    ),
                  ),
                ],
              ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton:   Obx(
                  () {
                return Visibility(
                  visible: _order.isFull.value,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        //maximumSize: Size(320.0, 70.0),
                        //minimumSize: Size(320.0, 70.0),
                        primary: Color.fromARGB(161, 214, 4, 4),
                        shape: StadiumBorder(),
                      ),
                      onPressed: () {

                        _order.verifyPhoneNumber();
                      },
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        //crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'btn_send'.tr,
                            style: TextStyle(fontSize: 30.0),
                          ),
                          Icon(
                            Icons.send,
                            color: Color.fromARGB(255, 124, 255, 189),
                            size: 30.0,
                          ),
                        ],
                      )),
                );
              }
          ),
        ),
      ),
    );
  }


}
