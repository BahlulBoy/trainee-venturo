import 'package:get/route_manager.dart';
import 'package:trainee/configs/routes/main_route.dart';
import 'package:trainee/modules/features/counter/binddings/conter_bindding.dart';
import 'package:trainee/modules/features/counter/views/ui/conter_view.dart';
import 'package:trainee/modules/features/forgot_password/bindings/forgot_password_binding.dart';
import 'package:trainee/modules/features/forgot_password/bindings/otp_binding.dart';
import 'package:trainee/modules/features/forgot_password/view/forgot_password_view.dart';
import 'package:trainee/modules/features/forgot_password/view/otp_view.dart';
import 'package:trainee/modules/features/no_connection/views/ui/no_connection_view.dart';
import 'package:trainee/modules/features/sign_in/binddings/sign_in_bindding.dart';
import 'package:trainee/modules/features/sign_in/views/ui/sign_in_view.dart';

abstract class MainPage {
  static final main = [
    /// Setup
    GetPage(
      name: MainRoute.initial,
      page: () => const ConterView(),
      binding: ConterBindding(),
    ),
    GetPage(
      name: MainRoute.noConnection,
      page: () => const NoConnectionView(),
    ),
    GetPage(
      name: MainRoute.signIn,
      page: () => const SignInView(),
      binding: SignInBindding(),
    ),
    GetPage(
      name: MainRoute.forgotPassword,
      page: () => const ForgotPasswordView(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: MainRoute.otpInput,
      page: () => const OtpView(),
      binding: OtpBinding(),
    ),
  ];
}
