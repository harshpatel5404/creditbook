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
    final PermissionStatus status = await Permission.contacts.status;
    if (status.isGranted) {
      await getContacts();
      isConatctpermission.value = true;
    } else {
      await Permission.contacts.request();
      if (!status.isGranted) {
        Center(child: Text("Permission not granted"),);
        isConatctpermission.value = false;
      } else {
        isConatctpermission.value = true;
      }
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
