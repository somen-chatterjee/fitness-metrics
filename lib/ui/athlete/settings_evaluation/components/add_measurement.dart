import 'package:fitness_metrics/ui/athlete/settings_evaluation/controller/add_measure_controller.dart';
import 'package:fitness_metrics/ui/base_components/base_app_bar.dart';
import 'package:fitness_metrics/ui/base_components/base_button.dart';
import 'package:fitness_metrics/ui/base_components/base_column.dart';
import 'package:fitness_metrics/ui/base_components/base_text.dart';
import 'package:fitness_metrics/ui/base_components/base_text_field.dart';
import 'package:fitness_metrics/ui/common_ui/date_select.dart';
import 'package:fitness_metrics/utils/base_colors.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddMeasurement extends StatefulWidget {
  const AddMeasurement({super.key});

  @override
  State<AddMeasurement> createState() => _AddMeasurementState();
}

class _AddMeasurementState extends State<AddMeasurement> {
  late AddMeasureController addMeasureCtrl;

  @override
  void initState() {
    super.initState();
    addMeasureCtrl = Get.put(AddMeasureController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const BaseAppBar(
            title: 'Add Measurement',
          ),
          buildSizeHeight(5),
          Expanded(
            child: SingleChildScrollView(
              child: Form(
                key: addMeasureCtrl.addMeasureFormKey,
                child: BaseColumn(
                  children: [
                    Column(
                      children: [
                        Divider(
                          color: BaseColors.grey5.withOpacity(0.4),
                          height: 22,
                        ),
                        InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () => _chooseDateBottomSheet(context),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const BaseText(
                                value: 'Choose Date',
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                              Obx(() {
                                return Row(
                                  children: [
                                    BaseText(
                                      value: dateDDMMYY(addMeasureCtrl.selectedDate.value),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                    ),
                                    const Icon(
                                      Icons.keyboard_arrow_right_rounded,
                                      color: BaseColors.primaryColor,
                                      size: 20,
                                    ),
                                  ],
                                );
                              }),
                            ],
                          ),
                        ),
                        Divider(
                          color: BaseColors.grey5.withOpacity(0.4),
                          height: 22,
                        ),
                      ],
                    ),
                    buildSizeHeight(20),
                    //Chest
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const BaseText(
                          value: 'Chest',
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                        buildSizeHeight(8),
                        BaseTextField(
                          controller: addMeasureCtrl.chestCtrl,
                          textInputType: TextInputType.number,
                          // textCapitalization: TextCapitalization.sentences,
                          labelText: '',
                          hintText: 'Chest',
                          hintTextColor: BaseColors.grey,
                          borderColor: BaseColors.textFilledBorder,
                          fillColor: BaseColors.white,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 17.0),
                          borderRadius: 15,
                          validator: (val) {
                            if (addMeasureCtrl.chestCtrl.value.text
                                .trim()
                                .isEmpty) {
                              return "* Required";
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                    buildSizeHeight(20),
                    //Arm
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const BaseText(
                          value: 'Arm',
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const BaseText(
                                    value: 'L',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                  buildSizeHeight(8),
                                  BaseTextField(
                                    controller: addMeasureCtrl.leftArmCtrl,
                                    textInputType: TextInputType.number,
                                    // textCapitalization: TextCapitalization.sentences,
                                    labelText: '',
                                    hintText: '--',
                                    hintTextColor: BaseColors.grey,
                                    borderColor: BaseColors.textFilledBorder,
                                    fillColor: BaseColors.white,
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 16.0, vertical: 17.0),
                                    borderRadius: 15,
                                    validator: (val) {
                                      if (addMeasureCtrl.leftArmCtrl.value.text
                                          .trim()
                                          .isEmpty) {
                                        return "* Required";
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                            ),
                            buildSizeWidth(20),
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const BaseText(
                                    value: 'R',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                  buildSizeHeight(8),
                                  BaseTextField(
                                    controller: addMeasureCtrl.rightArmCtrl,
                                    textInputType: TextInputType.number,
                                    // textCapitalization: TextCapitalization.sentences,
                                    labelText: '',
                                    hintText: '--',
                                    hintTextColor: BaseColors.grey,
                                    borderColor: BaseColors.textFilledBorder,
                                    fillColor: BaseColors.white,
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 16.0, vertical: 17.0,
                                    ),
                                    borderRadius: 15,
                                    validator: (val) {
                                      if (addMeasureCtrl.rightArmCtrl.value.text
                                          .trim()
                                          .isEmpty) {
                                        return "* Required";
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    buildSizeHeight(20),
                    //Thigh
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const BaseText(
                          value: 'Thigh',
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const BaseText(
                                    value: 'L',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                  buildSizeHeight(8),
                                  BaseTextField(
                                    controller: addMeasureCtrl.leftThighCtrl,
                                    textInputType: TextInputType.number,
                                    // textCapitalization: TextCapitalization.sentences,
                                    labelText: '',
                                    hintText: '--',
                                    hintTextColor: BaseColors.grey,
                                    borderColor: BaseColors.textFilledBorder,
                                    fillColor: BaseColors.white,
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 16.0, vertical: 17.0),
                                    borderRadius: 15,
                                    validator: (val) {
                                      if (addMeasureCtrl.leftThighCtrl.value.text
                                          .trim()
                                          .isEmpty) {
                                        return "* Required";
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                            ),
                            buildSizeWidth(20),
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const BaseText(
                                    value: 'R',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                  buildSizeHeight(8),
                                  BaseTextField(
                                    // controller: dataEditCtrl.nameController,
                                    controller: addMeasureCtrl.rightThighCtrl,
                                    textInputType: TextInputType.number,
                                    // textCapitalization: TextCapitalization.sentences,
                                    labelText: '',
                                    hintText: '--',
                                    hintTextColor: BaseColors.grey,
                                    borderColor: BaseColors.textFilledBorder,
                                    fillColor: BaseColors.white,
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 16.0, vertical: 17.0),
                                    borderRadius: 15,
                                    validator: (val) {
                                      if (addMeasureCtrl.rightThighCtrl.value.text
                                          .trim()
                                          .isEmpty) {
                                        return "* Required";
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    buildSizeHeight(20),
                    //Hips
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const BaseText(
                          value: 'Hips',
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const BaseText(
                                    value: 'L',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                  buildSizeHeight(8),
                                  BaseTextField(
                                    controller: addMeasureCtrl.leftHipsCtrl,
                                    textInputType: TextInputType.number,
                                    // textCapitalization: TextCapitalization.sentences,
                                    labelText: '',
                                    hintText: '--',
                                    hintTextColor: BaseColors.grey,
                                    borderColor: BaseColors.textFilledBorder,
                                    fillColor: BaseColors.white,
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 16.0, vertical: 17.0),
                                    borderRadius: 15,
                                    validator: (val) {
                                      if (addMeasureCtrl.leftHipsCtrl.value.text
                                          .trim()
                                          .isEmpty) {
                                        return "* Required";
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                            ),
                            buildSizeWidth(20),
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const BaseText(
                                    value: 'R',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                  buildSizeHeight(8),
                                  BaseTextField(
                                    controller: addMeasureCtrl.rightHipsCtrl,
                                    textInputType: TextInputType.number,
                                    // textCapitalization: TextCapitalization.sentences,
                                    labelText: '',
                                    hintText: '--',
                                    hintTextColor: BaseColors.grey,
                                    borderColor: BaseColors.textFilledBorder,
                                    fillColor: BaseColors.white,
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 16.0, vertical: 17.0),
                                    borderRadius: 15,
                                    validator: (val) {
                                      if (addMeasureCtrl.rightHipsCtrl.value.text
                                          .trim()
                                          .isEmpty) {
                                        return "* Required";
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    buildSizeHeight(20),
                    //abs
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const BaseText(
                          value: 'Abs',
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                        buildSizeHeight(8),
                        BaseTextField(
                          controller: addMeasureCtrl.absCtrl,
                          textInputType: TextInputType.number,
                          // textCapitalization: TextCapitalization.sentences,
                          labelText: '',
                          hintText: 'Abs',
                          hintTextColor: BaseColors.grey,
                          borderColor: BaseColors.textFilledBorder,
                          fillColor: BaseColors.white,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 17.0),
                          borderRadius: 15,
                          validator: (val) {
                            if (addMeasureCtrl.absCtrl.value.text
                                .trim()
                                .isEmpty) {
                              return "* Required";
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                    buildSizeHeight(20),
                    //calves
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const BaseText(
                          value: 'Calves',
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                        buildSizeHeight(8),
                        BaseTextField(
                          controller: addMeasureCtrl.calvesCtrl,
                          textInputType: TextInputType.number,
                          // textCapitalization: TextCapitalization.sentences,
                          labelText: '',
                          hintText: 'Calves',
                          hintTextColor: BaseColors.grey,
                          borderColor: BaseColors.textFilledBorder,
                          fillColor: BaseColors.white,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 17.0),
                          borderRadius: 15,
                          validator: (val) {
                            if (addMeasureCtrl.calvesCtrl.value.text
                                .trim()
                                .isEmpty) {
                              return "* Required";
                            }
                            return null;
                          },
                        ),
                      ],
                    ),

                    buildSizeHeight(35),
                    BaseButton(
                      title: "Update",
                      borderRadius: 15,
                      fontSize: 18,
                      btnColor: BaseColors.primaryColor,
                      leftMargin: 30,
                      rightMargin: 30,
                      onPressed: () {
                        if(addMeasureCtrl.addMeasureFormKey.currentState!.validate()) {
                          addMeasureCtrl.measurementsCreate();
                        }
                      },
                    ),
                    buildSizeHeight(25),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _chooseDateBottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return const DateSelect();
      },
    );
  }
}
