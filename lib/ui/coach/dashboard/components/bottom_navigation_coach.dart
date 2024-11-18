import 'package:fitness_metrics/ui/coach/dashboard/controller/coach_dash_controller.dart';
import 'package:fitness_metrics/utils/base_assets.dart';
import 'package:fitness_metrics/utils/base_colors.dart';
import 'package:fitness_metrics/utils/base_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class BottomNavigationCoach extends StatefulWidget {
  const BottomNavigationCoach({super.key});

  @override
  State<BottomNavigationCoach> createState() => _BottomNavigationCoachState();
}

class _BottomNavigationCoachState extends State<BottomNavigationCoach> {
  var coachDashCtrl = Get.find<CoachDashController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 30),
      margin: const EdgeInsets.symmetric(
          vertical: 14, horizontal: horizontalScreenPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
              color: BaseColors.grey4.withOpacity(0.05),
              spreadRadius: 2.0,
              blurRadius: 2.0)
        ],
      ),
      child: Obx(() {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BottomTabs(
              isSelected: coachDashCtrl.selectedIndex.value == 0,
              icon: BaseAssets.profile,
              onPressed: () => coachDashCtrl.selectBody(0),
            ),
            BottomTabs(
              isSelected: coachDashCtrl.selectedIndex.value == 1,
              icon: BaseAssets.gym,
              onPressed: () => coachDashCtrl.selectBody(1),
            ),
            BottomTabs(
              isSelected: coachDashCtrl.selectedIndex.value == 2,
              icon: BaseAssets.list,
              onPressed: () => coachDashCtrl.selectBody(2),
            ),
          ],
        );
      }),
    );
  }
}

class BottomTabs extends StatelessWidget {
  final String icon;
  final bool isSelected;
  final VoidCallback? onPressed;

  const BottomTabs(
      {super.key,
      required this.icon,
      required this.isSelected,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? BaseColors.primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(15),
        ),
        child: SvgPicture.asset(
          icon,
          colorFilter: isSelected
              ? const ColorFilter.mode(Colors.white, BlendMode.srcIn)
              : null,
        ),
      ),
    );
  }
}
