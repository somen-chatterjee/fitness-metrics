import 'package:fitness_metrics/ui/base_components/base_text.dart';
import 'package:fitness_metrics/ui/notifications/notifications.dart';
import 'package:fitness_metrics/utils/base_assets.dart';
import 'package:fitness_metrics/utils/base_colors.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class BaseAppBar extends StatelessWidget {
  final String title;
  final bool? showIcon;
  final bool? showBackIcon;

  const BaseAppBar({
    super.key,
    required this.title,
    this.showIcon,
    this.showBackIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
          color: BaseColors.primaryColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(28),
            bottomRight: Radius.circular(28),
          )),
      child: Stack(
        children: [
          SvgPicture.asset(BaseAssets.ellipse),
          SvgPicture.asset(BaseAssets.ellipse1),
          //main app bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildSizeHeight(38),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () => Get.back(),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Visibility(
                              visible: showBackIcon ?? true,
                              child: SvgPicture.asset(BaseAssets.leftArrow)),
                          buildSizeWidth(10),
                          BaseText(
                            value: title,
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                    if (showIcon ?? true)
                      InkWell(
                        onTap: () {
                          Get.to(() => const Notifications());
                        },
                        child: SvgPicture.asset(
                          BaseAssets.notification,
                          colorFilter: const ColorFilter.mode(
                              Colors.white, BlendMode.srcIn),
                        ),
                      )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
