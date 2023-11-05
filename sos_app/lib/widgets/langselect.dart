import 'package:flutter/material.dart';
import 'package:get/get.dart';

class langselect extends StatelessWidget {
  final List locale = [
    {'name': 'English', 'locale': Locale('en', 'US')},
    {'name': 'Hindi', 'locale': Locale('hi', 'IN')},
    {'name': 'Marathi', 'locale': Locale('mr', 'IN')},
  ];

  updatelanguage(Locale locale) {
    Get.back();
    Get.updateLocale(locale);
  }

  builddialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (builder) {
          return AlertDialog(
            title: Text('Choose a language'),
            content: Container(
              width: double.maxFinite,
              child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            print(locale[index]['name']);
                            updatelanguage(locale[index]['locale']);
                          },
                          child: Text(locale[index]['name']),
                        ));
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      color: Colors.blue,
                    );
                  },
                  itemCount: locale.length),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('title'.tr),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'hello'.tr,
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'message'.tr,
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    builddialog(context);
                  },
                  child: Text('Change Language'.tr)),
            ],
          ),
        ));
  }
}
