import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:get/get.dart';
import 'package:trainee/configs/themes/main_color.dart';
import 'package:trainee/constants/cores/assets/image_constant.dart';
import 'package:trainee/modules/features/sign_in/controllers/sign_in_controller.dart';
import 'package:trainee/shared/styles/elevated_button_style.dart';
import 'package:trainee/shared/styles/google_text_style.dart';
import 'package:trainee/modules/global_controllers/global_controller.dart';

class SignIn extends StatelessWidget{
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalController.to.checkConnection();
    return Scaffold(
      body: Container(
        height: 100.sh,
        width: 100.sw,
        color: MainColor.white,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 300.h,
                width: 250.w,
                child: Image.asset(ImageConstant.logo),
              ),
              Text("Masuk Untuk Lanjutkan!",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Container(
                width: 100.sw,
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Form(
                  key: SignInController.to.formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 10,),
                      TextFormField(
                        controller: SignInController.to.emailCtrl,
                        validator: (value) {
                          String trim = value!.trim();
                          if (trim.isEmpty) {
                            return "Email Tidak Boleh Kosong";
                          }

                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          labelText: 'Alamat Email',
                          hintText: 'Lorem.ipsum@gmail.com',
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: MainColor.primary,
                              width: 2
                            )
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: MainColor.info,
                              width: 1
                            )
                          ),
                        ),
                      ),
                      Obx(() => 
                        TextFormField(
                          controller: SignInController.to.passwordCtrl,
                          validator: (value) {
                          String trim = value!.trim();
                          if (trim.isEmpty) {
                              return "Password Tidak Boleh Kosong";
                            }

                            return null;
                          },
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: SignInController.to.isPassword.value,
                          decoration: InputDecoration(
                            labelText: 'Kata Sandi',
                            hintText: '*********',
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: MainColor.primary,
                                width: 2
                              )
                            ),
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: MainColor.info,
                                width: 1
                              )
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                SignInController.to.showPassword();
                              },
                              icon: Icon(SignInController.to.isPassword.value? Icons.visibility_off : Icons.visibility),
                            )
                          ),
                        ),
                      ),
                      SizedBox(height: 30.h,),
                      SizedBox(
                        height: 50,
                        width: 200,
                        child: ElevatedButton(
                          style: EvelatedButtonStyle.mainRounded,
                          onPressed: () {
                            SignInController.to.signInWithForm(context);
                          }, 
                          child: Text(
                            "Masuk",
                            style: GoogleTextStyle.fw800.copyWith(
                              fontSize: 18.sp,
                              color: MainColor.white,
                            ),
                            textAlign: TextAlign.center,
                          )
                        )
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 60,),
              SizedBox(
                height: 30.h,
                child: const Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 120,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 2000,
                            child: Divider(
                              thickness: 2,
                              color: MainColor.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text('Atau'),
                    ),
                    SizedBox(
                      width: 120,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 2000,
                            child: Divider(
                              thickness: 2,
                              color: MainColor.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  height: 50,
                  width: 100.sw,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      elevation:  MaterialStateProperty.all<double>(
                        8
                      ),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(
                        MainColor.white,
                      ),
                    ),
                    onPressed: () {
                      SignInController.to.signInWithGoogle(context);
                    }, 
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(BootstrapIcons.google, color: MainColor.black),
                        SizedBox(width: 10),
                        Text("Masuk Menggunakan ", style: TextStyle(color: MainColor.black),),
                        Text("Google", style: TextStyle(fontWeight: FontWeight.w900, color: MainColor.black),)
                      ],
                    )
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}