import 'package:fitness_metrics/ui/base_components/base_button.dart';
import 'package:fitness_metrics/ui/base_components/base_column.dart';
import 'package:fitness_metrics/ui/base_components/base_text.dart';
import 'package:fitness_metrics/ui/coach/subscription/controller/subscription_controller.dart';
import 'package:fitness_metrics/utils/base_assets.dart';
import 'package:fitness_metrics/utils/base_colors.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class Subscription extends StatefulWidget {
  const Subscription({super.key});

  @override
  State<Subscription> createState() => _SubscriptionState();
}

class _SubscriptionState extends State<Subscription> {
  var subscriptionCtrl = Get.put(SubscriptionController());

  final List<String> _list = [
    '24/7 Gym Access',
    'Early Access to all workout plan',
    'Access to Challenges',
    'Early Access to all Events',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Image.asset(
            BaseAssets.boardingImage1,
            width: double.maxFinite,
            height: double.maxFinite,
            fit: BoxFit.cover,
          ),
          Container(
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomRight,
                colors: [
                  BaseColors.gradient1.withOpacity(0.4),
                  BaseColors.black,
                ],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.transparent,
                        BaseColors.black.withOpacity(0.8),
                        BaseColors.black.withOpacity(0.9),
                        BaseColors.black,
                      ],
                    ),
                  ),
                  child: BaseColumn(
                    leftPadding: 35,
                    rightPadding: 35,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const BaseText(
                        value: "Subscription",
                        color: Colors.white,
                        fontSize: 38,
                        textAlign: TextAlign.center,
                        fontWeight: FontWeight.w600,
                      ),
                      buildSizeHeight(12),
                      Column(
                        children: List.generate(
                          _list.length,
                          (index) {
                            return Column(
                              children: [
                                Row(
                                  children: [
                                    SvgPicture.asset(BaseAssets.rightTick),
                                    buildSizeWidth(15),
                                    BaseText(
                                      value: _list[index],
                                      color: Colors.white,
                                      fontSize: 16,
                                      textAlign: TextAlign.center,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ],
                                ),
                                buildSizeHeight(8),
                              ],
                            );
                          },
                        ),
                      ),
                      buildSizeHeight(22),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(
                            color: BaseColors.white.withOpacity(.4),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const BaseText(
                                  value: 'One Time',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: BaseColors.white,
                                ),
                                const BaseText(
                                  value: '\$200.00',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 26,
                                  color: BaseColors.white,
                                ),
                                buildSizeHeight(5),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 2.0),
                                  decoration: BoxDecoration(
                                    color: BaseColors.white.withOpacity(0.14),
                                    borderRadius: BorderRadius.circular(36),
                                  ),
                                  child: const BaseText(
                                    value: 'Save \$40.00',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                    color: BaseColors.white,
                                  ),
                                ),
                                buildSizeHeight(14),
                                const BaseText(
                                  value: 'Free 3 days Trial',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: BaseColors.white,
                                ),
                              ],
                            ),
                            buildSizeWidth(20),
                            const Flexible(
                              child: BaseText(
                                value:
                                    'Perfect for beginners and those returning to training',
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: BaseColors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      buildSizeHeight(28),
                      BaseButton(
                        title: 'Subscribe',
                        btnColor: BaseColors.black,
                        btnTextColor: BaseColors.yellowGreen,
                        btnFontWeight: FontWeight.w600,
                        fontSize: 16,
                        borderColor: BaseColors.yellowGreen,
                        borderEnable: true,
                        onPressed: () => subscriptionCtrl.subscriptionOrder(amount: "200"),
                        borderRadius: 15,
                      ),
                      buildSizeHeight(30),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
