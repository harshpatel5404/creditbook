import 'dart:io';
import 'package:creditbook/controller/controller.dart';
import 'package:creditbook/dashboard.dart';
import 'package:creditbook/models/user_model.dart';
import 'package:creditbook/screens/userLogin/signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/userLogin/Before_login.dart';

bool isLogin = false;
SharedPreferences? prefs; 
Future<void> main() async {

WidgetsFlutterBinding.ensureInitialized();
  Directory directory = await getTemporaryDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(UserModelAdapter()); 
prefs = await SharedPreferences.getInstance();


    runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

   
    return GetMaterialApp(
      title: 'Credit Book',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),

      home:  prefs!.getBool('isLoggedIn') == true  ? Beforelogin() : Beforelogin(),
    );
  }
}
