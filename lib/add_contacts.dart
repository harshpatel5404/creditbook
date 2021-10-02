import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class AddContacts extends StatefulWidget {
  const AddContacts({Key? key}) : super(key: key);

  @override
  _AddContactsState createState() => _AddContactsState();
}

class _AddContactsState extends State<AddContacts> {
  Iterable<Contact>? _contacts;
  bool isPermission = false;

  Future _getPermission() async {
    final permission = await Permission.contacts.request();
    final PermissionStatus status = await Permission.contacts.status;
    if (permission.isGranted == true || status.isGranted) {
      await getContacts();
      setState(() {
        isPermission = true;
      });
    } else {
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

  @override
  void initState() {
    _getPermission();
    super.initState();
  }

  Future<void> getContacts() async {
    final Iterable<Contact> contacts = await ContactsService.getContacts();
    setState(() {
      _contacts = contacts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: (Text('Contacts')),
        ),
        body: _contacts != null
            ? ListView.builder(
                itemCount: _contacts!.length,
                itemBuilder: (BuildContext context, int index) {
                  Contact contact = _contacts!.elementAt(index);
                  return ListTile(
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 2, horizontal: 18),
                    leading:
                        (contact.avatar != null && contact.avatar!.isNotEmpty)
                            ? CircleAvatar()
                            : CircleAvatar(
                                child: Text(contact.initials()),
                                backgroundColor: Theme.of(context).accentColor,
                              ),
                    title: Text(contact.displayName ?? ''),
                  );
                },
              )
            : Center(
                child: CircularProgressIndicator(),
              ));
  }
}
