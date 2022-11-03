// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:get/get.dart';
import 'package:gim/controllers/homeController.dart';
import 'package:gim/order.dart';
import 'package:gim/register.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _myHomeState createState() => _myHomeState();
}

class _myHomeState extends State<Home> {

  HomeController controller = Get.put(HomeController());


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //throw UnimplementedError();
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/login.png',
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
                    padding: EdgeInsets.only(
                      top: 30.0,
                    ),
                    child: Text(
                      'Municipality'.tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 40.0,
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
                child: Container(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.4,
                    left: 35,
                    right: 35,
                    bottom: 5,
                  ),
                  child:  Column(
                        children: [

                          SizedBox(height: 20.0),

                          Obx(
                            () {
                              return Visibility(
                                visible: controller.notRegister.value,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      // maximumSize: Size(
                                      //     MediaQuery.of(context).size.width / 1.7,
                                      //     50.0), //230, 50
                                      // minimumSize: Size(
                                      //     MediaQuery.of(context).size.width / 1.7,
                                      //     50.0), //230, 50
                                      primary: Color.fromARGB(255, 81, 13, 177),
                                      shape: StadiumBorder(),
                                    ),
                                    onPressed: () {
                                      Get.to(()=>myRegister());
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        //crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Registration'.tr,
                                            style: TextStyle(fontSize: 20.0),
                                          ),
                                          Icon(
                                            Icons.app_registration,
                                            color: Color.fromARGB(255, 124, 255, 189),
                                          ),
                                        ],
                                      ),
                                    )),
                              );
                            }
                          ),
                          SizedBox(height: 10.0),






                          SizedBox(height: 50.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(

                                    primary: Color.fromARGB(161, 214, 4, 4),
                                    shape: StadiumBorder(),
                                  ),
                                  onPressed: () {
                                   Get.to(()=>myOrder(isReg: controller.isNotRegs.value));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 20),                                child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      //crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'report'.tr,
                                          style: TextStyle(fontSize: 25.0),
                                        ),
                                        Icon(
                                          Icons.send_sharp,
                                          color: Color.fromARGB(255, 124, 255, 189),
                                          size: 30.0,
                                        ),
                                      ],
                                    ),
                                  )),
                            ],
                          ),
                          SizedBox(height: 30.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                //onPressed: () {
                                //Navigator.pushNamed(context, 'instructions');
                                onPressed: () {
                                  showAlertDialog(context);
                                },
                                child: Text(
                                  'Instructions'.tr,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 23.0,
                                      fontWeight: FontWeight.w900),
                                ),
                              ),
                              TextButton(
                                //onPressed: () {
                                //Navigator.pushNamed(context, 'policies');
                                onPressed: () {
                                  showAlertDialog2(context);
                                },
                                child: Text(
                                  'Policies'.tr,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 23.0,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          IconButton(
                              icon: Icon(Icons.language,color: Colors.red,),
                              onPressed: () {

                                controller. changeLang();
                              }
                          ),
                        ],
                      )

                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

showAlertDialog(BuildContext context) {
  // Create button
  Widget okButton = TextButton(
    child: Text("ok".tr),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("instruction_title".tr),
    content: SingleChildScrollView(
      // won't be scrollable
      child: Text(
          "instruction_message".tr),
    ),
    actions: [
      okButton,
    ],
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

showAlertDialog2(BuildContext context) {
  Widget okButton = TextButton(
    child: Text("ok".tr),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  AlertDialog alert = AlertDialog(
    title: Text("policies_title".tr),
    content: SingleChildScrollView(
      child: Text(
        "policies_message".tr),
      ),
    actions: [
      okButton,
    ],
  );
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
