import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness_metrics/ui/athlete/dashboard/controller/athlete_dash_controller.dart';
import 'package:fitness_metrics/ui/athlete/settings_data_edit/controller/data_edit_controller.dart';
import 'package:fitness_metrics/ui/base_components/base_text.dart';
import 'package:fitness_metrics/ui/notifications/notifications.dart';
import 'package:fitness_metrics/utils/base_assets.dart';
import 'package:fitness_metrics/utils/base_colors.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class EditProfileAppBar extends StatefulWidget {
  const EditProfileAppBar({super.key});

  @override
  State<EditProfileAppBar> createState() => _EditProfileAppBarState();
}

class _EditProfileAppBarState extends State<EditProfileAppBar> {
  var dataEditCtrl = Get.find<DataEditController>();
  var athleteDashCtrl = Get.find<AthleteDashController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
          color: BaseColors.primaryColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(28),
            bottomRight: Radius.circular(28),
          )),
      child: Stack(
        children: [
          SvgPicture.asset(BaseAssets.ellipse),
          SvgPicture.asset(BaseAssets.ellipse1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildSizeHeight(30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(() {
                      return GestureDetector(
                        onTap: () {
                          showMediaPicker(isCropEnabled: true).then((value) {
                            if ((value?.path ?? "").isNotEmpty) {
                              dataEditCtrl.selectedProfileImage.value =
                                  value ?? File("");
                            }
                          });
                        },
                        child: ClipOval(
                          child: dataEditCtrl.selectedProfileImage.value !=
                                      null &&
                                  dataEditCtrl.selectedProfileImage.value!.path
                                      .isNotEmpty
                              ? Image.file(
                                  File(dataEditCtrl
                                      .selectedProfileImage.value!.path),
                                  width: 44,
                                  height: 44,
                                  fit: BoxFit.fill,
                                )
                              : (athleteDashCtrl.athleteData.value.image ?? "")
                                      .isNotEmpty
                                  ? CachedNetworkImage(
                                      imageUrl: athleteDashCtrl
                                              .athleteData.value.image ??
                                          '',
                                      width: 44,
                                      height: 44,
                                      fit: BoxFit.fill,
                                    )
                                  : Image.asset(
                                      BaseAssets.athleteProfile,
                                      width: 44,
                                      height: 44,
                                    ),
                        ),
                      );
                    }),
                    InkWell(
                      onTap: () => Get.to(() => const Notifications()),
                      child: SvgPicture.asset(BaseAssets.notification),
                    )
                  ],
                ),
                buildSizeHeight(10),
                BaseText(
                  value: getGreetingMessage(),
                  fontWeight: FontWeight.w500,
                  fontSize: 10,
                  color: Colors.white,
                ),
                BaseText(
                  value: dataEditCtrl.nameController.text.trim().toString(),
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  color: Colors.white,
                ),
                InkWell(
                  onTap: () => Get.back(),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(BaseAssets.leftArrow),
                      buildSizeWidth(30),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
