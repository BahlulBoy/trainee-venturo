import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trainee/configs/themes/main_color.dart';
import 'package:trainee/modules/features/counter/controllers/counter_controller.dart';
import 'package:trainee/modules/global_controllers/global_controller.dart';

class CounterView extends StatelessWidget {
  const CounterView({super.key});
  @override
  Widget build(BuildContext context) {
    GlobalController.to.checkConnection();
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          backgroundColor: MainColor.primary,
          title: Text(
            "Conter App",
            style: GoogleFonts.roboto(
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(
            vertical: 10.h,
            horizontal: 10.w,
          ),
          child: Center(
            child: Text(
              "Jumlah Penambahan\n${CounterController.to.count.value}",
              style: GoogleFonts.roboto(
                fontSize: 18.sp,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            size: 18.sp,
          ),
          onPressed: () => CounterController.to.increment(),
        ),
      ),
    );
  }
}