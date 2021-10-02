import 'package:contacts_service/contacts_service.dart';
import 'package:creditbook/controller/controller.dart';
import 'package:creditbook/screens/userLogin/Before_login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class AddContacts extends StatefulWidget {
  const AddContacts({Key? key}) : super(key: key);

  @override
  _AddContactsState createState() => _AddContactsState();
}

class _AddContactsState extends State<AddContacts> {
  final Controller controller = Get.put(Controller());

  @override
  Widget build(BuildContext context) {
    if (!controller.isConatctpermission.value) {
      controller.getPermission(context);
    }

    return Scaffold(
      
      appBar: AppBar(
        title: (Text('Contacts')),
      ),
      body: Obx(
        () => controller.isConatctpermission.value
            ? ListView.builder(
                itemCount: controller.names.length,
                itemBuilder: (BuildContext context, int index) {
                  Contact contact = controller.contacts!.elementAt(index);
                  return ListTile(
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 2, horizontal: 18),
                        leading: (contact.avatar != null && contact.avatar!.isNotEmpty)
                      ? CircleAvatar(
                        )
                      : CircleAvatar(
                          child: Text(contact.initials()),
                          backgroundColor: Theme.of(context).accentColor,
                        ),
                    title: Text(controller.names[index]),
                    subtitle: Text(controller.phones[index]),
                  );
                },
              )
            : Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
