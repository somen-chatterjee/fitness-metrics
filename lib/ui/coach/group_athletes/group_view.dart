import 'package:fitness_metrics/ui/base_components/base_app_bar.dart';
import 'package:fitness_metrics/ui/base_components/base_column.dart';
import 'package:fitness_metrics/ui/base_components/base_text.dart';
import 'package:fitness_metrics/ui/coach/clients_athletes/components/athlete_cards.dart';
import 'package:fitness_metrics/ui/coach/group_athletes/controllers/group_view_controller.dart';
import 'package:fitness_metrics/ui/coach/group_athletes/edit_group.dart';
import 'package:fitness_metrics/utils/base_assets.dart';
import 'package:fitness_metrics/utils/base_colors.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class GroupView extends StatefulWidget {
  final String title;
  final String groupId;

  const GroupView({
    super.key,
    required this.title,
    required this.groupId,
  });

  @override
  State<GroupView> createState() => _GroupViewState();
}

class _GroupViewState extends State<GroupView> {
  var groupViewCtrl = Get.find<GroupViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const BaseAppBar(title: 'Athletes group'),
          buildSizeHeight(15),
          Expanded(
            child: SingleChildScrollView(
              child: BaseColumn(
                children: [
                  buildSizeHeight(10),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      BaseText(
                        value: widget.title,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: BaseColors.black1,
                      ),
                      GestureDetector(
                        onTap: () => Get.to(() => EditGroup(
                              groupId: widget.groupId,
                            )),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(BaseAssets.editNotes),
                            buildSizeWidth(10),
                            const BaseText(
                              value: 'Edit',
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: BaseColors.black1,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  buildSizeHeight(15),
                  Obx(() {
                    return ListView.separated(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: groupViewCtrl.athleteList.length,
                      itemBuilder: (context, index) {
                        return AthleteCards(
                          athleteData: groupViewCtrl.athleteList[index],
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return buildSizeHeight(12);
                      },
                    );
                  }),
                  buildSizeHeight(25),
                  // Align(
                  //   alignment: Alignment.centerRight,
                  //   child: GestureDetector(
                  //     // onTap: () => Get.to(() => const CreateGroup()),
                  //     child: Row(
                  //       mainAxisSize: MainAxisSize.min,
                  //       crossAxisAlignment: CrossAxisAlignment.center,
                  //       children: [
                  //         SvgPicture.asset(BaseAssets.editNotes),
                  //         buildSizeWidth(10),
                  //         const BaseText(
                  //           value: 'Add',
                  //           fontSize: 18,
                  //           fontWeight: FontWeight.w400,
                  //           color: BaseColors.black1,
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // buildSizeHeight(25),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
