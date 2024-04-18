import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sos_app/utils/snckkbar.dart';

class dashboard extends StatefulWidget {
  const dashboard({
    Key? key,
  }) : super(key: key);

  @override
  State<dashboard> createState() => _dashboard();
}

class _dashboard extends State<dashboard> {
  List<Contact> contacts = [];
  @override
  void initState() {
    super.initState();
    askPermissions();
  }

  Future<void> askPermissions() async {
    PermissionStatus permissionStatus = await getContactsPermissions();
    if (permissionStatus == PermissionStatus.granted) {
      getAllContacts();
    } else {
      handleInvalidPermissions(permissionStatus);
    }
  }

  handleInvalidPermissions(PermissionStatus permissionStatus) {
    if (permissionStatus == PermissionStatus.denied) {
      showSnckBar(context, "Access to contacts denied by the user");
    } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
      showSnckBar(context, "Contact does not exist");
    }
  }

  Future<PermissionStatus> getContactsPermissions() async {
    PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.permanentlyDenied) {
      PermissionStatus permissionStatus = await Permission.contacts.request();
      return permissionStatus;
    } else {
      return permission;
    }
  }

  void getAllContacts() async {
    List<Contact> _contacts = await ContactsService.getContacts();
    setState(() {
      contacts = _contacts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts Page'),
      ),
      body: contacts.length == 0
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (BuildContext context, int index) {
                Contact contact = contacts[index];
                return ListTile(
                  title: Text(contact.displayName!),
                );
              },
            ),
    );
  }
}
