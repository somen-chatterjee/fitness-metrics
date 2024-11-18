import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:fitness_metrics/ui/base_components/base_app_bar.dart';
import 'package:fitness_metrics/ui/base_components/base_button.dart';
import 'package:fitness_metrics/ui/base_components/base_column.dart';
import 'package:fitness_metrics/ui/base_components/base_text.dart';
import 'package:fitness_metrics/ui/base_components/base_text_field.dart';
import 'package:fitness_metrics/ui/coach/task_add/controller/task_add_controller.dart';
import 'package:fitness_metrics/utils/base_assets.dart';
import 'package:fitness_metrics/utils/base_colors.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class TaskAdd extends StatefulWidget {
  const TaskAdd({super.key});

  @override
  State<TaskAdd> createState() => _TaskAddState();
}

class _TaskAddState extends State<TaskAdd> {
  var taskAddCtrl = Get.put(TaskAddController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const BaseAppBar(
            title: 'Add Task',
          ),
          buildSizeHeight(2),
          Expanded(
            child: SingleChildScrollView(
              child: Form(
                key: taskAddCtrl.taskFormKey,
                child: BaseColumn(
                  children: [
                    buildSizeHeight(20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            BaseText(
                              value: 'Add Task',
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                            ),
                            // RichText(
                            //   text: const TextSpan(
                            //     children: [
                            //       TextSpan(
                            //         text: '33',
                            //         style: TextStyle(
                            //           fontWeight: FontWeight.w600,
                            //           fontSize: 12,
                            //           color: BaseColors.primaryColor,
                            //         ),
                            //       ),
                            //       TextSpan(
                            //         text: '/45',
                            //         style: TextStyle(
                            //           fontWeight: FontWeight.w400,
                            //           fontSize: 12,
                            //           color: BaseColors.lightBlue,
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                          ],
                        ),
                        Divider(
                          color: BaseColors.grey5.withOpacity(0.4),
                          height: 5,
                        ),
                      ],
                    ),
                    buildSizeHeight(20),
                    //task title
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            BaseText(
                              value: 'Task Name',
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                            // BaseText(
                            //   value: 'Add new',
                            //   fontWeight: FontWeight.w600,
                            //   fontSize: 12,
                            //   color: BaseColors.primaryColor,
                            // ),
                          ],
                        ),
                        buildSizeHeight(8),
                        BaseTextField(
                          controller: taskAddCtrl.taskNameCtrl,
                          textInputType: TextInputType.name,
                          textCapitalization: TextCapitalization.sentences,
                          labelText: '',
                          hintText: 'Add',
                          hintTextColor: BaseColors.grey2,
                          borderColor: BaseColors.textFilledBorder,
                          fillColor: BaseColors.white,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 17.0,
                          ),
                          borderRadius: 15,
                          validator: (val) {
                            if (taskAddCtrl.taskNameCtrl.value.text
                                .trim()
                                .isEmpty) {
                              return "Please Enter Task Name";
                            }
                            return null;
                          },
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
                          value: 'Task Description',
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                        buildSizeHeight(8),
                        BaseTextField(
                          controller: taskAddCtrl.descriptionCtrl,
                          textInputType: TextInputType.name,
                          textCapitalization: TextCapitalization.sentences,
                          labelText: '',
                          hintText:
                              'Manage the athletes\' loads',
                          hintTextColor: BaseColors.grey2,
                          borderColor: BaseColors.textFilledBorder,
                          fillColor: BaseColors.white,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 17.0,
                          ),
                          borderRadius: 15,
                          maxLine: 2,
                          validator: (val) {
                            if (taskAddCtrl.descriptionCtrl.value.text
                                .trim()
                                .isEmpty) {
                              return "Please Enter Task Description";
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                    //date time
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const BaseText(
                                value: 'Days',
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                              buildSizeHeight(8),
                              DropdownButtonHideUnderline(
                                // Select Items
                                child: DropdownButtonFormField2<String>(
                                  decoration: InputDecoration(
                                    labelText: '',
                                    filled: true,
                                    fillColor: BaseColors.white,
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: BaseColors.textFilledBorder),
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: BaseColors.textFilledBorder,
                                      ),
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: BaseColors.red,
                                      ),
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                    enabled: true,
                                    contentPadding: const EdgeInsets.only(
                                        left: 12,
                                        right: 12,
                                        top: 14,
                                        bottom: 14,
                                      ),
                                    border: const OutlineInputBorder(),
                                  ),
                                  iconStyleData: const IconStyleData(
                                    icon: Icon(
                                      Icons.keyboard_arrow_down_outlined,
                                      color: BaseColors.grey3,
                                    ),
                                    iconSize: 22,
                                    iconEnabledColor: BaseColors.black1,
                                    iconDisabledColor: BaseColors.black1,
                                  ),
                                  dropdownStyleData: DropdownStyleData(
                                    maxHeight: 300,
                                    width: 200,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14),
                                      color: Colors.white,
                                    ),
                                    // offset: const Offset(-20, 0),
                                    scrollbarTheme: ScrollbarThemeData(
                                      radius: const Radius.circular(40),
                                      thickness: WidgetStateProperty.all(6),
                                      thumbVisibility:
                                          WidgetStateProperty.all(true),
                                    ),
                                  ),
                                  menuItemStyleData: const MenuItemStyleData(
                                    height: 35,
                                    padding:
                                        EdgeInsets.only(left: 12, right: 12),
                                  ),
                                  isExpanded: true,

                                  hint: const BaseText(
                                    value: 'Day',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: BaseColors.grey2,
                                  ),
                                  items: taskAddCtrl.weekList.map((item) {
                                    return DropdownMenuItem(
                                      value: item,
                                      //disable default onTap to avoid closing menu when selecting an item
                                      enabled: false,
                                      child: StatefulBuilder(
                                        builder: (context, menuSetState) {
                                          final isSelected = taskAddCtrl
                                              .selectedItems
                                              .contains(item);
                                          return InkWell(
                                            onTap: () {
                                              isSelected
                                                  ? taskAddCtrl.selectedItems
                                                      .remove(item)
                                                  : taskAddCtrl.selectedItems
                                                      .add(item);
                                              //This rebuilds the StatefulWidget to update the button's text
                                              setState(() {});
                                              //This rebuilds the dropdownMenu Widget to update the check mark
                                              menuSetState(() {});
                                            },
                                            child: Container(
                                              height: double.infinity,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16.0),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: BaseText(
                                                      value: item,
                                                      fontSize: 14,
                                                      color: BaseColors.black1,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                  buildSizeWidth(10),
                                                  if (isSelected)
                                                    // const Icon(Icons.check_box_outlined),
                                                    SvgPicture.asset(
                                                      BaseAssets.checked,
                                                      height: 16,
                                                      width: 16,
                                                    )
                                                  else
                                                    // const Icon(Icons.check_box_outline_blank),
                                                    SvgPicture.asset(
                                                      BaseAssets.unchecked,
                                                      height: 16,
                                                      width: 16,
                                                    ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  }).toList(),

                                  validator: (value) {
                                    if (value == null) {
                                      return "* Required";
                                    }
                                    return null;
                                  },
                                  //Use last selected item as the current value so if we've limited menu height, it scroll to last item.
                                  value: taskAddCtrl.selectedItems.isEmpty
                                      ? null
                                      : taskAddCtrl.selectedItems.last,
                                  onChanged: (value) {},
                                  selectedItemBuilder: (context) {
                                    return taskAddCtrl.weekList.map(
                                      (item) {
                                        return BaseText(
                                          value: taskAddCtrl.selectedItems
                                              .join(', '),
                                          // style: const TextStyle(
                                          fontSize: 16,
                                          color: BaseColors.black1,
                                          overflow: TextOverflow.ellipsis,
                                          // ),
                                          maxLines: 1,
                                        );
                                      },
                                    ).toList();
                                  },
                                ),
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
                                controller: taskAddCtrl.timeCtrl,
                                textInputType: TextInputType.name,
                                textCapitalization:
                                    TextCapitalization.sentences,
                                labelText: '',
                                hintText: 'Time',
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
                                  if (taskAddCtrl.timeCtrl.value.text
                                      .trim()
                                      .isEmpty) {
                                    return "* Required";
                                  }
                                  return null;
                                },
                                onTap: () {
                                  showBaseTimePicker(
                                      context: context,
                                      initialTime: taskAddCtrl.selectedTimeOfDay)
                                      .then((value) {
                                    if (value != null) {
                                      // dPrint("s ${value.toString()}");
                                      taskAddCtrl.setTime(value);
                                    }
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    buildSizeHeight(60),
                    BaseButton(
                      title: "Create Tasks",
                      borderRadius: 15,
                      fontSize: 18,
                      btnColor: BaseColors.primaryColor,
                      leftMargin: 30,
                      rightMargin: 30,
                      onPressed: () {
                        if (taskAddCtrl.taskFormKey.currentState!.validate()) {
                          taskAddCtrl.addTask();
                        }
                      },
                    ),
                    buildSizeHeight(35),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
