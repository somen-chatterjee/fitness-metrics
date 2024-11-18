import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness_metrics/ui/base_components/base_text.dart';
import 'package:fitness_metrics/ui/coach/athlete_data/athlete_data.dart';
import 'package:fitness_metrics/ui/coach/clients_athletes/models/client_dashboard_model.dart';
import 'package:fitness_metrics/utils/base_assets.dart';
import 'package:fitness_metrics/utils/base_colors.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AthleteCards extends StatelessWidget {
  final Athlete athleteData;

  const AthleteCards({super.key, required this.athleteData});

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
          ClipOval(
            child: SizedBox(
              width: 42,
              height: 42,
              child: (athleteData.image ?? '').isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: athleteData.image ?? "",
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
                  value: athleteData.name ?? "",
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
                BaseText(
                  value: athleteData.mobile ?? "",
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: BaseColors.grey3,
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () =>
                Get.to(() => AthleteData(profileTitle: athleteData.name ?? "", athleteId: athleteData.userId.toString(),)),
            child: const BaseText(
              value: 'View Profile',
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
