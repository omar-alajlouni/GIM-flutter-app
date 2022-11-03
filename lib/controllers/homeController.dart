
 import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';


class HomeController extends GetxController{

 ///if user signIn
  RxBool notRegister = true.obs;

 ///if user data saved
  RxBool isNotRegs = true.obs;


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initLang();
    isSign();
    isReg();
    firsTime();
  }


  void firsTime()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();


    if(preferences.getString("first") == null){

      Get.defaultDialog(
        title:"welcome_title".tr ,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text("welcome_text".tr)
          ],
        ),
        actions: <Widget>[
          TextButton(
            child: Text("confirm".tr),
            // textColor: Colors.white,
            // color: Colors.blue,
            onPressed: () async{

             preferences.setString("first", "ok");
             Get.back();
            },
          )
        ],

      );
    }

  }



  isSign()async{
     //  await  FirebaseAuth.instance.signOut();
 //   print();
  //  print( await FirebaseAuth.instance.currentUser?.phoneNumber);

    if(await FirebaseAuth.instance.currentUser?.uid != null){
      notRegister.value = false;
    }
    else{
      notRegister.value = true;
    }
  }






  isReg()async{

    SharedPreferences preferences = await SharedPreferences.getInstance();

  // preferences.remove('reg');

    if(preferences.getBool("reg") != null){

      isNotRegs.value = false;
    }
    else{
      isNotRegs.value = true;
    }
  }

 late Rx<Locale> locale ;

  initLang()async{

    SharedPreferences pref = await SharedPreferences.getInstance();

    locale  = Locale('${pref.getString('lang_code')}', '${pref.getString('country_code')}').obs;

  }


  changeLang()async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    if (locale.value.languageCode == 'ar') {
      pref.setString('lang_code', 'en');
      pref.setString('country_code', 'US');
      locale.value = Locale('${pref.getString('lang_code')}',
          '${pref.getString('country_code')}');

      Get.updateLocale(locale.value);

      //  update();
    } else {
      pref.setString('lang_code', 'ar');
      pref.setString('country_code', 'DZ');
      locale.value = Locale('${pref.getString('lang_code')}',
          '${pref.getString('country_code')}');

      Get.updateLocale(locale.value);

      //update();
      // Get.updateLocale(locale);
      // locale.value = Locale('ar', 'DZ');
    }
  }

}