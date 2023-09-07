import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trainee/configs/routes/main_route.dart';
import 'package:trainee/configs/themes/main_color.dart';
import 'package:trainee/constants/cores/assets/image_constant.dart';

class SplashScreen extends StatelessWidget{
  const SplashScreen({super.key});

  // TODO: Ganti dengan checkAuth
  Future<void> getToHomeScreenTimer() async {
    Timer(const Duration(seconds: 3), () { 
      // SplashScreenController.to.checkAuth();
      Get.offNamed(MainRoute.signIn);
    });
  }
  
  @override
  Widget build(BuildContext context) {
    getToHomeScreenTimer();
    return Scaffold(
      body: SafeArea(
        child: Align(
          alignment: const Alignment(0, 0),
          child: Container(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height,
            decoration: const BoxDecoration(
              color: MainColor.white
            ),
            alignment: const AlignmentDirectional(0, 0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                ImageConstant.logo,
                width: 259,
                height: 200,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
        )
      ),
    );
  }
}