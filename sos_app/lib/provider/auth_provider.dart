import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sos_app/provider/otpverify.dart';
import 'package:sos_app/provider/usermodel.dart';

import '../utils/snckkbar.dart';

class authprov extends ChangeNotifier {
  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String? _uid;
  String get uid => _uid!;
  UserModel? _userModel;
  UserModel get userModel => _userModel!;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  authprov() {
    checkSign();
  }

  void checkSign() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    _isSignedIn = s.getBool("is_signed_in") ?? false;
    notifyListeners();
  }

  Future setSignIn() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    s.setBool("is_signed_in", true);
    _isSignedIn = true;
    notifyListeners();
  }

  // signin
  void signInWithPhone(BuildContext context, String phoneNumber) async {
    try {
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {
          await _firebaseAuth.signInWithCredential(phoneAuthCredential);
        },
        verificationFailed: (error) {
          throw Exception(error);
        },
        codeSent: (verificationId, resendToken) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => otppverify(verificationId: verificationId),
            ),
          );
        },
        codeAutoRetrievalTimeout: (verificationId) {},
        timeout: Duration(seconds: 40),
      );
    } on FirebaseAuthException catch (e) {
      showSnckBar(
        context,
        e.message.toString(),
      );
    }
  }

  // otp verify
  void verifyOtp({
    required BuildContext context,
    required String verificationId,
    required String OTP,
    required Function onSuccess,
  }) async {
    _isLoading = true;
    notifyListeners();
    try {
      PhoneAuthCredential creds = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: OTP);
      User? user = (await _firebaseAuth.signInWithCredential(creds)).user!;

      if (user != null) {
        _uid = user.uid;
        onSuccess();
      }
      _isLoading = false;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      showSnckBar(context, e.message.toString());
      _isLoading = false;
      notifyListeners();
    }
  }

  //Database logic
  Future<bool> checkExistingUser() async {
    DocumentSnapshot snapshot =
        await _firebaseFirestore.collection("users").doc(_uid).get();
    if (snapshot.exists) {
      print("User There");
      return true;
    } else {
      print("NEW USER");
      return false;
    }
  }

  void saveUserDataToFirebase({
    required BuildContext context,
    required UserModel userModel,
    required Function onSuccess,
  }) async {
    _isLoading = true;
    notifyListeners();
    try {
      userModel.createdAt = DateTime.now().microsecondsSinceEpoch.toString();
      userModel.PhoneNumber = _firebaseAuth.currentUser!.phoneNumber!;
      userModel.uid = _firebaseAuth.currentUser!.uid;
      _userModel = userModel;
      await _firebaseFirestore
          .collection("users")
          .doc(_uid)
          .set(userModel.toMap())
          .then((value) {
        onSuccess();
        _isLoading = false;
        notifyListeners();
      });
    } on FirebaseAuthException catch (e) {
      showSnckBar(
        context,
        e.message.toString(),
      );
      _isLoading = false;
      notifyListeners();
    }
  }

// storing data localy

  Future saveUserDataToSP() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    await s.setString(
      "user_model",
      jsonEncode(
        userModel.toMap(),
      ),
    );
  }

  // add friend ka full functionality
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String?> getFriendIdByPhoneNumber(String phoneNumber) async {
    QuerySnapshot query = await _firestore
        .collection('users')
        .where('phoneNumber', isEqualTo: phoneNumber)
        .get();

    if (query.docs.isNotEmpty) {
      return query.docs.first.id;
    } else {
      return null;
    }
  }

  Future<void> addFriendRequest(String userId, String friendId) async {
    await _firestore
        .collection('friend_requests')
        .doc(userId)
        .collection('requests')
        .doc(friendId)
        .set({
      'friendId': friendId,
      'timestamp': DateTime.now(),
    });
  }

  Future<bool> checkFriendshipExists(String userId, String friendId) async {
    DocumentSnapshot doc = (await _firestore
        .collection('friendships')
        .doc(userId)
        .collection('friends')
        .doc(friendId)
        .get());

    return doc.exists;
  }

  Future<bool> checkFriendRequestExists(String userId, String friendId) async {
    DocumentSnapshot doc = await _firestore
        .collection('friend_requests')
        .doc(userId)
        .collection('requests')
        .doc(friendId)
        .get();
    return doc.exists;
  }

  Future<List<User>> getFriends(String userId) async {
    List<User> friends = [];

    QuerySnapshot query = await _firestore
        .collection('friendships')
        .doc(userId)
        .collection('friends')
        .get();

    for (QueryDocumentSnapshot doc in query.docs) {
      String friendId = doc.id;
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(friendId).get();
      if (userDoc.exists) {
        User friend = Userss(
          id: friendId,
          name: userDoc['name'],
          phoneNumber: userDoc['phoneNumber'],
          email: userDoc['email'],
        ) as User;
        friends.add(friend);
      }
    }

    return friends;
  }

  Future<List<User>> getFriendRequests(String userId) async {
    List<User> friendRequests = [];

    QuerySnapshot query = await _firestore
        .collection('friend_requests')
        .doc(userId)
        .collection('requests')
        .get();

    for (QueryDocumentSnapshot doc in query.docs) {
      String friendId = doc.id;
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(friendId).get();
      if (userDoc.exists) {
        User friendRequest = Userss(
          id: friendId,
          name: userDoc['name'],
          phoneNumber: userDoc['phoneNumber'],
          email: userDoc['email'],
        ) as User;
        friendRequests.add(friendRequest);
      }
    }

    return friendRequests;
  }

  Future<void> acceptFriendRequest(String userId, String friendId) async {
    // Add the friend to the user's friends list
    await _firestore
        .collection('friendships')
        .doc(userId)
        .collection('friends')
        .doc(friendId)
        .set({});

    // Add the user to the friend's friends list
    await _firestore
        .collection('friendships')
        .doc(friendId)
        .collection('friends')
        .doc(userId)
        .set({});

    // Remove the friend request from the user's friend requests
    await _firestore
        .collection('friend_requests')
        .doc(userId)
        .collection('requests')
        .doc(friendId)
        .delete();
  }

  Future<void> declineFriendRequest(String userId, String friendId) async {
    // Remove the friend request from the user's friend requests
    await _firestore
        .collection('friend_requests')
        .doc(userId)
        .collection('requests')
        .doc(friendId)
        .delete();
  }

  Future<void> removeFriend(String userId, String friendId) async {
    // Remove the friend from the user's friends list
    await _firestore
        .collection('friendships')
        .doc(userId)
        .collection('friends')
        .doc(friendId)
        .delete();

    // Also remove the user from the friend's friends list to maintain bidirectional friendship
    await _firestore
        .collection('friendships')
        .doc(friendId)
        .collection('friends')
        .doc(userId)
        .delete();
  }
}

class Userss {
  final String id;
  final String name;
  final String phoneNumber;
  final String email;

  Userss({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.email,
  });
}
