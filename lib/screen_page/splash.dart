import 'package:flutter/material.dart';
import 'package:kampus_apps_zikra/screen_page/page_beranda.dart';
import 'package:kampus_apps_zikra/screen_page/page_bottom_navigation.dart';

class PageSplash extends StatefulWidget {
  const PageSplash({super.key});

  @override
  State<PageSplash> createState() => _PageSplashState();
}

class _PageSplashState extends State<PageSplash> {
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => BottomNavigationBarPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white38,
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('gambar/img_1.png',
                  fit: BoxFit.contain,
                  height: 410,
                  width: 410,),
              ]
          )
      ),
    );
  }
}