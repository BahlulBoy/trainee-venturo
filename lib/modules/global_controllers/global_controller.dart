import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:trainee/configs/routes/main_route.dart';
import 'package:trainee/constants/cores/api/api_constant.dart';

class GlobalController extends GetxController{
  static GlobalController get to => Get.find();

  var isConnect = false.obs;
  var baseUrl = ApiConstant.production;
  var isStaging = false.obs;

  Future<void> checkConnection() async {
    try {
      final result = await InternetAddress.lookup('space.venturo.id');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isConnect.value = true;
      }
    } catch(e, stack) {
      await Sentry.captureException(
        e,
        stackTrace: stack
      );
      Get.offNamed(MainRoute.noConnection);
    }
  }

  Future<bool> checkLoginAccount() async {
    final User? userFirebase = FirebaseAuth.instance.currentUser;

    if (userFirebase == null) {
      return false;
    } else {
      return true;
    }
  }
}