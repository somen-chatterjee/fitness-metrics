import 'package:fitness_metrics/ui/coach/dashboard/components/bottom_navigation_coach.dart';
import 'package:fitness_metrics/ui/coach/dashboard/controller/coach_dash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CoachDashboard extends StatefulWidget {
  const CoachDashboard({super.key});

  @override
  State<CoachDashboard> createState() => _CoachDashboardState();
}

class _CoachDashboardState extends State<CoachDashboard> {
  var coachDashCtrl = Get.put(CoachDashController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      coachDashCtrl.profileDataCoach();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        bottomNavigationBar: const BottomNavigationCoach(),
        body: coachDashCtrl.bodyList[coachDashCtrl.selectedIndex.value],
      );
    });
  }
}
