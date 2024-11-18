
import 'package:fitness_metrics/ui/base_components/base_text.dart';
import 'package:fitness_metrics/ui/coach/clients_athletes/models/client_dashboard_model.dart';
import 'package:fitness_metrics/ui/coach/group_athletes/group_view.dart';
import 'package:fitness_metrics/utils/base_colors.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../group_athletes/controllers/group_view_controller.dart';

class GroupCards extends StatelessWidget {
  final Group groupData;

  const GroupCards({super.key, required this.groupData});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: BaseColors.grey5),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BaseText(
                  value: groupData.name ?? "",
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
                BaseText(
                  value: groupData.athlete ?? "",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: BaseColors.grey3,
                ),
              ],
            ),
          ),
          buildSizeWidth(10),
          InkWell(
            onTap: () {
              Get.put(GroupViewController()).getGroupView(groupId: groupData.id ?? "").then((value) {
                if(value){
                  Get.to(() => GroupView(
                    title: groupData.name ?? "",
                    groupId: groupData.id ?? ""
                  ));
                }
              });
            },
            child: const BaseText(
              value: 'View',
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: BaseColors.black1,
            ),
          ),
        ],
      ),
    );
  }
}
