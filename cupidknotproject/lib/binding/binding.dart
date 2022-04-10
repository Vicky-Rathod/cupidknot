import 'package:get/get.dart';
import '../core/viewmodel/auth_viewmodel.dart';
import '../core/viewmodel/contact_viewmodel.dart';
import '../core/viewmodel/home_viewmodel.dart';
import '../core/viewmodel/network_viewmodel.dart';
import '../core/viewmodel/profile_viewmodel.dart';


class Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthViewModel());
    Get.lazyPut(() => HomeViewModel());
    Get.lazyPut(() => ProfileViewModel());
    Get.lazyPut(() => ContactViewModel());

    Get.lazyPut(() => NetworkViewModel());
  }
}
