import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:gim/register.dart';

import 'package:gim/home.dart';
import 'package:gim/order.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gim/utility/i18n.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SharedPreferences pref = await SharedPreferences.getInstance();
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'home',
      title: 'اخدم بلدك',
      locale: pref.getString('lang_code') != null ? Locale('${pref.getString('lang_code')}','${pref.getString('country_code')}') : const Locale('en' , 'US'),
      translations: Internationalize(),
      routes: {
        'home': (context) => Home(),
        'register': (context) => myRegister(),


      },
    ),
  );

}
