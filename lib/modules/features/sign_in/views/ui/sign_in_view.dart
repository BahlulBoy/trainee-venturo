import 'package:flutter/material.dart';
import 'package:trainee/configs/themes/main_color.dart';

class SignIn extends StatelessWidget{
  const SignIn({super.key});
  
  //tes
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MainColor.white,
      body: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.567,
                  height: 155,
                  child: Image.asset(
                    'assets/images/java_code.png',
                    width: 300,
                    height: 214,
                    fit: BoxFit.fitWidth
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 50, 20, 10),
                child: SizedBox(
                  width: MediaQuery.sizeOf(context).width,
                  child: const Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                    child: Text(
                      'Masuk untuk melanjutkan!',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500
                      ),
                    ),
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