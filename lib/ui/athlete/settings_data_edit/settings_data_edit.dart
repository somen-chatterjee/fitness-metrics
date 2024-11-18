// ignore: unused_import
import 'package:fitness_metrics/ui/athlete/dashboard/components/dashboard_app_bar.dart';
import 'package:fitness_metrics/ui/athlete/settings_data_edit/components/edit_profile_app_bar.dart';
import 'package:fitness_metrics/ui/athlete/settings_data_edit/controller/data_edit_controller.dart';
import 'package:fitness_metrics/ui/base_components/base_button.dart';
import 'package:fitness_metrics/ui/base_components/base_column.dart';
import 'package:fitness_metrics/ui/base_components/base_text.dart';
import 'package:fitness_metrics/ui/base_components/base_text_field.dart';
import 'package:fitness_metrics/utils/base_colors.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SettingsDataEdit extends StatefulWidget {
  const SettingsDataEdit({super.key});

  @override
  State<SettingsDataEdit> createState() => _SettingsDataEditState();
}

class _SettingsDataEditState extends State<SettingsDataEdit> {
  var dataEditCtrl = Get.put(DataEditController());

  @override
  void initState() {
    super.initState();
    dataEditCtrl.setData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const EditProfileAppBar(),
          buildSizeHeight(15),
          Expanded(
            child: SingleChildScrollView(
              child: Form(
                key: dataEditCtrl.profileUpdateFormKey,
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
                          controller: dataEditCtrl.nameController,
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
                            if (dataEditCtrl.nameController.value.text
                                .trim()
                                .isEmpty) {
                              return "Please Enter Your Name";
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                    //phone
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildSizeHeight(8),
                        const BaseText(value: 'Phone'),
                        buildSizeHeight(8),
                        BaseTextField(
                          controller: dataEditCtrl.phoneController,
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
                          validator: (val) {
                            if (dataEditCtrl.phoneController.value.text
                                .trim()
                                .isEmpty) {
                              return "Please Enter Your Phone";
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                    //email
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildSizeHeight(8),
                        const BaseText(value: 'Email address'),
                        buildSizeHeight(8),
                        BaseTextField(
                          controller: dataEditCtrl.emailController,
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
                            if (dataEditCtrl.emailController.value.text
                                .trim()
                                .isEmpty) {
                              return "Please Enter Your Email";
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                    //age
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildSizeHeight(8),
                        const BaseText(value: 'Date Of Birth'),
                        buildSizeHeight(8),
                        BaseTextField(
                          controller: dataEditCtrl.ageController,
                          textInputType: TextInputType.number,
                          // textCapitalization: TextCapitalization.sentences,
                          labelText: '',
                          hintText: 'Enter Date Of Birth',
                          hintTextColor: BaseColors.grey,
                          borderColor: BaseColors.textFilledBorder,
                          fillColor: BaseColors.textFilledFill,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 17.0),
                          borderRadius: 15,
                          readOnly: true,
                          onTap: () {
                            showBaseDatePicker(
                              context,
                              // firstDate: checkOutCtrl.currentDate,
                              lastDate: DateTime.now(),
                            ).then((val) {
                              if (val.isNotEmpty) {
                                dataEditCtrl.ageController.text =
                                    dateDDMMYY(val);
                                dataEditCtrl.dobDate = dateYYMMDD(val);
                              }
                            });
                          },
                          validator: (val) {
                            if (dataEditCtrl.ageController.value.text
                                .trim()
                                .isEmpty) {
                              return "Please Select Date Of Birth";
                            } else if (!dataEditCtrl
                                .isAdult(dataEditCtrl.dobDate)) {
                              return "Your Age Should Be Above 13";
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                    //weight
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildSizeHeight(8),
                        const BaseText(value: 'Weight'),
                        buildSizeHeight(8),
                        BaseTextField(
                          controller: dataEditCtrl.weightController,
                          textInputType: TextInputType.number,
                          // textCapitalization: TextCapitalization.sentences,
                          labelText: '',
                          hintText: 'Enter Weight',
                          hintTextColor: BaseColors.grey,
                          borderColor: BaseColors.textFilledBorder,
                          fillColor: BaseColors.textFilledFill,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 17.0),
                          borderRadius: 15,
                          suffixIcon: Obx(() {
                            return Container(
                              padding: const EdgeInsets.all(8),
                              margin: const EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                color: BaseColors.grey5.withOpacity(.25),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: ToggleButtons(
                                constraints: const BoxConstraints(
                                    maxHeight: 60,
                                    maxWidth: 50,
                                    minHeight: 30,
                                    minWidth: 45),
                                isSelected: [
                                  dataEditCtrl.kg.value == 0,
                                  dataEditCtrl.kg.value == 1,
                                ],
                                renderBorder: false,
                                onPressed: (index) {

                                  dataEditCtrl.changeWeightHeight(index: index);

                                  // dataEditCtrl.kg.value = index;
                                  //
                                  // dataEditCtrl.feet.value = index;
                                  //
                                  // dataEditCtrl.calculateBMI();
                                },
                                // selectedColor: BaseColors.whiteColor,
                                // color: BaseColors.primaryColor,
                                // selectedColor: BaseColors.primaryColor,
                                // disabledColor: BaseColors.primaryColor,
                                fillColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                // borderRadius: BorderRadius.circular(8.0),
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: dataEditCtrl.kg.value == 0
                                          ? Colors.white
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    padding: const EdgeInsets.all(7),
                                    width: double.infinity,
                                    alignment: Alignment.center,
                                    child: const BaseText(
                                      value: 'LBS',
                                      color: BaseColors.black1,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      maxLines: 2,
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: dataEditCtrl.kg.value == 1
                                          ? Colors.white
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    padding: const EdgeInsets.all(7),
                                    width: double.infinity,
                                    alignment: Alignment.center,
                                    child: const BaseText(
                                      value: 'KG',
                                      color: BaseColors.black1,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      maxLines: 2,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                          onChanged: (val) {
                            dataEditCtrl.calculateBMI();
                          },
                          validator: (val) {
                            if (dataEditCtrl.weightController.value.text
                                .trim()
                                .isEmpty) {
                              return "Please Enter Your Weight";
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                    //height
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildSizeHeight(8),
                        const BaseText(value: 'Height'),
                        buildSizeHeight(8),
                        BaseTextField(
                          controller: dataEditCtrl.heightController,
                          textInputType: TextInputType.number,
                          // textCapitalization: TextCapitalization.sentences,
                          labelText: '',
                          hintText: 'Enter Height',
                          hintTextColor: BaseColors.grey,
                          borderColor: BaseColors.textFilledBorder,
                          fillColor: BaseColors.textFilledFill,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 17.0),
                          borderRadius: 15,
                          suffixIcon: Obx(() {
                            return Container(
                              padding: const EdgeInsets.all(8),
                              margin: const EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                color: BaseColors.grey5.withOpacity(.25),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: ToggleButtons(
                                constraints: const BoxConstraints(
                                    maxHeight: 60,
                                    maxWidth: 50,
                                    minHeight: 30,
                                    minWidth: 45),
                                isSelected: [
                                  dataEditCtrl.feet.value == 0,
                                  dataEditCtrl.feet.value == 1,
                                ],
                                renderBorder: false,
                                onPressed: (index) {

                                  dataEditCtrl.changeWeightHeight(index: index);

                                  // dataEditCtrl.feet.value = index;
                                  // dataEditCtrl.kg.value = index;
                                  // dataEditCtrl.calculateBMI();
                                },
                                // selectedColor: BaseColors.whiteColor,
                                // color: BaseColors.primaryColor,
                                // selectedColor: BaseColors.primaryColor,
                                // disabledColor: BaseColors.primaryColor,
                                fillColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                // borderRadius: BorderRadius.circular(8.0),
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: dataEditCtrl.feet.value == 0
                                          ? Colors.white
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    padding: const EdgeInsets.all(7),
                                    width: double.infinity,
                                    alignment: Alignment.center,
                                    child: const BaseText(
                                      value: 'FEET',
                                      color: BaseColors.black1,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      maxLines: 2,
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: dataEditCtrl.feet.value == 1
                                          ? Colors.white
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    padding: const EdgeInsets.all(7),
                                    width: double.infinity,
                                    alignment: Alignment.center,
                                    child: const BaseText(
                                      value: 'CM',
                                      color: BaseColors.black1,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      maxLines: 2,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                          onChanged: (val) {
                            dataEditCtrl.calculateBMI();
                          },
                          validator: (val) {
                            if (dataEditCtrl.heightController.value.text
                                .trim()
                                .isEmpty) {
                              return "Please Enter Your Height";
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                    //Bmi
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildSizeHeight(8),
                        const BaseText(value: 'BMI'),
                        buildSizeHeight(8),
                        BaseTextField(
                          controller: dataEditCtrl.bmiController,
                          textInputType: TextInputType.text,
                          // textCapitalization: TextCapitalization.sentences,
                          labelText: '',
                          hintText: 'Enter BMI',
                          hintTextColor: BaseColors.grey,
                          borderColor: BaseColors.textFilledBorder,
                          fillColor: BaseColors.textFilledFill,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 17.0),
                          borderRadius: 15,
                          validator: (val) {
                            if (dataEditCtrl.bmiController.value.text
                                .trim()
                                .isEmpty) {
                              return "Please Enter Your BMI";
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                    //Gender
                    Obx(() {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildSizeHeight(8),
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
                    }),
                    buildSizeHeight(35),
                    BaseButton(
                      title: "Update",
                      borderRadius: 15,
                      fontSize: 18,
                      btnColor: BaseColors.primaryColor,
                      leftMargin: 30,
                      rightMargin: 30,
                      onPressed: () {
                        if(dataEditCtrl.profileUpdateFormKey.currentState!.validate()) {
                          dataEditCtrl.updateProfileAthlete();
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
