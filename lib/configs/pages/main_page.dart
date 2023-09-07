import 'package:get/route_manager.dart';
import 'package:trainee/configs/routes/main_route.dart';
import 'package:trainee/modules/features/beranda/views/ui/beranda_view.dart';
import 'package:trainee/modules/features/counter/bindings/counter_binding.dart';
import 'package:trainee/modules/features/counter/views/ui/counter_view.dart';
import 'package:trainee/modules/features/no_connection/views/ui/no_connection_view.dart';
import 'package:trainee/modules/features/sign_in/bindings/sign_in_binding.dart';
import 'package:trainee/modules/features/sign_in/views/ui/sign_in_view.dart';
import 'package:trainee/modules/features/splash_screen/binddings/splash_screen_binding.dart';
import 'package:trainee/modules/features/splash_screen/views/ui/splash_screen_view.dart';

abstract class MainPage {
  static final main = [
    /// Setup
    GetPage(
      name: MainRoute.beranda,
      page: () => const Beranda(),
    ),
    GetPage(
      name: MainRoute.splash, 
      page: () => const SplashScreen(),
      binding: SplashScreenBinding()
    ),
    GetPage(
      name: MainRoute.noConnection, 
      page: () => const NoConnection()
    ),
    GetPage(
      name: MainRoute.signIn, 
      page: () =>const SignIn(),
      binding: SignInBinding()
    ),
    GetPage(
      name: MainRoute.counter, 
      page: () => const CounterView(),
      binding: CounterBinding()
    )
  ];
}
