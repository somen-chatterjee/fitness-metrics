import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness_metrics/ui/athlete/dashboard/controller/athlete_dash_controller.dart';
import 'package:fitness_metrics/ui/base_components/base_text.dart';
import 'package:fitness_metrics/utils/base_colors.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePageCard extends StatefulWidget {
  const ProfilePageCard({super.key, required this.index});

  final int index;

  @override
  State<ProfilePageCard> createState() => _ProfilePageCardState();
}

class _ProfilePageCardState extends State<ProfilePageCard> {
  var athleteDashCtrl = Get.find<AthleteDashController>();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border:
                        Border.all(color: BaseColors.grey5.withOpacity(0.3)),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: CachedNetworkImage(
                      fit: BoxFit.fill,
                      imageUrl: athleteDashCtrl
                              .bodyCompareList[widget.index].sideImage ??
                          "",
                      errorWidget: (context, url, error) => errorWidget(),
                      // width: 83,
                      // height: 83,
                    ),
                  ),
                ),
              ),
              buildSizeHeight(5),
              const BaseText(
                value: "Side Photo",
                fontWeight: FontWeight.w400,
                fontSize: 12,
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border:
                        Border.all(color: BaseColors.grey5.withOpacity(0.3)),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: CachedNetworkImage(
                      fit: BoxFit.fill,
                      imageUrl: athleteDashCtrl
                              .bodyCompareList[widget.index].frontImage ??
                          "",
                      errorWidget: (context, url, error) => errorWidget(),
                      // width: 83,
                      // height: 83,
                    ),
                  ),
                ),
              ),
              buildSizeHeight(5),
              const BaseText(
                value: "Front Photo",
                fontWeight: FontWeight.w400,
                fontSize: 12,
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border:
                        Border.all(color: BaseColors.grey5.withOpacity(0.3)),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: CachedNetworkImage(
                      fit: BoxFit.fill,
                      imageUrl: athleteDashCtrl
                              .bodyCompareList[widget.index].backImage ??
                          "",
                      errorWidget: (context, url, error) => errorWidget(),
                      // width: 83,
                      // height: 83,
                    ),
                  ),
                ),
              ),
              buildSizeHeight(5),
              const BaseText(
                value: "Back Photo",
                fontWeight: FontWeight.w400,
                fontSize: 12,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
