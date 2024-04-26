import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sos_app/provider/auth_provider.dart';

class reviews extends StatefulWidget {
  reviews({Key? key}) : super(key: key);

  @override
  State<reviews> createState() => _reviewsState();
}

class _reviewsState extends State<reviews> {
  String emailss1 = " ";
  String emailss2 = " ";
  Future<void> getguardianemail1() async {
    final ap = Provider.of<authprov>(context, listen: false);
    String? usermail =
        await ap.getCurrentUserEmail(FirebaseAuth.instance.currentUser!.uid);
    try {
      // Reference to the user document in Firestore based on currentUserUid
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      // Check if the user document exists
      if (userSnapshot.exists) {
        // Extract the email field from the user document
        String? userEmail = userSnapshot.get('guardian1');
        print(userEmail);
        setState(() {
          emailss1 = userEmail!;
        });
      } else {
        print('User document not found');
        return null; // Return null if user document does not exist
      }
    } catch (e) {
      print('Error retrieving user email: $e');
      return null; // Return null if an error occurs
    }
  }

  Future<void> getguardianemail2() async {
    final ap = Provider.of<authprov>(context, listen: false);
    String? usermail =
        await ap.getCurrentUserEmail(FirebaseAuth.instance.currentUser!.uid);
    try {
      // Reference to the user document in Firestore based on currentUserUid
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      // Check if the user document exists
      if (userSnapshot.exists) {
        // Extract the email field from the user document
        String? userEmail = userSnapshot.get('guardian2');
        print(userEmail);
        setState(() {
          emailss2 = userEmail!;
        });
      } else {
        print('User document not found');
        return null; // Return null if user document does not exist
      }
    } catch (e) {
      print('Error retrieving user email: $e');
      return null; // Return null if an error occurs
    }
  }

  @override
  void initState() {
    getguardianemail1();
    getguardianemail2();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SELECT GUARDIAN'),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .where('email', isEqualTo: emailss1)
              //.where('email', isEqualTo: emailss2)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int Index) {
                final d = snapshot.data!.docs[Index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    color: Colors.deepOrange.shade100,
                    child: ListTile(
                      title: Text(
                        d['name'],
                      ),
                    ),
                  ),
                );
              },
            );
          }),
    );
  }
}
