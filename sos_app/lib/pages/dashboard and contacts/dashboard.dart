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
  List<Contact> contactsFiltered = [];
  // DatabaseHelper _databaseHelper = DatabaseHelper();

  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    askPermissions();
  }

  String flattenPhoneNumber(String phoneStr) {
    return phoneStr.replaceAllMapped(RegExp(r'^(\+)|\D'), (Match m) {
      return m[0] == "+" ? "+" : "";
    });
  }

  filterContact() {
    List<Contact> _contacts = [];
    _contacts.addAll(contacts);
    if (searchController.text.isNotEmpty) {
      String searchTerm = searchController.text.toLowerCase();
      String searchTermFlattren = flattenPhoneNumber(searchTerm);
      _contacts.retainWhere(
        (element) {
          String contactName = element.displayName ?? "";
          bool nameMatch = contactName.contains(searchTerm);
          if (nameMatch == true) {
            return true;
          }
          if (searchTermFlattren.isEmpty) {
            return false;
          }
          var phone = element.phones!.firstWhere(
            (p) {
              String phnFLattered = flattenPhoneNumber(p.value!);
              return phnFLattered.contains(searchTermFlattren);
            },
          );
          return phone.value != null;
        },
      );
    }
    setState(
      () {
        contactsFiltered = _contacts;
      },
    );
  }

  Future<void> askPermissions() async {
    PermissionStatus permissionStatus = await getContactsPermissions();
    if (permissionStatus == PermissionStatus.granted) {
      getAllContacts();
      searchController.addListener(() {
        filterContact();
      });
    } else {
      handInvaliedPermissions(permissionStatus);
    }
  }

  handInvaliedPermissions(PermissionStatus permissionStatus) {
    if (permissionStatus == PermissionStatus.denied) {
      showSnckBar(context, "Access to the contacts denied by the user");
    } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
      showSnckBar(context, "May contact does exist in this device");
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

  getAllContacts() async {
    List<Contact> _contacts =
        await ContactsService.getContacts(withThumbnails: false);
    setState(() {
      contacts = _contacts;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isSearchIng = searchController.text.isNotEmpty;
    bool listItemExit = (contactsFiltered.length > 0 || contacts.length > 0);
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Page'),
      ),
      body: contacts.length == 0
          ? Center(child: CircularProgressIndicator())
          : SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 7, right: 7),
                    child: TextField(
                        hintText: "Search Contact",
                        icon: Icons.account_circle,
                        inputType: TextInputType.name,
                        maxLines: 1,
                        controller: searchController),
                  ),
                  listItemExit == true
                      ? Expanded(
                          child: ListView.builder(
                            itemCount: isSearchIng == true
                                ? contactsFiltered.length
                                : contacts.length,
                            itemBuilder: (BuildContext context, int index) {
                              Contact contact = isSearchIng == true
                                  ? contactsFiltered[index]
                                  : contacts[index];
                              return ListTile(
                                title: Text(contact.displayName ?? ""),
                                // subtitle:Text(contact.phones!.elementAt(0)
                                // .value!) ,
                                leading: contact.avatar != null &&
                                        contact.avatar!.length > 0
                                    ? CircleAvatar(
                                        backgroundColor:
                                            Colors.deepOrange.shade100,
                                        backgroundImage:
                                            MemoryImage(contact.avatar!),
                                      )
                                    : CircleAvatar(
                                        backgroundColor:
                                            Colors.deepOrange.shade100,
                                        child: Text(contact.initials()),
                                      ),
                                onTap: () {
                                  // if (contact.phones!.length > 0) {
                                  //   final String phoneNum =
                                  //       contact.phones!.elementAt(0).value!;
                                  //   final String name = contact.displayName!;
                                  //   _addContact(TContact(phoneNum, name));
                                  // } else {
                                  //   Fluttertoast.showToast(
                                  //       msg:
                                  //           "Oops! phone number of this contact does exist");
                                  // }
                                },
                              );
                            },
                          ),
                        )
                      : Container(
                          child: Text("searching"),
                        ),
                ],
              ),
            ),
    );
  }

  // void _addContact(TContact newContact) async {
  //   int result = await _databaseHelper.insertContact(newContact);
  //   if (result != 0) {
  //     Fluttertoast.showToast(msg: "contact added successfully");
  //   } else {
  //     Fluttertoast.showToast(msg: "Failed to add contacts");
  //   }
  //   Navigator.of(context).pop(true);
  // }
}

Widget TextField(
    {required String hintText,
    required IconData icon,
    required TextInputType inputType,
    required int maxLines,
    required TextEditingController controller}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: TextFormField(
      autofocus: true,
      cursorColor: Colors.indigo[600],
      controller: controller,
      keyboardType: inputType,
      maxLines: maxLines,
      decoration: InputDecoration(
        prefixIcon: Container(
          margin: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.deepOrange.shade700,
          ),
          child: Icon(
            icon,
            size: 25,
            color: Colors.white,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        hintText: hintText,
        alignLabelWithHint: true,
        border: InputBorder.none,
        fillColor: Colors.deepOrange.shade100,
        filled: true,
      ),
    ),
  );
}
