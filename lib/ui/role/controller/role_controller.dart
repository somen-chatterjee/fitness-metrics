import 'package:fitness_metrics/common_controller/common_controller.dart';
import 'package:fitness_metrics/ui/auth/sign_in/sign_in.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:get/get.dart';

class RoleController extends GetxController {
  var commonController = Get.find<CommonController>();

  // role -> 0 unselect,1 coach, 2 athlete ,
  RxInt roleIndex = 0.obs;

  selectRole({required int role}) {
    roleIndex.value = role;
    commonController.roleId = role;
  }

  void checkRoleSelection() {
    // print("object ${commonController.roleId}");
    if (commonController.roleId == null) {
      showSnackBar(
        title: "Error",
        subtitle: "Please select a role first.",
      );
    } else {
      Get.to(() => const SignIn());
    }
  }
}
