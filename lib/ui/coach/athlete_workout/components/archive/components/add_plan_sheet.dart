import 'package:fitness_metrics/ui/base_components/base_button.dart';
import 'package:fitness_metrics/ui/base_components/base_column.dart';
import 'package:fitness_metrics/ui/base_components/base_text.dart';
import 'package:fitness_metrics/ui/base_components/base_text_field.dart';
import 'package:fitness_metrics/ui/coach/athlete_workout/controller/coach_archive_controller.dart';
import 'package:fitness_metrics/utils/base_assets.dart';
import 'package:fitness_metrics/utils/base_colors.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:fitness_metrics/utils/custom_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class AddPlanSheet extends StatefulWidget {
  const AddPlanSheet({super.key});

  @override
  State<AddPlanSheet> createState() => _AddPlanSheetState();
}

class _AddPlanSheetState extends State<AddPlanSheet> {
  var coachArchiveCtrl = Get.find<CoachArchiveController>();

  bool _switchValue = false;

  @override
  void initState() {
    super.initState();
    coachArchiveCtrl.clearFields();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 0,
        right: 0,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 24),
            decoration: const BoxDecoration(
              color: BaseColors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: coachArchiveCtrl.createPlanFormKey,
                  child: BaseColumn(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BaseText(
                            value: 'Create Plan',
                            color: BaseColors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ],
                      ),
                      buildSizeHeight(30),
                      //plan
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const BaseText(
                            value: 'Plan Name',
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                          buildSizeHeight(8),
                          BaseTextField(
                            controller: coachArchiveCtrl.planNameController,
                            textInputType: TextInputType.name,
                            textCapitalization: TextCapitalization.sentences,
                            labelText: '',
                            hintText: 'Plan Name',
                            hintTextColor: BaseColors.grey,
                            borderColor: BaseColors.textFilledBorder,
                            fillColor: BaseColors.white,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 17.0,
                            ),
                            borderRadius: 15,
                            validator: (val) {
                              if (val.toString().trim().isEmpty) {
                                return "Please Enter Plan Name";
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                      buildSizeHeight(10),
                      //start date, end date
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const BaseText(
                                  value: 'Start Date',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                                buildSizeHeight(8),
                                BaseTextField(
                                  controller:
                                      coachArchiveCtrl.startDateController,
                                  textInputType: TextInputType.name,
                                  textCapitalization:
                                      TextCapitalization.sentences,
                                  labelText: '',
                                  hintText: 'Start Date',
                                  readOnly: true,
                                  hintTextColor: BaseColors.grey2,
                                  borderColor: BaseColors.textFilledBorder,
                                  fillColor: BaseColors.white,
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 17.0),
                                  borderRadius: 15,
                                  suffixIcon: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: SvgPicture.asset(
                                      BaseAssets.calendar,
                                      width: 20,
                                      colorFilter: const ColorFilter.mode(BaseColors.grey, BlendMode.srcIn),
                                    ),
                                  ),
                                  validator: (val) {
                                    if (val.toString().trim().isEmpty) {
                                      return "* Required";
                                    }
                                    return null;
                                  },
                                  onTap: () {
                                    showBaseDatePicker(context,
                                            firstDate: DateTime.now(),
                                            lastDate: DateTime(2050, 12, 1))
                                        .then((val) {
                                      if (val.isNotEmpty) {
                                        coachArchiveCtrl.startDateController
                                            .text = dateDDMMYY(val);
                                        coachArchiveCtrl
                                            .finishDateController.text = "";
                                      }
                                    });
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
                                  value: 'Finish Date',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                                buildSizeHeight(8),
                                BaseTextField(
                                  controller:
                                      coachArchiveCtrl.finishDateController,
                                  textInputType: TextInputType.name,
                                  textCapitalization:
                                      TextCapitalization.sentences,
                                  labelText: '',
                                  hintText: 'Finish Date',
                                  readOnly: true,
                                  hintTextColor: BaseColors.grey2,
                                  borderColor: BaseColors.textFilledBorder,
                                  fillColor: BaseColors.white,
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 17.0),
                                  borderRadius: 15,
                                  suffixIcon: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: SvgPicture.asset(
                                      BaseAssets.calendar,
                                      width: 20,
                                      colorFilter: const ColorFilter.mode(BaseColors.grey, BlendMode.srcIn),
                                    ),
                                  ),
                                  validator: (val) {
                                    if (val.toString().trim().isEmpty) {
                                      return "* Required";
                                    }
                                    return null;
                                  },
                                  onTap: () {
                                    // if (coachArchiveCtrl
                                    //     .createPlanFormKey.currentState!
                                    //     .validate()) {
                                    var startDate = coachArchiveCtrl
                                        .startDateController.text
                                        .toString();
                                    if (startDate.isNotEmpty) {
                                      showBaseDatePicker(context,
                                              firstDate: changeToDateTime(
                                                dateString: startDate,
                                              ).add(const Duration(days: 1)),
                                              lastDate: DateTime(2050, 12, 1))
                                          .then((val) {
                                        if (val.isNotEmpty) {
                                          coachArchiveCtrl.finishDateController
                                              .text = dateDDMMYY(val);
                                        }
                                      });
                                    }
                                    // }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      buildSizeHeight(10),
                      //status
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const BaseText(
                            value: 'Status',
                            // color: BaseColors.secondaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          CustomSwitch(
                            value: _switchValue,
                            activeColor: BaseColors.green2,
                            // inActiveColor: BaseColors.grey5.withOpacity(0.7),
                            onChanged: (bool val) {
                              setState(() {
                                _switchValue = val;
                              });
                            },
                          ),
                        ],
                      ),
                      buildSizeHeight(30),
                      BaseButton(
                        title: 'Create',
                        btnHeight: 45,
                        leftMargin: 20,
                        rightMargin: 20,
                        onPressed: () {
                          if (coachArchiveCtrl.createPlanFormKey.currentState!
                              .validate()) {
                            coachArchiveCtrl.planCreate(status: _switchValue);
                          }
                        },
                      ),
                      buildSizeHeight(20),
                    ],
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: BaseColors.white,
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(BaseAssets.cancel),
            ),
          ),
        ],
      ),
    );
  }
}
