import 'dart:io';
import 'package:creditbook/models/user_model.dart';
import 'package:creditbook/screens/userLogin/signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
Future<void> main() async {
WidgetsFlutterBinding.ensureInitialized();
  Directory directory = await getTemporaryDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(UserModelAdapter()); 
  
    runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Credit Book',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SignupPage(),
    );
  }
}
