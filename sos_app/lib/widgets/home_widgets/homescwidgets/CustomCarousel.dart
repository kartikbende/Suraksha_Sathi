import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sos_app/utils/carpuseldata.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomCarousel extends StatelessWidget {
  const CustomCarousel({super.key});
  static Future<void> openArticle(urlinks) async {
    final Uri _url = Uri.parse(urlinks);
    try {
      await launchUrl(_url);
    } catch (e) {
      Fluttertoast.showToast(msg: 'Something went wrong!!');
    }
  }

  @override
  Widget build(BuildContext context) {
    int urlinkss;
    return //GestureDetector(
        // onTap: () {
        //   openArticle(urlinks[0]);
        // },
        CarouselSlider(
      options: CarouselOptions(
        aspectRatio: 2.0,
        autoPlay: true,
      ),
      items: List.generate(
        imageSliders.length,
        (index) => GestureDetector(
          onTap: () {
            openArticle(urlinks[index]);
          },
          child: Card(
            elevation: 5.0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    imageSliders[index],
                  ),
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(0.5),
                      Colors.transparent,
                    ],
                  ),
                ),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8, left: 8, top: 8),
                    child: Text(
                      articleTitle[index],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: MediaQuery.of(context).size.width * 0.05,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
