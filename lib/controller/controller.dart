import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class Controller extends GetxController {
  RxBool isLogin = false.obs;
  var selectind = 0.obs;
  var btntxt = "Skip".obs;
  // List<Contact> allcontacts = [];
  List<String> names = [];
  List<String> phones = [];
  Iterable<Contact>? contacts;

  RxBool isConatctpermission = false.obs;

  Future getPermission(BuildContext context) async {
       
    final permission;
    if (await Permission.contacts.request().isGranted != true) {
         permission = await Permission.contacts.request();
    }
    
    final PermissionStatus status = await Permission.contacts.status;
    if (status.isGranted) {
      await getContacts();
      isConatctpermission.value = true;
    } else {
      isConatctpermission.value = false;
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
    contacts = await ContactsService.getContacts(withThumbnails: false);
    contacts!.forEach((contact) {
      contact.phones!.forEach((phone) {
        names.add(contact.displayName.toString());
        phones.add(phone.value.toString());
        print("names ${names[0]}");
        print("pho ${phones[0]}");
      });
    });
  }
}
