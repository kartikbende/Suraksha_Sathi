import 'package:flutter/material.dart';

import '../provider/auth_provider.dart';

class reviews extends StatefulWidget {
  final String userId;

  reviews({Key? key, required this.userId}) : super(key: key);

  @override
  State<reviews> createState() => _reviewsState();
}

class _reviewsState extends State<reviews> {
  TextEditingController _friendPhoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Friend'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _friendPhoneNumberController,
              decoration: InputDecoration(labelText: 'Friend Phone Number'),
            ),
            SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.all(1.0),
              child: ElevatedButton(
                onPressed: () async {
                  String phoneNumber = _friendPhoneNumberController.text.trim();
                  String? friendId =
                      await authprov().getFriendIdByPhoneNumber(phoneNumber);
                  if (friendId != null) {
                    bool friendshipExists = await authprov()
                        .checkFriendshipExists(widget.userId, friendId);
                    bool friendRequestExists = await authprov()
                        .checkFriendRequestExists(widget.userId, friendId);
                    if (!friendshipExists && !friendRequestExists) {
                      await authprov()
                          .addFriendRequest(widget.userId, friendId);
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Friend Request Sent'),
                          content: Text(
                              'Friend request sent to user with phone number $phoneNumber.'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text('OK'),
                            ),
                          ],
                        ),
                      );
                    } else if (friendshipExists) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Already Friends'),
                          content: Text(
                              'You are already friends with user with phone number $phoneNumber.'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text('OK'),
                            ),
                          ],
                        ),
                      );
                    } else if (friendRequestExists) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Friend Request Sent'),
                          content: Text(
                              'Friend request already sent to user with phone number $phoneNumber.'),
                        ),
                      );
                    }
                  }
                },
                child: Icon(Icons.usb_rounded),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
