import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:trainee/modules/global_controllers/global_controller.dart';

class Beranda extends StatelessWidget{
  const Beranda({super.key});
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  
  @override
  Widget build(BuildContext context) {
    GlobalController.to.checkConnection();
    analytics.setCurrentScreen(
      screenName: 'Beranda',
      screenClassOverride: 'Trainee'
    );
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        child: const Text('hello'),
      )
    );
  }
}