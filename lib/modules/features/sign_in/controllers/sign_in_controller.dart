import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:trainee/configs/routes/main_route.dart';
// import 'package:trainee/configs/themes/main_color.dart';
// import 'package:trainee/constants/cores/api/api_constant.dart';
import 'package:trainee/modules/global_controllers/global_controller.dart';
import 'package:trainee/modules/global_models/auth_model.dart';
import 'package:trainee/utils/services/http_service.dart';
import 'package:trainee/utils/services/local_storage_service.dart';
import 'package:trainee/utils/services/sign_in_google_service.dart';

class SignInController extends GetxController{
  static SignInController get to => Get.find();

  var formKey = GlobalKey<FormState>();
  var emailCtrl = TextEditingController();
  var emailValue = "".obs;
  var passwordCtrl = TextEditingController();
  var passwordValue = "".obs;
  var isPassword = true.obs;
  var isRememberMe = false.obs;
  
  /// login menggunakan google_sign_in dan firebase 
  Future<void> signInWithGoogle(context) async {
    await GlobalController.to.checkConnection();
    await SignInGoogleService.googleService.signInGoogle();
    final User? userFirebase = FirebaseAuth.instance.currentUser;
    EasyLoading.show(
      status: 'Sedang Diproses...',
      maskType: EasyLoadingMaskType.black,
      dismissOnTap: false,
    ); 
    if (userFirebase != null) {
      var responseBody = {
        "is_google": "is_google",
        "nama": userFirebase.displayName,
        "email": userFirebase.email
      };
      final service = await HttpService
        .dioCall()
        .post(
          "/auth/login",
          data: responseBody
        );
      if (service.data['status_code'] == 200) {
        EasyLoading.dismiss();
        var data = service.data['data'];
        var user = data['user'];
        var model = AuthModel(
          id: user['id_user'],
          email: user['email'],
          nama: user['nama'],
          photo: user['foto'],
          roles: user['roles'],
          token: data['token']
        );
        await LocalStorageService.setAuth(model);
        Get.offAndToNamed(MainRoute.counter);
      } else {
        EasyLoading.dismiss();
        showPanaraInfoDialog("Warning", "Maaf Terdapat Error.\nCoba lagi nanti", "Coba lagi", context);
      }
    } else {
      showPanaraInfoDialog("Warning", "Maaf Terdapat Error.\nCoba lagi nanti", "Coba lagi", context);
    }
  }

  /// Sign in menggunakan data input form
  Future<void> signInWithForm(context) async {
    await GlobalController.to.checkConnection();
    var isValid = formKey.currentState!.validate();
    Get.focusScope!.unfocus();

    if (isValid && GlobalController.to.isConnect.value == true) {
      EasyLoading.show(
        status: 'Sedang Diproses...',
        maskType: EasyLoadingMaskType.black,
        dismissOnTap: false,
      );  
      var responseBody = {
        "email": emailCtrl.text,
        "password": passwordCtrl.text
      };
      final service = await HttpService
        .dioCall()
        .post(
          "/auth/login",
          data: responseBody
        );
      formKey.currentState!.save();
      if (service.data['status_code'] == 200) {
        var data = service.data['data'];
        var user = data['user'];
        var model = AuthModel(
          id: user['id_user'],
          email: user['email'],
          nama: user['nama'],
          photo: user['foto'],
          roles: user['roles'],
          token: data['token']
        );
        await LocalStorageService.setAuth(model);
        EasyLoading.dismiss();
        Get.offNamed(MainRoute.counter);
      } else {
        EasyLoading.dismiss();
        showPanaraInfoDialog("Warning", "Email & Password Salah", "Coba lagi", context);
      }
    }
  }

  Future<void> validateForm(context) async {
    await GlobalController.to.checkConnection();

    var isValid = formKey.currentState!.validate();
    Get.focusScope!.unfocus();

    if (isValid && GlobalController.to.isConnect.value == true) {
      EasyLoading.show(
        status: 'Sedang Diproses...',
        maskType: EasyLoadingMaskType.black,
        dismissOnTap: false,
      );
      formKey.currentState!.save();
      if (emailCtrl.text == "admin@gmail.com" && passwordCtrl.text == "admin") {
        EasyLoading.dismiss();
        Get.offAllNamed(MainRoute.counter);
      } else {
        EasyLoading.dismiss();
        showPanaraInfoDialog("Warning", "Email & Password Salah", "Coba lagi", context);
      }
    } else if (GlobalController.to.isConnect.value == false) {
      Get.toNamed(MainRoute.noConnection);
    }
  }

  void showPassword() {
    if (isPassword.value) {
      isPassword.value = false;
    } else {
      isPassword.value = true;
    }
  }

  void showPanaraInfoDialog(String title, String message, String btnText, context) {
    PanaraInfoDialog.show(
      context,
      title: title,
      message: message,
      buttonText: btnText,
      onTapDismiss: () {
        Get.back();
      },
      panaraDialogType: PanaraDialogType.warning,
      barrierDismissible: false,
    );
  }
  
  // void flavorSeting() async {
  //   Get.bottomSheet(
  //     Obx(
  //       () => Wrap(
  //         children: [
  //           Container(
  //             width: double.infinity.w,
  //             padding: EdgeInsets.symmetric(
  //               horizontal: 5.w,
  //               vertical: 5.h,
  //             ),
  //             decoration: BoxDecoration(
  //               borderRadius: BorderRadius.circular(10.r),
  //               color: MainColor.white,
  //             ),
  //             child: Column(
  //               children: [
  //                 ListTile(
  //                   onTap: () {
  //                     GlobalController.to.isStaging.value = false;
  //                     GlobalController.to.baseUrl = ApiConstant.production;
  //                   },
  //                   title: const Text(
  //                     "Production"
  //                   ),
  //                   trailing: GlobalController.to.isStaging.value == true? 
  //                   null : Icon(
  //                     Icons.check,
  //                     color: MainColor.primary,
  //                     size: 14.sp,
  //                   ),
  //                 ),
  //                 Divider(
  //                   height: 1.h,
  //                 ),
  //                 ListTile(
  //                   onTap: () {
  //                     GlobalController.to.isStaging.value = true;
  //                     GlobalController.to.baseUrl = ApiConstant.staging;
  //                   },
  //                   title: const Text(
  //                     'Staging',
  //                   ),
  //                   trailing: GlobalController.to.isStaging.value == true
  //                       ? Icon(
  //                           Icons.check,
  //                           color: MainColor.primary,
  //                           size: 14.sp,
  //                         )
  //                       : null,
  //                 )
  //               ],
  //             ),
  //           )
  //         ],
  //       )
  //     )
  //   );
  // }
}
