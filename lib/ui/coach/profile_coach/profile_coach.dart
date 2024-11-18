import 'package:fitness_metrics/ui/base_components/base_app_bar.dart';
import 'package:fitness_metrics/ui/base_components/base_column.dart';
import 'package:fitness_metrics/ui/base_components/base_text.dart';
import 'package:fitness_metrics/ui/coach/profile_coach/controller/profile_coach_controller.dart';
import 'package:fitness_metrics/utils/base_colors.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileCoach extends StatefulWidget {
  const ProfileCoach({super.key});

  @override
  State<ProfileCoach> createState() => _ProfileCoachState();
}

class _ProfileCoachState extends State<ProfileCoach> {
  late ProfileController profileCtrl;

  @override
  void initState() {
    super.initState();
    Get.delete<ProfileController>();
    profileCtrl = Get.put(ProfileController());

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Obx(() {
            return BaseAppBar(
              title: profileCtrl.selectedTitleText(),
              showBackIcon: false,
            );
          }),
          buildSizeHeight(20),
          Expanded(
            child: Obx(() {
              return BaseColumn(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BaseText(
                        value: profileCtrl.selectedText(),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      ToggleButtons(
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        constraints: const BoxConstraints(
                          maxHeight: 60,
                          maxWidth: 50,
                          minHeight: 00,
                          minWidth: 25,
                        ),
                        isSelected: [
                          profileCtrl.selectedIndex.value == 0,
                          profileCtrl.selectedIndex.value == 1,
                          profileCtrl.selectedIndex.value == 2,
                        ],
                        renderBorder: false,
                        onPressed: (index) {
                          profileCtrl.selectedIndex.value = index;
                        },
                        fillColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: profileCtrl.selectedIndex.value == 0
                                  ? BaseColors.primaryColor
                                  : BaseColors.white,
                              border: Border.all(
                                color: BaseColors.primaryColor,
                              ),
                              shape: BoxShape.circle,
                            ),
                            width: 15,
                            height: 15,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: profileCtrl.selectedIndex.value == 1
                                  ? BaseColors.primaryColor
                                  : BaseColors.white,
                              border: Border.all(
                                color: BaseColors.primaryColor,
                              ),
                              shape: BoxShape.circle,
                            ),
                            width: 15,
                            height: 15,
                            alignment: Alignment.center,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: profileCtrl.selectedIndex.value == 2
                                  ? BaseColors.primaryColor
                                  : BaseColors.white,
                              border: Border.all(
                                color: BaseColors.primaryColor,
                              ),
                              shape: BoxShape.circle,
                            ),
                            width: 15,
                            height: 15,
                            alignment: Alignment.center,
                          ),
                        ],
                      ),
                    ],
                  ),
                  buildSizeHeight(20),
                  Expanded(
                    child:
                    profileCtrl.bodyList[profileCtrl.selectedIndex.value],
                  ),
                ],
              );
            }),
          )
        ],
      ),
    );
  }
}
