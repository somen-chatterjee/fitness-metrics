import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness_metrics/common_controller/common_controller.dart';
import 'package:fitness_metrics/ui/base_components/base_button.dart';
import 'package:fitness_metrics/ui/base_components/base_text.dart';
import 'package:fitness_metrics/ui/base_components/base_text_field.dart';
import 'package:fitness_metrics/ui/coach/dashboard/controller/coach_dash_controller.dart';
import 'package:fitness_metrics/ui/coach/profile_coach/components/profile_data_edit.dart';
import 'package:fitness_metrics/ui/coach/profile_coach/controller/profile_coach_controller.dart';
import 'package:fitness_metrics/utils/base_assets.dart';
import 'package:fitness_metrics/utils/base_colors.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:fitness_metrics/utils/base_no_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var coachDashCtrl = Get.find<CoachDashController>();
  var profileCtrl = Get.find<ProfileController>();

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    profileCtrl.setData();
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: _refreshController,
      onRefresh: () {
        coachDashCtrl.profileDataCoach();
        _refreshController.refreshCompleted();
      },
      child: coachDashCtrl.profileData.value.name != null
          ? SingleChildScrollView(
              child: Obx(() {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildSizeHeight(15),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: BaseColors.grey5),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ClipOval(
                                child: (coachDashCtrl.profileData.value.image ??
                                            "")
                                        .isNotEmpty
                                    ? CachedNetworkImage(
                                        imageUrl: coachDashCtrl
                                                .profileData.value.image ??
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
                                      value: coachDashCtrl
                                              .profileData.value.name ??
                                          "",
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
                                              "${coachDashCtrl.profileData.value.age ?? 0}",
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
                          child: Obx(() {
                            return BaseText(
                              value:
                                  coachDashCtrl.profileData.value.mobile ?? "",
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: BaseColors.black2,
                              textAlign: TextAlign.end,
                            );
                          }),
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
                            value: coachDashCtrl.profileData.value.email ?? "",
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
                    Obx(() {
                      return Row(
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
                              value: dateDDMMYY(
                                  coachDashCtrl.profileData.value.dateOfBirth ??
                                      ""),
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: BaseColors.black2,
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ],
                      );
                    }),
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
                                      text: coachDashCtrl
                                              .profileData.value.coachCode ??
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
                                  coachDashCtrl.profileData.value.coachCode ??
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
                    buildSizeHeight(15),
                    //whatsapp
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const BaseText(
                          value: 'Whatsapp Number',
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                        buildSizeHeight(8),
                        BaseTextField(
                          controller: TextEditingController(
                              text: coachDashCtrl
                                      .profileData.value.whatsappNumber ??
                                  ""),
                          textInputType: TextInputType.name,
                          textCapitalization: TextCapitalization.sentences,
                          labelText: '',
                          readOnly: true,
                          hintText: 'Enter Whatsapp Number',
                          hintTextColor: BaseColors.grey,
                          borderColor: BaseColors.textFilledBorder,
                          fillColor: BaseColors.white,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 17.0,
                          ),
                          borderRadius: 15,
                          // validator: (val) {
                          //   if (controller.fullName.value.text
                          //       .trim()
                          //       .isEmpty) {
                          //     return "Please Enter Name";
                          //   }
                          //   return null;
                          // },
                          onTap: () => Get.to(() => const ProfileEdit()),
                        ),
                        buildSizeHeight(10),
                      ],
                    ),
                    //Ig and Other
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const BaseText(
                          value: 'IG profile',
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                        buildSizeHeight(8),
                        BaseTextField(
                          controller: TextEditingController(
                              text:
                                  coachDashCtrl.profileData.value.profileUrl ??
                                      ""),
                          textInputType: TextInputType.name,
                          textCapitalization: TextCapitalization.sentences,
                          labelText: '',
                          readOnly: true,
                          hintText: 'Enter Profile URL',
                          hintTextColor: BaseColors.grey,
                          borderColor: BaseColors.textFilledBorder,
                          fillColor: BaseColors.white,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 17.0),
                          borderRadius: 15,
                          // validator: (val) {
                          //   if (controller.fullName.value.text
                          //       .trim()
                          //       .isEmpty) {
                          //     return "Please Enter Name";
                          //   }
                          //   return null;
                          // },
                          onTap: () => Get.to(() => const ProfileEdit()),
                        ),
                        buildSizeHeight(10),
                      ],
                    ),
                    //Website and Other
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const BaseText(
                          value: 'Website and Other',
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                        buildSizeHeight(8),
                        BaseTextField(
                          controller: TextEditingController(
                              text:
                                  coachDashCtrl.profileData.value.websiteUrl ??
                                      ""),
                          textInputType: TextInputType.name,
                          textCapitalization: TextCapitalization.sentences,
                          labelText: '',
                          hintText: 'Enter URL',
                          readOnly: true,
                          hintTextColor: BaseColors.grey,
                          borderColor: BaseColors.textFilledBorder,
                          fillColor: BaseColors.white,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 17.0),
                          borderRadius: 15,
                          // validator: (val) {
                          //   if (controller.fullName.value.text
                          //       .trim()
                          //       .isEmpty) {
                          //     return "Please Enter Name";
                          //   }
                          //   return null;
                          // },
                          onTap: () => Get.to(() => const ProfileEdit()),
                        ),
                        buildSizeHeight(10),
                        //resume
                        BaseTextField(
                          controller: TextEditingController(
                              text: (coachDashCtrl.profileData.value.resume ?? "").split('/').last),
                          textInputType: TextInputType.name,
                          readOnly: true,
                          textCapitalization: TextCapitalization.sentences,
                          labelText: '',
                          hintText: 'Resume',
                          hintTextColor: BaseColors.grey,
                          borderColor: BaseColors.textFilledBorder,
                          prefixIcon: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Visibility(
                                visible: (coachDashCtrl.profileData.value.resume ?? "")
                                    .isNotEmpty,
                                child: SvgPicture.asset(BaseAssets.notes)),
                          ),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              if ((coachDashCtrl.profileData.value.resume ?? "")
                                  .isNotEmpty) {
                                urlLaunch(
                                  url: coachDashCtrl.profileData.value.resume ??
                                      '',
                                );
                              }
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: SvgPicture.asset(BaseAssets.download),
                            ),
                          ),
                          fillColor: BaseColors.white,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 17.0),
                          borderRadius: 15,
                          // validator: (val) {
                          //   if (controller.fullName.value.text
                          //       .trim()
                          //       .isEmpty) {
                          //     return "Please Enter Name";
                          //   }
                          //   return null;
                          // },
                          onTap: () => Get.to(() => const ProfileEdit()),
                        ),
                      ],
                    ),
                    buildSizeHeight(10),
                    BaseButton(
                      title: "Edit Profile",
                      borderRadius: 15,
                      fontSize: 18,
                      btnColor: BaseColors.primaryColor,
                      leftMargin: 30,
                      rightMargin: 30,
                      onPressed: () {
                        Get.to(() => const ProfileEdit());
                      },
                    ),
                    buildSizeHeight(10),
                    BaseButton(
                      title: "Log Out",
                      borderRadius: 15,
                      fontSize: 18,
                      btnColor: BaseColors.primaryColor,
                      leftMargin: 30,
                      rightMargin: 30,
                      onPressed: () {
                        Get.find<CommonController>().showLogoutDialog(context);
                      },
                    ),
                    buildSizeHeight(25),
                  ],
                );
              }),
            )
          : const Center(child: BaseNoData(message: "No Coach Data Found!")),
    );
  }
}
