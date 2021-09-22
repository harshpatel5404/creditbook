import 'package:creditbook/models/user_model.dart';
import 'package:get/get.dart';

class Controller extends GetxController {
  RxList<UserModel> userlist = RxList<UserModel>();
  RxBool isLogin = false.obs;
  
}