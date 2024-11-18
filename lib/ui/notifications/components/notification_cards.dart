import 'package:fitness_metrics/ui/base_components/base_text.dart';
import 'package:fitness_metrics/ui/event/event_post.dart';
import 'package:fitness_metrics/ui/notifications/models/notification_model.dart';
import 'package:fitness_metrics/utils/base_assets.dart';
import 'package:fitness_metrics/utils/base_colors.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class NotificationCards extends StatelessWidget {
  final NotificationData notificationData;

  const NotificationCards({super.key, required this.notificationData});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () => Get.to(() => const EventPost()),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: const BoxDecoration(
              color: BaseColors.yellowGreen,
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              BaseAssets.gym,
              colorFilter: const ColorFilter.mode(
                BaseColors.green,
                BlendMode.srcIn,
              ),
              width: 24,
              height: 24,
            ),
          ),
          buildSizeWidth(12),
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BaseText(
                            value: notificationData.title ?? '',
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: BaseColors.black1,
                          ),
                          const BaseText(
                            value: 'Tap to view new event!',
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                            color: BaseColors.black1,
                          ),
                        ],
                      ),
                    ),
                    BaseText(
                      value: notificationData.time ?? '',
                      fontWeight: FontWeight.w400,
                      fontSize: 13,
                      color: BaseColors.primaryColor,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
