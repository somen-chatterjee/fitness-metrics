import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness_metrics/ui/athlete/dashboard/controller/athlete_dash_controller.dart';
import 'package:fitness_metrics/ui/base_components/base_app_bar.dart';
import 'package:fitness_metrics/ui/base_components/base_column.dart';
import 'package:fitness_metrics/ui/base_components/base_text.dart';
import 'package:fitness_metrics/utils/base_assets.dart';
import 'package:fitness_metrics/utils/base_colors.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CoachViewProfile extends StatefulWidget {
  const CoachViewProfile({super.key});

  @override
  State<CoachViewProfile> createState() => _CoachViewProfileState();
}

class _CoachViewProfileState extends State<CoachViewProfile> {
  var athleteDashCtrl = Get.find<AthleteDashController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Obx(() {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const BaseAppBar(title: "Coach Profile"),
              buildSizeHeight(25),
              BaseColumn(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: BaseColors.grey5),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipOval(
                          child: (athleteDashCtrl.coachData.value.image ?? "")
                                  .isNotEmpty
                              ? CachedNetworkImage(
                                  imageUrl:
                                      athleteDashCtrl.coachData.value.image ??
                                          '',
                                  width: 83,
                                  height: 83,
                                  fit: BoxFit.fill,
                                )
                              : Image.asset(
                                  BaseAssets.coachProfile,
                                  width: 83,
                                  height: 83,
                                ),
                        ),
                        buildSizeWidth(15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BaseText(
                                value:
                                    athleteDashCtrl.coachData.value.name ?? "",
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                                color: BaseColors.black1,
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const BaseText(
                                    value: 'Age:',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: BaseColors.black,
                                  ),
                                  buildSizeWidth(5),
                                  BaseText(
                                    value:
                                        "${athleteDashCtrl.coachData.value.age ?? ""}",
                                    fontWeight: FontWeight.w300,
                                    fontSize: 14,
                                    color: BaseColors.grey3,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        buildSizeWidth(20),
                      ],
                    ),
                  ),
                  buildSizeHeight(25),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const BaseText(
                        value: 'Phone Number',
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: BaseColors.black2,
                      ),
                      buildSizeWidth(20),
                      Expanded(
                        child: BaseText(
                          value: athleteDashCtrl.coachData.value.mobile ?? "",
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: BaseColors.black2,
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    height: 26,
                    color: BaseColors.grey5.withOpacity(.3),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const BaseText(
                        value: 'Email',
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: BaseColors.black2,
                      ),
                      buildSizeWidth(20),
                      Expanded(
                        child: BaseText(
                          value: athleteDashCtrl.coachData.value.email ?? "",
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: BaseColors.black2,
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    height: 26,
                    color: BaseColors.grey5.withOpacity(.3),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const BaseText(
                        value: 'Date of Birth',
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: BaseColors.black2,
                      ),
                      buildSizeWidth(20),
                      Expanded(
                        child: BaseText(
                          value: athleteDashCtrl.coachData.value.dateOfBirth !=
                                  null
                              ? dateDDMMYY(
                                  athleteDashCtrl.coachData.value.dateOfBirth!)
                              : "",
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: BaseColors.black2,
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    height: 26,
                    color: BaseColors.grey5.withOpacity(.3),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const BaseText(
                        value: 'WhatsApp',
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: BaseColors.black2,
                      ),
                      buildSizeWidth(20),
                      Expanded(
                        child: InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            urlLaunch(
                                url:
                                    "https://wa.me/${athleteDashCtrl.coachData.value.whatsapp ?? ""}/?text=${Uri.parse("Hello ${athleteDashCtrl.coachData.value.name ?? ""}")}");
                          },
                          child: BaseText(
                            value:
                                athleteDashCtrl.coachData.value.whatsapp ?? "",
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: BaseColors.primaryColor,
                            textAlign: TextAlign.end,
                            underline: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    height: 26,
                    color: BaseColors.grey5.withOpacity(.3),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const BaseText(
                        value: 'IG profile',
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: BaseColors.black2,
                      ),
                      buildSizeWidth(20),
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            await Clipboard.setData(ClipboardData(
                                text: athleteDashCtrl
                                    .coachData.value.profileUrl ??
                                    ""))
                                .then((_) {
                              showSnackBar(
                                isSuccess: true,
                                subtitle: "Code copied to clipboard",
                              );
                            });
                          },
                          child: BaseText(
                            value: athleteDashCtrl.coachData.value.profileUrl ??
                                "",
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: BaseColors.primaryColor,
                            textAlign: TextAlign.end,
                            underline: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    height: 26,
                    color: BaseColors.grey5.withOpacity(.3),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const BaseText(
                        value: 'Website',
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: BaseColors.black2,
                      ),
                      buildSizeWidth(20),
                      Expanded(
                        child: GestureDetector(
                          onTap: () async{
                            await Clipboard.setData(ClipboardData(
                                text: athleteDashCtrl
                                    .coachData.value.websiteUrl ??
                                    ""))
                                .then((_) {
                              showSnackBar(
                                isSuccess: true,
                                subtitle: "Code copied to clipboard",
                              );
                            });
                          },
                          child: BaseText(
                            value: athleteDashCtrl.coachData.value.websiteUrl ??
                                "",
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: BaseColors.primaryColor,
                            textAlign: TextAlign.end,
                            underline: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    height: 26,
                    color: BaseColors.grey5.withOpacity(.3),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const BaseText(
                        value: 'Coach Code',
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: BaseColors.black2,
                      ),
                      buildSizeWidth(20),
                      Expanded(
                        child: InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            await Clipboard.setData(ClipboardData(
                                    text: athleteDashCtrl
                                            .coachData.value.coachCode ??
                                        ""))
                                .then((_) {
                              showSnackBar(
                                isSuccess: true,
                                subtitle: "Code copied to clipboard",
                              );
                            });
                          },
                          child: BaseText(
                            value:
                                athleteDashCtrl.coachData.value.coachCode ?? "",
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: BaseColors.primaryColor,
                            textAlign: TextAlign.end,
                            underline: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    height: 26,
                    color: BaseColors.grey5.withOpacity(.3),
                  ),
                  buildSizeHeight(15),
                  if (athleteDashCtrl.coachData.value.resume != null &&
                      athleteDashCtrl.coachData.value.resume!.isNotEmpty)
                    Obx(() {
                      return Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 18),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: BaseColors.grey5),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SvgPicture.asset(BaseAssets.notes),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    BaseText(
                                      value: athleteDashCtrl
                                              .coachData.value.resume
                                              ?.split("/")
                                              .last ??
                                          "",
                                      // fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                                onTap: () {
                                  if ((athleteDashCtrl.coachData.value.resume ??
                                          "")
                                      .isNotEmpty) {
                                    urlLaunch(
                                      url: athleteDashCtrl
                                              .coachData.value.resume ??
                                          '',
                                    );
                                  }
                                },
                                child: SvgPicture.asset(BaseAssets.download)),
                          ],
                        ),
                      );
                    }),
                ],
              ),
            ],
          );
        }),
      ),
    );
  }
}
