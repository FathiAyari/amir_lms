import 'dart:async';

import 'package:amir/ui/shared/app_colors.dart';
import 'package:amir/ui/shared/dimensions/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var timer = Timer(Duration(seconds: 4), () {
      Get.toNamed("/login");
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: pinkColor,
          body: Container(
            height: Constants.screenHeight,
            width: double.infinity,
            child: Column(
              children: [
                Expanded(
                  child: Lottie.asset(
                    "assets/lotties/learning.json",
                    width: Constants.screenWidth,
                    height: Constants.screenWidth * 0.5,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Lottie.asset(
                    "assets/lotties/loading.json",
                    height: Constants.screenWidth * 0.2,
                  ),
                )
              ],
            ),
          )),
    );
  }
}
