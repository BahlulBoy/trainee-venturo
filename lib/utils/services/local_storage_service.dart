import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:trainee/modules/global_models/auth_model.dart';

class LocalStorageService extends GetxService{
  LocalStorageService._();
  static final box = Hive.box("venturo");

  /// Kode untuk setting localstorage sesuai dengan repository
  // static Future<void> setAuth(Data serverSelected) async {
  //   await box.put("id", serverSelected.user!.id);
  //   await box.put("name", serverSelected.user!.nama);
  //   await box.put("photo", serverSelected.user!.humanisFoto);
  //   await box.put("roles", serverSelected.user!.jabatan);
  //   await box.put("isLogin", true);

  //   /// Log id user
  //   await FirebaseAnalytics.instance.setUserId(
  //     id: serverSelected.user!.id.toString(),
  //   );
  // }

  static Future<void> setAuth(AuthModel serverSelected) async {
    await box.put("id", serverSelected.id);
    await box.put("name", serverSelected.nama);
    await box.put("photo", serverSelected.photo);
    await box.put("roles", serverSelected.roles);
    await box.put("isLogin", true);
    await box.put("token", serverSelected.token);

    /// Log id user
    await FirebaseAnalytics.instance.setUserId(
      id: serverSelected.id.toString(),
    );
  }  

  /// check login dengan mengecheck nilai hive token
  static Future<bool> checkAuth() async {
    final result = box.containsKey('token');
    return result;
  }

  static Future deleteAuth() async {
    if (box.get("isRememberMe") == false) {
      box.clear();
      box.put("isLogin", false);
    } else {
      box.put("isLogin", false);
    }
  }
}