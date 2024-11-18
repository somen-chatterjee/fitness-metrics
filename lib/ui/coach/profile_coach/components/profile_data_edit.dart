// ignore: unused_import
import 'dart:developer';
import 'dart:io';

import 'package:fitness_metrics/ui/base_components/base_button.dart';
import 'package:fitness_metrics/ui/base_components/base_column.dart';
import 'package:fitness_metrics/ui/base_components/base_text.dart';
import 'package:fitness_metrics/ui/base_components/base_text_field.dart';
import 'package:fitness_metrics/ui/coach/profile_coach/components/small_components/coach_edit_profile_app_bar.dart';
import 'package:fitness_metrics/ui/coach/profile_coach/controller/profile_coach_controller.dart';
import 'package:fitness_metrics/utils/base_assets.dart';
import 'package:fitness_metrics/utils/base_colors.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ProfileEdit extends StatefulWidget {
  const ProfileEdit({super.key});

  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  var profileCtrl = Get.find<ProfileController>();

  @override
  void initState() {
    super.initState();
    profileCtrl.setData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const CoachEditProfileAppBar(),
          buildSizeHeight(15),
          Expanded(
            child: SingleChildScrollView(
              child: Form(
                key: profileCtrl.profileUpdateKey,
                child: BaseColumn(
                  children: [
                    //name
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const BaseText(value: 'Full Name'),
                        buildSizeHeight(8),
                        BaseTextField(
                          controller: profileCtrl.nameController,
                          textInputType: TextInputType.name,
                          textCapitalization: TextCapitalization.sentences,
                          labelText: '',
                          hintText: 'Enter Full Name',
                          hintTextColor: BaseColors.grey,
                          borderColor: BaseColors.textFilledBorder,
                          fillColor: BaseColors.textFilledFill,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 17.0),
                          borderRadius: 15,
                          validator: (val) {
                            if (profileCtrl.nameController.value.text
                                .trim()
                                .isEmpty) {
                              return "Please Enter Name";
                            }
                            return null;
                          },
                        ),
                        buildSizeHeight(8),
                      ],
                    ),

                    //phone
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const BaseText(value: 'Phone'),
                        buildSizeHeight(8),
                        BaseTextField(
                          controller: profileCtrl.phoneController,
                          textInputType: TextInputType.name,
                          textCapitalization: TextCapitalization.sentences,
                          labelText: '',
                          readOnly: true,
                          hintText: 'Enter Phone',
                          hintTextColor: BaseColors.grey,
                          borderColor: BaseColors.textFilledBorder,
                          fillColor: BaseColors.textFilledFill,
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
                        ),
                        buildSizeHeight(8),
                      ],
                    ),

                    //email
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const BaseText(value: 'Email address'),
                        buildSizeHeight(8),
                        BaseTextField(
                          controller: profileCtrl.emailController,
                          textInputType: TextInputType.name,
                          textCapitalization: TextCapitalization.sentences,
                          labelText: '',
                          readOnly: true,
                          hintText: 'Enter Email address',
                          hintTextColor: BaseColors.grey,
                          borderColor: BaseColors.textFilledBorder,
                          fillColor: BaseColors.textFilledFill,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 17.0),
                          borderRadius: 15,
                          validator: (val) {
                            if (profileCtrl.emailController.value.text
                                .trim()
                                .isEmpty) {
                              return "Please Enter Your Email";
                            }
                            return null;
                          },
                        ),
                        buildSizeHeight(8),
                      ],
                    ),

                    //age
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const BaseText(value: 'Date Of Birth'),
                        buildSizeHeight(8),
                        BaseTextField(
                          controller: profileCtrl.ageController,
                          textInputType: TextInputType.number,
                          // textCapitalization: TextCapitalization.sentences,
                          labelText: '',
                          hintText: 'Enter Date Of Birth',
                          readOnly: true,
                          hintTextColor: BaseColors.grey,
                          borderColor: BaseColors.textFilledBorder,
                          fillColor: BaseColors.textFilledFill,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 17.0),
                          borderRadius: 15,
                          validator: (val) {
                            if (profileCtrl.ageController.value.text
                                .trim()
                                .isEmpty) {
                              return "Please Select Date Of Birth";
                            } else if (!profileCtrl
                                .isAdult(profileCtrl.dobDate)) {
                              return "Your Age Should Be Above 13";
                            }
                            return null;
                          },
                          onTap: () {
                            showBaseDatePicker(
                              context,
                              // firstDate: checkOutCtrl.currentDate,
                              lastDate: DateTime.now(),
                            ).then((val) {
                              if (val.isNotEmpty) {
                                profileCtrl.ageController.text =
                                    dateDDMMYY(val);
                                profileCtrl.dobDate = dateYYMMDD(val);
                              }
                            });
                          },
                        ),
                        buildSizeHeight(8),
                      ],
                    ),

                    //whatsapp number
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const BaseText(value: 'Whatsapp Number'),
                        buildSizeHeight(8),
                        BaseTextField(
                          controller: profileCtrl.whatsappController,
                          textInputType: TextInputType.number,
                          // textCapitalization: TextCapitalization.sentences,
                          labelText: '',
                          hintText: 'Enter Whatsapp Number',
                          hintTextColor: BaseColors.grey,
                          borderColor: BaseColors.textFilledBorder,
                          fillColor: BaseColors.textFilledFill,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 17.0),
                          borderRadius: 15,
                          maxLength: 15,
                          validator: (val) {
                            if (val!.trim().isNotEmpty &&
                                (val.trim().length < 6 ||
                                    val.trim().length > 15)) {
                              return "WhatsApp number length should be between 6 to 15";
                            }
                            return null;
                          },
                        ),
                        buildSizeHeight(8),
                      ],
                    ),

                    //ig profile
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const BaseText(value: 'IG Profile'),
                        buildSizeHeight(8),
                        BaseTextField(
                          controller: profileCtrl.igProfileController,
                          textInputType: TextInputType.text,
                          // textCapitalization: TextCapitalization.sentences,
                          labelText: '',
                          hintText: 'Enter IG Profile',
                          hintTextColor: BaseColors.grey,
                          borderColor: BaseColors.textFilledBorder,
                          fillColor: BaseColors.textFilledFill,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 17.0),
                          borderRadius: 15,
                          validator: (val) {
                            // Regular expression for validating Instagram profile URLs
                            const instagramPattern =
                                r"^(https?:\/\/)?(www\.)?(instagram\.com\/|instagr\.am\/)[a-zA-Z0-9(_)?]{1,30}(\/)?(\?.*)?$";

                            if (val!.trim().isNotEmpty &&
                                (!RegExp(instagramPattern)
                                    .hasMatch(val.trim()))) {
                              return "Enter a valid Instagram URL";
                            }
                            return null;
                          },
                        ),
                        buildSizeHeight(8),
                      ],
                    ),

                    //website url
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const BaseText(value: 'Website Url'),
                        buildSizeHeight(8),
                        BaseTextField(
                          controller: profileCtrl.websiteController,
                          textInputType: TextInputType.text,
                          // textCapitalization: TextCapitalization.sentences,
                          labelText: '',
                          hintText: 'Enter Your Website Url',
                          hintTextColor: BaseColors.grey,
                          borderColor: BaseColors.textFilledBorder,
                          fillColor: BaseColors.textFilledFill,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 17.0,
                          ),
                          borderRadius: 15,
                          validator: (val) {
                            // Regular expression for validating general website URLs
                            const websitePattern =
                                r"^(https?:\/\/)?([a-zA-Z0-9_\-]+\.)+[a-zA-Z]{2,6}(\/[a-zA-Z0-9_\-#]*)*(\/)?(\?.*)?$";

                            if (val!.trim().isNotEmpty &&
                                (!RegExp(websitePattern)
                                    .hasMatch(val.trim()))) {
                              return "Enter a valid website URL";
                            }
                            return null;
                          },
                        ),
                        buildSizeHeight(8),
                      ],
                    ),

                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const BaseText(value: 'Resume'),
                        buildSizeHeight(8),
                        BaseTextField(
                          controller: profileCtrl.resumeController,
                          textInputType: TextInputType.name,
                          readOnly: true,
                          textCapitalization: TextCapitalization.sentences,
                          labelText: '',
                          hintText: 'Resume',
                          hintTextColor: BaseColors.grey,
                          borderColor: BaseColors.textFilledBorder,
                          suffixIcon: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: SvgPicture.asset(BaseAssets.uploadDoc),
                          ),
                          fillColor: BaseColors.textFilledFill,
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
                          onTap: () async {
                            await pickAndUploadFile(
                              allowExtensionsList: ['pdf', 'docx'],
                            ).then((value) {
                              var path = value?.path;

                              if ((path ?? "").isNotEmpty) {
                                String fileExtension =
                                    path!.split('.').last.toLowerCase();

                                if (fileExtension == 'pdf' ||
                                    fileExtension == 'docx') {
                                  profileCtrl.selectedResume.value =
                                      value ?? File("");
                                  profileCtrl.resumeController.text =
                                      path.split("/").last;
                                } else {
                                  // Show an error message if the file is not a PDF or DOCX
                                  showSnackBar(
                                    title: "Invalid File!",
                                    subtitle:
                                        "Please upload a valid PDF or DOCX file.",
                                  );
                                }
                              }
                            });
                          },
                        ),
                        buildSizeHeight(8),
                      ],
                    ),

                    /*Obx(() {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const BaseText(value: 'Gender'),
                          buildSizeHeight(8),
                          Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                                color: BaseColors.textFilledFill,
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: BaseColors.textFilledBorder,
                                )
                            ),
                            height: 58,
                            width: double.infinity,
                            child: DropdownButton<String>(
                              value: dataEditCtrl.genderValue.value,
                              icon: const Icon(Icons.keyboard_arrow_down_sharp,
                                color: BaseColors.black1,),
                              elevation: 16,
                              isExpanded: true,
                              style: const TextStyle(color: Colors.deepPurple),
                              underline: Container(
                                // height: 2,
                                // color: Colors.deepPurpleAccent,
                              ),
                              onChanged: (String? value) {
                                // This is called when the user selects an item.
                                // setState(() {
                                dataEditCtrl.genderValue.value = value!;
                                // });
                              },
                              items: dataEditCtrl.genderList.map((
                                  Map<String, String> value) {
                                return DropdownMenuItem<String>(
                                  value: value['type'].toString(),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(value['icon'].toString(),
                                        width: 16,
                                        height: 16,),
                                      buildSizeWidth(10),
                                      BaseText(
                                        value: value['type'].toString(),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      );
                    }),*/

                    buildSizeHeight(35),
                    BaseButton(
                      title: "Update",
                      borderRadius: 15,
                      fontSize: 18,
                      btnColor: BaseColors.primaryColor,
                      leftMargin: 30,
                      rightMargin: 30,
                      onPressed: () {
                        if (profileCtrl.profileUpdateKey.currentState!
                            .validate()) {
                          profileCtrl.updateProfileCoach();
                        }
                      },
                    ),
                    buildSizeHeight(30),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
