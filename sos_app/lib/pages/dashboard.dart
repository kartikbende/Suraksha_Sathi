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
  TextEditingController searchController = TextEditingController();
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  List<Contact> contacts = [];
  List<Contact> contactsFiltered = [];
  @override
  void initState() {
    super.initState();
    askPermissions();
  }

  Future<void> askPermissions() async {
    PermissionStatus permissionStatus = await getContactsPermissions();
    if (permissionStatus == PermissionStatus.granted) {
      getAllContacts();
      searchController.addListener(
        () {
          filterContact();
        },
      );
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

  String flattenPhoneNumber(String phoneStr) {
    return phoneStr.replaceAllMapped(RegExp(r'^(\+)|\D'), (Match m) {
      return m[0] == "+" ? "+" : "";
    });
  }

  filterContact() {
    List<Contact> _contacts = [];
    _contacts.addAll(contacts);
    if (searchController.text.isNotEmpty) {
      _contacts.retainWhere(
        (element) {
          String searchTerm = searchController.text.toLowerCase();
          String searchTermFlattren = flattenPhoneNumber(searchTerm);
          String contactName = element.displayName!.toLowerCase();
          bool nameMatch = contactName.contains(searchTerm);
          if (nameMatch == true) {
            // setState(() {
            //   contactsFiltered = _contacts;
            // });
            return true;
          }
          if (searchTermFlattren.isEmpty) {
            return false;
          }
          var phone = element.phones!.firstWhere(
            (p) {
              String phoneFlattered = flattenPhoneNumber(p.value!);
              return phoneFlattered.contains(searchTermFlattren);
            },
          );
          return phone.value != null;
        },
      );
    }
    setState(() {
      contactsFiltered = _contacts;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isSearching = searchController.text.isNotEmpty;
    bool listItemExist = contactsFiltered.length > 0 || contacts.length > 0;
    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts Page'),
      ),
      body: contacts.length == 0
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
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
                listItemExist == true
                    ? Expanded(
                        child: ListView.builder(
                          itemCount: isSearching == true
                              ? contactsFiltered.length
                              : contacts.length,
                          itemBuilder: (BuildContext context, int index) {
                            Contact contact = isSearching == true
                                ? contactsFiltered[index]
                                : contacts[index];
                            List<Item>? phoneNumbers = contact.phones?.toList();
                            // String? contactnameee = contact.displayName;
                            return ListTile(
                              title: Text(contact.displayName ?? "No Contact"),
                              subtitle: phoneNumbers != null &&
                                      phoneNumbers.isNotEmpty
                                  ? Text(phoneNumbers[0].value ?? '')
                                  : Text('No phone number'),
                              leading: contact.avatar != null &&
                                      contact.avatar!.length > 0
                                  ? CircleAvatar(
                                      backgroundImage:
                                          MemoryImage(contact.avatar!),
                                    )
                                  : CircleAvatar(
                                      backgroundColor:
                                          Colors.deepOrange.shade100,
                                      child: Text(
                                        contact.initials(),
                                      ),
                                    ),
                            );
                          },
                        ),
                      )
                    : Container(child: Text("searching")),
              ],
            ),
    );
  }
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
