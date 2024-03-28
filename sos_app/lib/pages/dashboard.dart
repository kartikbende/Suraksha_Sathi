import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../provider/auth_provider.dart';

class dashboard extends StatefulWidget {
  final String userId;

  const dashboard({Key? key, required this.userId}) : super(key: key);

  @override
  State<dashboard> createState() => _dashboard();
}

class _dashboard extends State<dashboard> {
  List<User> _friends = [];
  List<User> _friendRequests = [];

  @override
  void initState() {
    super.initState();
    _loadFriends();
    _loadFriendRequests();
  }

  Future<void> _loadFriends() async {
    List<User> friends = await authprov().getFriends(widget.userId);
    setState(() {
      _friends = friends;
    });
  }

  Future<void> _loadFriendRequests() async {
    List<User> friendRequests =
        await authprov().getFriendRequests(widget.userId);
    setState(() {
      _friendRequests = friendRequests;
    });
  }

  Future<void> _acceptFriendRequest(String friendId) async {
    await authprov().acceptFriendRequest(widget.userId, friendId);
    await _loadFriends();
    await _loadFriendRequests();
  }

  Future<void> _declineFriendRequest(String friendId) async {
    await authprov().declineFriendRequest(widget.userId, friendId);
    await _loadFriendRequests();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Friends List'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Text('Friend Requests',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          _friendRequests.isEmpty
              ? Center(child: Text('No friend requests'))
              : Column(
                  children: _friendRequests.map((user) {
                    return ListTile(
                      title: Text(user.email.toString()),
                      subtitle: Row(
                        children: [
                          Text(user.phoneNumber.toString()),
                          SizedBox(width: 10),
                          ElevatedButton(
                            onPressed: () => _acceptFriendRequest(user.uid),
                            child: Text('Accept'),
                          ),
                          SizedBox(width: 10),
                          TextButton(
                            onPressed: () => _declineFriendRequest(user.uid),
                            child: Text('Decline'),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
          SizedBox(height: 20),
          Text('Friends',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          _friends.isEmpty
              ? Center(child: Text('You have no friends'))
              : Column(
                  children: _friends.map((user) {
                    return ListTile(
                      title: Text(user.email.toString()),
                      subtitle: Text(user.phoneNumber.toString()),
                    );
                  }).toList(),
                ),
        ],
      ),
    );
  }
}

class Usersss {
  final String id;
  final String name;
  final String phoneNumber;
  final String email;

  Usersss({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.email,
  });
}
