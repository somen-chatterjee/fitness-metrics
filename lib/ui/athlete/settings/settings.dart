import 'package:fitness_metrics/ui/athlete/settings/controller/settings_controller.dart';
import 'package:fitness_metrics/ui/base_components/base_app_bar.dart';
import 'package:fitness_metrics/ui/base_components/base_column.dart';
import 'package:fitness_metrics/ui/base_components/base_text.dart';
import 'package:fitness_metrics/utils/base_colors.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  var settingsCtrl = Get.put(SettingsController());

  @override
  void initState() {
    super.initState();
    settingsCtrl.selectBody(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const BaseAppBar(
            title: 'Data',
            showBackIcon: false,
          ),
          buildSizeHeight(20),
          Expanded(
            child: Obx(() {
              return BaseColumn(
                children: [
                  Container(
                    width: double.infinity,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: BaseColors.grey5),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () => settingsCtrl.selectBody(0),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 6),
                              decoration: BoxDecoration(
                                color: settingsCtrl.selectedIndex.value == 0
                                    ? BaseColors.primaryColor
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(80),
                              ),
                              child: BaseText(
                                value: 'Data',
                                fontSize: 14,
                                fontWeight:
                                    settingsCtrl.selectedIndex.value == 0
                                        ? FontWeight.w600
                                        : FontWeight.w500,
                                color: settingsCtrl.selectedIndex.value == 0
                                    ? BaseColors.white
                                    : BaseColors.black1,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        // buildSizeWidth(10),
                        Expanded(
                          child: InkWell(
                            onTap: () => settingsCtrl.selectBody(1),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 6),
                              decoration: BoxDecoration(
                                color: settingsCtrl.selectedIndex.value == 1
                                    ? BaseColors.primaryColor
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(80),
                              ),
                              child: BaseText(
                                value: 'Evaluation',
                                fontSize: 14,
                                fontWeight:
                                    settingsCtrl.selectedIndex.value == 1
                                        ? FontWeight.w600
                                        : FontWeight.w500,
                                color: settingsCtrl.selectedIndex.value == 1
                                    ? BaseColors.white
                                    : BaseColors.black1,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () => settingsCtrl.selectBody(2),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 6),
                              decoration: BoxDecoration(
                                color: settingsCtrl.selectedIndex.value == 2
                                    ? BaseColors.primaryColor
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(80),
                              ),
                              child: BaseText(
                                value: 'Workouts',
                                fontSize: 14,
                                fontWeight:
                                    settingsCtrl.selectedIndex.value == 2
                                        ? FontWeight.w600
                                        : FontWeight.w500,
                                color: settingsCtrl.selectedIndex.value == 2
                                    ? BaseColors.white
                                    : BaseColors.black1,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  buildSizeHeight(20),
                  Expanded(
                    child:
                        settingsCtrl.bodyList[settingsCtrl.selectedIndex.value],
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
