import 'package:fitness_metrics/ui/base_components/base_button.dart';
import 'package:fitness_metrics/ui/base_components/base_text.dart';
import 'package:fitness_metrics/ui/role/controller/role_controller.dart';
import 'package:fitness_metrics/utils/base_assets.dart';
import 'package:fitness_metrics/utils/base_colors.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:fitness_metrics/utils/base_variables.dart';
import 'package:fitness_metrics/utils/check_role_id.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class RoleScreen extends StatefulWidget {
  const RoleScreen({super.key});

  @override
  State<RoleScreen> createState() => _RoleScreenState();
}

class _RoleScreenState extends State<RoleScreen> {
  RoleController roleController = Get.put(RoleController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Obx(() {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                roleCard(
                    selectedImage: BaseAssets.coachSelected,
                    unSelectedImage: BaseAssets.coachUnselect,
                    title: "Coach",
                    isSelected: roleController.roleIndex.value == CheckRoleId().coach,
                    onPressed: () => roleController.selectRole(role: CheckRoleId().coach!)
                ),
                buildSizeHeight(60),
                roleCard(
                    selectedImage: BaseAssets.athleteSelected,
                    unSelectedImage: BaseAssets.athleteUnselect,
                    title: "Athlete",
                    isSelected: roleController.roleIndex.value == CheckRoleId().athlete,
                    onPressed: () => roleController.selectRole(role: CheckRoleId().athlete!)
                ),
              ],
            );
          }),
          Positioned(
            bottom: 70,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: horizontalScreenPadding),
              // height: 56,
              // width: 100,
              child: BaseButton(
                title: 'Get Started',
                btnTextColor: BaseColors.primaryColor,
                btnFontWeight: FontWeight.w600,
                fontSize: 18,
                borderRadius: 15,
                btnColor: BaseColors.white2,
                preFixIcon: SvgPicture.asset(BaseAssets.rightArrow),
                borderEnable: true,
                borderColor: BaseColors.primaryColor,
                onPressed: () => roleController.checkRoleSelection(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget roleCard({
    required String selectedImage,
    required String unSelectedImage,
    required String title,
    required bool isSelected,
    Function()? onPressed,
  }) {
    return GestureDetector(
      onTap: () {
        triggerHapticFeedback();
        if (onPressed != null) {
          onPressed();
        }
      },
      child: Column(
        children: [
          SvgPicture.asset(isSelected ? selectedImage : unSelectedImage),
          BaseText(
            value: title,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ],
      ),
    );
  }
}
