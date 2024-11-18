import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:fitness_metrics/common_controller/common_controller.dart';
import 'package:fitness_metrics/ui/athlete/settings_evaluation/controller/progress_photo_controller.dart';
import 'package:fitness_metrics/ui/base_components/base_button.dart';
import 'package:fitness_metrics/ui/base_components/base_column.dart';
import 'package:fitness_metrics/ui/base_components/base_text.dart';
import 'package:fitness_metrics/ui/coach/athlete_evaluation/controller/progress_photo_view_controller.dart';
import 'package:fitness_metrics/utils/base_assets.dart';
import 'package:fitness_metrics/utils/base_colors.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:fitness_metrics/utils/check_role_id.dart';
import 'package:fitness_metrics/utils/get_storage.dart';
import 'package:fitness_metrics/utils/storage_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class UploadProgressPhoto extends StatefulWidget {
  final String athleteId;
  const UploadProgressPhoto({super.key, required this.athleteId});

  @override
  State<UploadProgressPhoto> createState() => _UploadPhotoState();
}

class _UploadPhotoState extends State<UploadProgressPhoto> {
  final commonCtrl = Get.find<CommonController>();

  @override
  void dispose() {
    super.dispose();
    commonCtrl.imageDispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BaseColumn(
          leftPadding: 28,
          rightPadding: 28,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            buildSizeHeight(40),
            const BaseText(
              value: 'Upload and compare photos',
              color: BaseColors.black1,
              fontSize: 25,
              fontWeight: FontWeight.w600,
            ),
            buildSizeHeight(20),
            const BaseText(
              value:
                  "Track your transformation! Upload your photos to visually compare your progress over time. Seeing your changes can be a great source of motivation and help you stay on track with your fitness journey.",
              color: BaseColors.black1,
              fontSize: 14,
              textAlign: TextAlign.center,
              fontWeight: FontWeight.w400,
            ),
            buildSizeHeight(60),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //front photo
                      frontPhoto(),

                      buildSizeWidth(20),
                      // back photo
                      backPhoto(),
                    ],
                  ),
                  buildSizeHeight(40),
                  sidePhoto(),
                ],
              ),
            ),
            // GestureDetector(
            //   onTap: () => Get.offAll(const AthleteDashboard()),
            //   child: const BaseText(
            //     value: "Answer later",
            //     color: BaseColors.lightPurple,
            //     fontSize: 16,
            //     underline: true,
            //     textAlign: TextAlign.center,
            //     fontWeight: FontWeight.w400,
            //   ),
            // ),
            buildSizeHeight(12),
            BaseButton(
              title: 'Upload',
              btnTextColor: BaseColors.primaryColor,
              btnFontWeight: FontWeight.w600,
              fontSize: 18,
              borderRadius: 15,
              borderEnable: true,
              btnColor: BaseColors.white2,
              borderColor: BaseColors.primaryColor,
              onPressed: () async {
                dynamic roleId =
                    await BaseStorage.read(StorageKeys.roleId) ?? "";

                if ((commonCtrl.selectedFrontImage.value?.path ?? "")
                        .isNotEmpty &&
                    (commonCtrl.selectedBackImage.value?.path ?? "")
                        .isNotEmpty &&
                    (commonCtrl.selectedSideImage.value?.path ?? "")
                        .isNotEmpty) {
                  commonCtrl.athleteDetails(athleteId: widget.athleteId, isWeightScreen: false).then((value) {
                    if (int.parse(roleId.toString()) == CheckRoleId().athlete) {
                      Get.find<ProgressPhotoController>().progressImageList();
                    } else {
                      Get.find<ProgressPhotoViewController>().progressImageList();
                    }
                  });
                } else {
                  showSnackBar(
                    title: "Error",
                    subtitle: "Required all photos for better comparison",
                  );
                }
                // Get.offAll(const AthleteDashboard());
              },
            ),
            buildSizeHeight(35),
          ],
        ),
      ),
    );
  }

  Widget frontPhoto() {
    return Expanded(
      child: Obx(() {
        return GestureDetector(
          onTap: () {
            showMediaPicker().then((value) {
              if ((value?.path ?? "").isNotEmpty) {
                commonCtrl.selectedFrontImage.value = value ?? File("");
                // setState(() {});
              }
            });
          },
          child: commonCtrl.selectedFrontImage.value != null &&
                  commonCtrl.selectedFrontImage.value!.path.isNotEmpty
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.file(
                    File(commonCtrl.selectedFrontImage.value!.path),
                    fit: BoxFit.cover,
                    height: 102,
                    // width: 110,
                  ),
                )
              : DottedBorder(
                  color: BaseColors.primaryColor,
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(15),
                  dashPattern: const <double>[3, 2],
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 20,
                  ),
                  child: Center(
                    child: Column(
                      children: [
                        SvgPicture.asset(BaseAssets.uploadPhoto),
                        buildSizeHeight(12),
                        const BaseText(
                          value: 'Front Photo',
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ],
                    ),
                  ),
                ),
        );
      }),
    );
  }

  Widget backPhoto() {
    return Expanded(
      child: Obx(() {
        return GestureDetector(
          onTap: () {
            showMediaPicker().then((value) {
              if ((value?.path ?? "").isNotEmpty) {
                commonCtrl.selectedBackImage.value = value ?? File("");
                // setState(() {});
              }
            });
          },
          child: commonCtrl.selectedBackImage.value != null &&
                  commonCtrl.selectedBackImage.value!.path.isNotEmpty
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.file(
                    File(commonCtrl.selectedBackImage.value!.path),
                    fit: BoxFit.cover,
                    height: 102,
                    // width: 110,
                  ),
                )
              : DottedBorder(
                  color: BaseColors.primaryColor,
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(15),
                  dashPattern: const <double>[3, 2],
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 20,
                  ),
                  child: Center(
                    child: Column(
                      children: [
                        SvgPicture.asset(BaseAssets.uploadPhoto),
                        buildSizeHeight(12),
                        const BaseText(
                          value: 'Back Photo',
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ],
                    ),
                  ),
                ),
        );
      }),
    );
  }

  Widget sidePhoto() {
    return Obx(() {
      return GestureDetector(
        onTap: () {
          showMediaPicker().then((value) {
            if ((value?.path ?? "").isNotEmpty) {
              commonCtrl.selectedSideImage.value = value ?? File("");
              // setState(() {});
            }
          });
        },
        child: commonCtrl.selectedSideImage.value != null &&
                commonCtrl.selectedSideImage.value!.path.isNotEmpty
            ? ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.file(
                  File(commonCtrl.selectedSideImage.value!.path),
                  fit: BoxFit.cover,
                  height: 102,
                  width: 140,
                ),
              )
            : DottedBorder(
                color: BaseColors.primaryColor,
                borderType: BorderType.RRect,
                radius: const Radius.circular(15),
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 20,
                ),
                dashPattern: const <double>[3, 2],
                child: Column(
                  children: [
                    SvgPicture.asset(BaseAssets.uploadPhoto),
                    buildSizeHeight(12),
                    const BaseText(
                      value: 'Side Photo',
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ],
                ),
              ),
      );
    });
  }
}
