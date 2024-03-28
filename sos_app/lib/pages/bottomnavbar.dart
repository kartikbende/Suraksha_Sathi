import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:sos_app/pages/dashboard.dart';
import 'package:sos_app/pages/home_screen.dart';
import 'package:sos_app/pages/maps.dart';
import 'package:sos_app/pages/review.dart';

class bottomnavbar extends StatefulWidget {
  const bottomnavbar({super.key});

  @override
  State<bottomnavbar> createState() => _bottomnavbarState();
}

class _bottomnavbarState extends State<bottomnavbar> {
  int currentIndex = 0;
  List<Widget> pages = [
    HomeScreen(),
    mapsview(),
    dashboard(
      key: null,
      userId: FirebaseAuth.instance.currentUser!.uid,
    ),
    reviews(
      userId: FirebaseAuth.instance.currentUser!.uid,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ),
        child: GNav(
          backgroundColor: Colors.white,
          color: Colors.black,
          activeColor: Colors.white,
          tabBackgroundColor: Colors.deepOrangeAccent.shade700.withOpacity(0.7),
          gap: 8,
          onTabChange: (int index) {
            setState(() {
              currentIndex = index;
            });
          },
          padding: EdgeInsets.all(16),
          tabs: const [
            GButton(
              icon: Icons.home,
              text: "Home",
            ),
            GButton(
              icon: Icons.map,
              text: "Maps",
            ),
            GButton(
              icon: Icons.shield,
              text: 'Dashboard',
            ),
            GButton(icon: Icons.reviews, text: "review"),
          ],
        ),
      ),
    );
  }
}
