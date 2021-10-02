import 'package:contacts_service/contacts_service.dart';
import 'package:creditbook/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class Controller extends GetxController {
  RxBool isLogin = false.obs;
  var selectind = 0.obs;
  var btntxt = "Skip".obs;
  List allcontacts = [].obs;
  RxBool isConatctpermission = false.obs;

  Future getPermission(BuildContext context) async {
    final permission = await Permission.contacts.request();
    final PermissionStatus status = await Permission.contacts.status;
    if (permission.isGranted == true || status.isGranted) {
      await getContacts();
      isConatctpermission = true as RxBool;
    } else {
      isConatctpermission = false as RxBool;
      showDialog(
          context: context,
          builder: (BuildContext context) => CupertinoAlertDialog(
                title: Text('Permissions error'),
                content: Text('Please enable contacts access '
                    'permission in system settings'),
                actions: <Widget>[
                  CupertinoDialogAction(
                    child: Text('OK'),
                    onPressed: () => Navigator.of(context).pop(),
                  )
                ],
              ));
      print("not granted");
    }
  }

  Future<void> getContacts() async {
    final Iterable<Contact> contacts = await ContactsService.getContacts();
    allcontacts = contacts.toList();
    print("all contacts $allcontacts");
  }
}
