import 'package:fitness_metrics/ui/base_components/base_button.dart';
import 'package:fitness_metrics/ui/base_components/base_column.dart';
import 'package:fitness_metrics/ui/base_components/base_text.dart';
import 'package:fitness_metrics/ui/base_components/base_text_field.dart';
import 'package:fitness_metrics/ui/coach/components/coach_dashboard_app_bar.dart';
import 'package:fitness_metrics/utils/base_assets.dart';
import 'package:fitness_metrics/utils/base_colors.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class AddEvent extends StatelessWidget {
  const AddEvent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const CoachDashboardAppBar(),
          buildSizeHeight(2),
          Expanded(
            child: SingleChildScrollView(
              child: BaseColumn(
                children: [
                  buildSizeHeight(20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const BaseText(
                        value: 'Add New Event',
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                      Divider(
                        color: BaseColors.grey5.withOpacity(0.4),
                        height: 5,
                      ),
                    ],
                  ),
                  buildSizeHeight(20),
                  //title
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const BaseText(
                        value: 'Title',
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                      buildSizeHeight(8),
                      const BaseTextField(
                        // controller: dataEditCtrl.nameController,
                        textInputType: TextInputType.name,
                        textCapitalization: TextCapitalization.sentences,
                        labelText: '',
                        hintText: 'Add',
                        hintTextColor: BaseColors.grey,
                        borderColor: BaseColors.textFilledBorder,
                        fillColor: BaseColors.white,
                        contentPadding: EdgeInsets.symmetric(
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
                    ],
                  ),
                  buildSizeHeight(20),
                  //description
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const BaseText(
                        value: 'Description',
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                      buildSizeHeight(8),
                      const BaseTextField(
                        // controller: dataEditCtrl.nameController,
                        textInputType: TextInputType.name,
                        textCapitalization: TextCapitalization.sentences,
                        labelText: '',
                        hintText: '',
                        hintTextColor: BaseColors.grey,
                        borderColor: BaseColors.textFilledBorder,
                        fillColor: BaseColors.white,
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 17.0),
                        borderRadius: 15,
                        maxLine: 2,
                        // validator: (val) {
                        //   if (controller.fullName.value.text
                        //       .trim()
                        //       .isEmpty) {
                        //     return "Please Enter Name";
                        //   }
                        //   return null;
                        // },
                      ),
                    ],
                  ),
                  buildSizeHeight(20),
                  //Recurrence
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const BaseText(
                        value: 'Recurrence',
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                      buildSizeHeight(8),
                      const BaseTextField(
                        // controller: dataEditCtrl.nameController,
                        textInputType: TextInputType.name,
                        textCapitalization: TextCapitalization.sentences,
                        labelText: '',
                        hintText: 'Add',
                        hintTextColor: BaseColors.grey,
                        borderColor: BaseColors.textFilledBorder,
                        fillColor: BaseColors.white,
                        contentPadding: EdgeInsets.symmetric(
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
                    ],
                  ),
                  //date time
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const BaseText(
                              value: 'Date',
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                            buildSizeHeight(8),
                            BaseTextField(
                              // controller: dataEditCtrl.nameController,
                              textInputType: TextInputType.name,
                              textCapitalization: TextCapitalization.sentences,
                              labelText: '',
                              hintText: 'Date',
                              hintTextColor: BaseColors.grey2,
                              borderColor: BaseColors.textFilledBorder,
                              fillColor: BaseColors.white,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 17.0),
                              borderRadius: 15,
                              suffixIcon: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: SvgPicture.asset(BaseAssets.calendar,
                                  width: 20,
                                  colorFilter: const ColorFilter.mode(BaseColors.grey, BlendMode.srcIn),
                                ),
                              ),
                              // validator: (val) {
                              //   if (controller.fullName.value.text
                              //       .trim()
                              //       .isEmpty) {
                              //     return "Please Enter Name";
                              //   }
                              //   return null;
                              // },
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
                              value: 'Time',
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                            buildSizeHeight(8),
                            BaseTextField(
                              // controller: dataEditCtrl.nameController,
                              textInputType: TextInputType.name,
                              textCapitalization: TextCapitalization.sentences,
                              labelText: '',
                              hintText: 'Time',
                              hintTextColor: BaseColors.grey2,
                              borderColor: BaseColors.textFilledBorder,
                              fillColor: BaseColors.white,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 17.0),
                              borderRadius: 15,
                              suffixIcon: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: SvgPicture.asset(BaseAssets.calendar,
                                  width: 20,
                                  colorFilter: const ColorFilter.mode(BaseColors.grey, BlendMode.srcIn),
                                ),
                              ),
                              // validator: (val) {
                              //   if (controller.fullName.value.text
                              //       .trim()
                              //       .isEmpty) {
                              //     return "Please Enter Name";
                              //   }
                              //   return null;
                              // },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  buildSizeHeight(35),
                  BaseButton(
                    title: "Save the event",
                    borderRadius: 15,
                    fontSize: 18,
                    btnColor: BaseColors.primaryColor,
                    leftMargin: 30,
                    rightMargin: 30,
                    onPressed: () => Get.back(),
                  ),
                  buildSizeHeight(35),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
