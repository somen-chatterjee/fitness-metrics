import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness_metrics/ui/base_components/base_text.dart';
import 'package:fitness_metrics/ui/coach/clients_athletes/models/client_dashboard_model.dart';
import 'package:fitness_metrics/ui/coach/group_athletes/controllers/create_group_controller.dart';
import 'package:fitness_metrics/utils/base_assets.dart';
import 'package:fitness_metrics/utils/base_colors.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class GroupAthleteCards extends StatefulWidget {
  final Athlete athleteData;

  const GroupAthleteCards({super.key, required this.athleteData});

  @override
  State<GroupAthleteCards> createState() => _GroupAthleteCardsState();
}

class _GroupAthleteCardsState extends State<GroupAthleteCards> {
  final createGroupCtrl = Get.find<CreateGroupController>();

  @override
  Widget build(BuildContext context) {
    var checkWidthHeight = 20.0;
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
          ClipOval(
            child: SizedBox(
              width: 42,
              height: 42,
              child: (widget.athleteData.image ?? '').isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: widget.athleteData.image ?? "",
                      fit: BoxFit.fill,
                    )
                  : Image.asset(BaseAssets.athleteProfile),
            ),
          ),
          buildSizeWidth(10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BaseText(
                  value: widget.athleteData.name ?? "",
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
                BaseText(
                  value: widget.athleteData.mobile ?? "",
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: BaseColors.grey3,
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                widget.athleteData.isSelected = !widget.athleteData.isSelected!;
                // if(createGroupCtrl.idList.contains(widget.athleteData.userId ?? 0)) {
                  if (widget.athleteData.isSelected!) {
                    createGroupCtrl.idList.add(widget.athleteData.userId ?? 0);
                  } else {
                    createGroupCtrl.idList.remove(widget.athleteData.userId ?? 0);
                  }
                // }
              });
            },
            child: Container(
              width: checkWidthHeight,
              height: checkWidthHeight,
              alignment: Alignment.center,
              child: widget.athleteData.isSelected!
                  ? SvgPicture.asset(BaseAssets.checked)
                  : SvgPicture.asset(BaseAssets.unchecked),
            ),
          ),
        ],
      ),
    );
  }
}
