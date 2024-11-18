import 'package:fitness_metrics/ui/base_components/base_app_bar.dart';
import 'package:fitness_metrics/ui/base_components/base_button.dart';
import 'package:fitness_metrics/ui/base_components/base_column.dart';
import 'package:fitness_metrics/ui/base_components/base_text.dart';
import 'package:fitness_metrics/ui/base_components/base_text_field.dart';
import 'package:fitness_metrics/ui/coach/group_athletes/components/group_athlete_cards.dart';
import 'package:fitness_metrics/ui/coach/group_athletes/controllers/create_group_controller.dart';
import 'package:fitness_metrics/utils/base_colors.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:fitness_metrics/utils/base_no_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CreateGroup extends StatefulWidget {
  const CreateGroup({super.key});

  @override
  State<CreateGroup> createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  var createGroupCtrl = Get.put(CreateGroupController());

  @override
  void initState() {
    super.initState();
    createGroupCtrl.getAthleteForCoach(page: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          const BaseAppBar(title: 'Create Group'),
          buildSizeHeight(15),
          Expanded(
            child: Form(
              key: createGroupCtrl.createGroupFromKey,
              child: BaseColumn(
                children: [
                  const Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BaseText(
                        value: 'Note: ',
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: BaseColors.grey,
                      ),
                      Flexible(
                        child: BaseText(
                          value:
                              'Select at least three members to create a group.',
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: BaseColors.grey,
                        ),
                      ),
                    ],
                  ),
                  buildSizeHeight(15),
                  // athlete group
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: BaseText(
                      value: 'Group Name',
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: BaseColors.grey,
                    ),
                  ),
                  buildSizeHeight(10),
                  BaseTextField(
                    controller: createGroupCtrl.nameController,
                    textInputType: TextInputType.name,
                    textCapitalization: TextCapitalization.sentences,
                    labelText: '',
                    hintText: 'Group Name',
                    hintTextColor: BaseColors.grey,
                    borderColor: BaseColors.textFilledBorder,
                    fillColor: BaseColors.white,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 17.0,
                    ),
                    borderRadius: 15,
                    validator: (val) {
                      if (createGroupCtrl.nameController.value.text
                          .trim()
                          .isEmpty) {
                        return "Please Enter The Group Name";
                      }
                      return null;
                    },
                  ),
                  buildSizeHeight(15),

                  // athlete list
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: BaseText(
                      value: 'Athletes Select',
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: BaseColors.grey,
                    ),
                  ),
                  buildSizeHeight(15),
                  Expanded(
                    child: Obx(() {
                      return SmartRefresher(
                        enablePullUp: createGroupCtrl.currentPage !=
                            createGroupCtrl.lastPage,
                        controller: createGroupCtrl.refreshController,
                        onLoading: () {
                          if (createGroupCtrl.currentPage !=
                              createGroupCtrl.lastPage) {
                            createGroupCtrl.getAthleteForCoach(
                              page: createGroupCtrl.currentPage += 1,
                            );
                          }
                        },
                        onRefresh: () {
                          createGroupCtrl.getAthleteForCoach(page: 1);
                        },
                        child: createGroupCtrl.athleteList.isNotEmpty
                            ? ListView.separated(
                                padding: const EdgeInsets.only(bottom: 25),
                                // shrinkWrap: true,
                                // physics: const NeverScrollableScrollPhysics(),
                                itemCount: createGroupCtrl.athleteList.length,
                                itemBuilder: (context, index) {
                                  return GroupAthleteCards(
                                    athleteData:
                                        createGroupCtrl.athleteList[index],
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return buildSizeHeight(12);
                                },
                              )
                            : const BaseNoData(
                                message: "No Athlete Found!",
                              ),
                      );
                    }),
                  ),
                  buildSizeHeight(25),
                  Obx(() {
                    return Visibility(
                      visible: createGroupCtrl.idList.length >= 3,
                      child: BaseButton(
                        title: "Create Group",
                        borderRadius: 15,
                        fontSize: 18,
                        btnColor: BaseColors.primaryColor,
                        leftMargin: 30,
                        rightMargin: 30,
                        onPressed: () {
                          // log("sam ${createGroupCtrl.idList}");
                          if (createGroupCtrl.createGroupFromKey.currentState!
                              .validate()) {
                            // if (createGroupCtrl.idList.isEmpty ||
                            //     createGroupCtrl.idList.length < 3) {
                            //   showSnackBar(
                            //       subtitle: "Please select at least three athlete."
                            //   );
                            // } else {
                            createGroupCtrl.athleteCreateGroup();
                            // }
                          }
                          // Get.back();
                        },
                      ),
                    );
                  }),
                  buildSizeHeight(25),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
