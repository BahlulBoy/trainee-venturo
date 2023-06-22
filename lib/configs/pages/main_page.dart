import 'package:get/route_manager.dart';
import 'package:trainee/configs/routes/main_route.dart';
import 'package:trainee/modules/features/counter/binddings/conter_bindding.dart';
import 'package:trainee/modules/features/counter/views/ui/conter_view.dart';
import 'package:trainee/modules/features/profile/bindings/profile_binding.dart';
import 'package:trainee/modules/features/profile/views/components/privacy_policy_view.dart';
import 'package:trainee/modules/features/profile/views/ui/profile_view.dart';

abstract class MainPage {
  static final main = [
    /// Setup
    GetPage(
      name: MainRoute.initial,
      page: () => const ConterView(),
      binding: ConterBindding(),
    ),
    GetPage(
      name: MainRoute.profileView,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: MainRoute.privacyPolicy,
      page: () => const PrivacyPolicyView(),
    )
  ];
}
