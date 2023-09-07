import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:trainee/modules/global_binddings/global_binding.dart';
import 'firebase_options.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:trainee/configs/pages/main_page.dart';
import 'package:trainee/configs/routes/main_route.dart';
import 'package:trainee/configs/themes/main_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox("venturo");

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );

  await SentryFlutter.init(
    (option) {
      option.dsn = 'https://0dba61e517ecb67d7f696302fd52ca43@o4505830900105216.ingest.sentry.io/4505830903185408';
      option.tracesSampleRate = 1.0;
    },
    appRunner: () => runApp(const MyApp())
  );
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  Widget build(BuildContext context) {
    analytics.setCurrentScreen(
      screenName: 'Initial screen',
      screenClassOverride: 'Trainee'
    );
    return ScreenUtilInit(
      designSize: const Size(414, 896),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: 'Trainee Sekeleton',
          debugShowCheckedModeBanner: false,
          initialRoute: MainRoute.splash,
          initialBinding: GlobalBinding(),
          theme: mainTheme,
          defaultTransition: Transition.native,
          getPages: MainPage.main,
          builder: EasyLoading.init(),
        );
      },
    );
  }
}
