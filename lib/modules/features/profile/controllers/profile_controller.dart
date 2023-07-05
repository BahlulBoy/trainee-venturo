import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trainee/configs/routes/main_route.dart';
import 'package:trainee/configs/themes/main_color.dart';
import 'package:trainee/shared/widgets/image_picker_dialog.dart';
import 'package:device_info_plus/device_info_plus.dart';

class ProfileController extends GetxController {
  static ProfileController get to => Get.find();

  final Rx<File?> _imageFile = Rx<File?>(null);
  RxString deviceModel = ''.obs;
  RxString deviceVersion = ''.obs;
  RxBool isVerif = false.obs;

  File? get imageFile => _imageFile.value;

  @override
  void onInit() {
    super.onInit();

    /// Load Device Info
    getDeviceInformation();
  }

  /// Pilih image untuk update photo
  Future<void> pickImage() async {
    /// Buka dialog untuk sumber gambar
    ImageSource? imageSource = await Get.defaultDialog(
      title: '',
      titleStyle: const TextStyle(fontSize: 0),
      content: const ImagePickerDialog(),
    );

    /// pengecekan sumber gambar
    if (imageSource == null) return;

    final pickedFile = await ImagePicker().pickImage(
      source: imageSource,
      maxWidth: 300,
      maxHeight: 300,
      imageQuality: 75,
    );

    /// setelah dipilih, akan terbuka crop gambar
    if (pickedFile != null) {
      _imageFile.value = File(pickedFile.path);
      final croppedFile = await ImageCropper()
          .cropImage(sourcePath: _imageFile.value!.path, aspectRatioPresets: [
        CropAspectRatioPreset.square
      ], uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Cropper'.tr,
          toolbarColor: MainColor.primary,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.square,
          lockAspectRatio: true,
        )
      ]);

      /// Jika gambar telah dipilih, maka akan dimasukkan ke variabel image file, karena ini masih menggunakan local file
      if (croppedFile != null) {
        _imageFile.value = File(croppedFile.path);
      }
    }
  }

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File(result.files.single.path!);

      /// Selanjutnya apa yang ingin diinginkan
      isVerif.value = true;
    }
  }

  Future getDeviceInformation() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    deviceModel.value = androidInfo.model;
    deviceVersion.value = androidInfo.version.release;
  }

  void privacyPolicyWebView() {
    Get.toNamed(MainRoute.privacyPolicy);
  }

  void setCookie() async {
    // mendapatkan instance cookie manager
    final cookieManager = CookieManager.instance();
    // waktu berlaku (session) untuk cookie
    final expiresDate =
        DateTime.now().add(const Duration(days: 1)).millisecondsSinceEpoch;
    // url sumber cookie yang akan disimpan
    final url = Uri.parse("https://venturo.id");

    // menyimpan cookie
    await cookieManager.setCookie(
      url: url,
      name: "traineeCookie",
      value: "trainee",
      expiresDate: expiresDate,
      isSecure: true,
    );
  }

  Future<Cookie?> getCookie() async {
    // mendapatkan instance cookie manager
    final cookieManager = CookieManager.instance();
    // url sumber cookie yang akan disimpan
    final url = Uri.parse("https://venturo.id");
    // mendapatkan cookie
    Cookie? cookie =
        await cookieManager.getCookie(url: url, name: "traineeCookie");

    return cookie;
  }

  void deleteCookie() async {
    // mendapatkan instance cookie manager
    final cookieManager = CookieManager.instance();
    // url sumber cookie yang akan dihapus
    final url = Uri.parse("https://venturo.id");
    // menghapus cookie
    await cookieManager.deleteCookie(url: url, name: "traineeCookie");
  }
}
