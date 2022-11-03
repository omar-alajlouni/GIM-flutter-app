import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gim/controllers/authController.dart';
import 'package:gim/controllers/homeController.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:mac_address/mac_address.dart';
import 'package:uuid/uuid.dart';

class OrderController extends GetxController{



  final ImagePicker imgpicker = ImagePicker();
  RxList imagefiles = [].obs ;
 // List<CameraDescription>? cameras; //list out the camera available
 // CameraController? controller; //controllers for camera
 // XFile? image; //for captured image
  RxInt? count =0.obs;
  TextEditingController phone = TextEditingController();
  TextEditingController note = TextEditingController();


  final List<String> items_cnt = [
    'لواء قصبة إربد - بدلية إربد الكبرى',
    'لواء قصبة إربد - بدلية غرب إربد',
    'لواء بني عبيد - بلدية إربد الكبرى',
    'لواء الكورة- بلدية دير أبو سعيد الجديدة',
    'لواء الكورة - بلدية برقش',
    'لواء الكورة -  بلدية رابية الكورة',
    'لواء الرمثا - بلدية الرمثا الجديدة',
    'لواء الرمثا - بلدية سهل حوران',
  ];
  final List<String> items_dep = [

    'إنارة الطريق',
    'تعبيد الطرق',
    'تمديدات المياه الصحية',
    'شبكة الصرف الصحي',
    'شبكات الكهرباء',
    'أعطال أخرى'
  ];
   String?  selectedValue ;
   String? selectedValue2 ;


  HomeController _controller =Get.put(HomeController());

  @override
  void onInit() async{
    // TODO: implement onInit
    super.onInit();

    count?.value = imagefiles.length;


   await savePhoneNumber();
  await  getMac();

    await  locationService();
    await requestPermission();



  }

  String mac = "";

  getMac()async{
    mac =   await GetMac.macAddress;

    print(await GetMac.macAddress);
  }

  savePhoneNumber()async{
    if(!_controller.isNotRegs.value){
      phone.text = (await FirebaseAuth.instance.currentUser?.phoneNumber)!;
    }
  } //for delete phone field


  openImages(source) async {
    try {
      var pickedfiles = await imgpicker.pickImage(source: source);


      if (pickedfiles != null) {
        imagefiles.add(File(pickedfiles.path));
        count?.value = imagefiles.length;
        update();
      } else {
        print("No image is selected.");
      }
    } catch (e) {
      print("error while picking file.");
    }
  }




  RxBool isFull = false.obs;

  checkFull( bool isRegs) async{

///;l
    if (phone.text.isNotEmpty ||
          selectedValue!.isNotEmpty &&
          selectedValue2!.isNotEmpty &&
          imagefiles.length>=1) {
        isFull.value = true;
      } else {
        isFull.value = false;
      }
      update();
  }

  Location location = new Location();

  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  late LocationData _locationData;

    locationService()async{
      _serviceEnabled = await location.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await location.requestService();
        if (!_serviceEnabled) {
          return;
        }
      }
    }

    requestPermission()async{

      _permissionGranted = await location.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await location.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          return;
        }
      }
    }


  Future<String> uploadFile(File _image , String orderId) async {
    Uuid uuid = Uuid();

   late Future<String>  url ;

    Reference storageReference = FirebaseStorage.instance
        .ref()
        .child('orders/${orderId}/');

    UploadTask task =  storageReference.child('${uuid.v1()}').putFile(_image);

    await task.then((e) {

       url = e.ref.getDownloadURL();


    });

    return await url;

  }
   sendOrder()async {





     _locationData = await location.getLocation();
      print(_locationData);

     if(_serviceEnabled && _permissionGranted==PermissionStatus.granted){

       Uuid uuid = Uuid();

       String  _orderId = uuid.v4();


       List<String> images = await Future.wait(imagefiles.value.map((e)=>uploadFile(e,_orderId)));




    String? userId =  await FirebaseAuth.instance.currentUser?.uid;


       await  FirebaseFirestore.instance.collection('orders').doc(_orderId).set({
         "uid":"${userId}", //forgin key
         "id":_orderId,
         "phone":"+962${phone.text.substring(1)}",
         "country" :selectedValue,
         "department": selectedValue2,
         "images" : images,
         "note": note.text,
         "location" :{"lat":_locationData.latitude, "long":_locationData.longitude},
         "mac_address" :mac,
         "date": DateTime.now()
       }).then((value)async{
       Get.back();
       //555
       Get.back();

       Get.snackbar("success_title".tr, "success_text".tr,
           duration: Duration(seconds: 5),
           backgroundColor: Colors.green,
           snackPosition: SnackPosition.BOTTOM);

       });

     }else{

       Get.snackbar("error_location_title".tr , "error_location_text".tr,
           duration: Duration(seconds: 5),
           backgroundColor: Colors.yellow,
           snackPosition: SnackPosition.BOTTOM);
     }




   }



// if the phone exist no check into order page
   verifyPhoneNumber(){

    if(_controller.isNotRegs.value){


      loginUser();

    }else{
      sendOrder();
    }
   }

  TextEditingController otp = TextEditingController();

  ///Log in and send a message to the user's phone from this function
  Future loginUser() async{


    FirebaseAuth _auth = FirebaseAuth.instance;

    _auth.verifyPhoneNumber(codeAutoRetrievalTimeout:( String v){
      print(v);
    },
      phoneNumber: "+962${phone.text.substring(1)}",
      timeout: Duration(seconds: 60),

      verificationCompleted: (AuthCredential credential) async{

      },

      verificationFailed: (FirebaseAuthException exception){
        Get.snackbar('error_auth_title'.tr, 'error_auth_text'.tr,
            duration: Duration(seconds: 5),
            backgroundColor: Colors.yellow,
            snackPosition: SnackPosition.BOTTOM);
        print(exception);
      },
      codeSent: (String? verificationId, [int? forceResendingToken]){
        codeSentDialog(codeController: otp,auth: _auth,verificationId: verificationId);
      },
      //codeAutoRetrievalTimeout: null
    );
  }


  ///If a message is sent to the user's phone, a dialog appears for the user to enter the code
  codeSentDialog({codeController, verificationId,auth}){

    Get.defaultDialog(
      title:"confirm_title".tr ,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextField(
            controller: codeController,
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: Text("confirm".tr),
          // textColor: Colors.white,
          // color: Colors.blue,
          onPressed: () async{

            final code = codeController.text.trim();

            //send SMS with code on user's phone
            AuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: code);

            UserCredential result = await auth.signInWithCredential(credential);

            User? user = result.user;

            if(user != null){


              //route to Home screen without returning
              //Get.reset();
              // SystemNavigator.pop();
              // Get.reset();
              // Get.off(Home());
              //  Get.offAll(()=>Home());

              sendOrder();
              Get.back();
              //555
              Get.back();
              await  FirebaseAuth.instance.signOut();  //for sign out to next time
            }else{
              print("Error");
            }
          },
        )
      ],

    );

  }

}