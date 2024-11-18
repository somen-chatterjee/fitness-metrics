import 'package:fitness_metrics/ui/athlete/dashboard/components/bottom_navigation_athlete.dart';
import 'package:fitness_metrics/ui/athlete/dashboard/controller/athlete_dash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AthleteDashboard extends StatefulWidget {
  const AthleteDashboard({super.key});

  @override
  State<AthleteDashboard> createState() => _AthleteDashboardState();
}

class _AthleteDashboardState extends State<AthleteDashboard> {

  var athleteDashCtrl = Get.put(AthleteDashController());

  @override
  void initState() {
    super.initState();
    athleteDashCtrl.profileDataAthlete();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        bottomNavigationBar: const BottomNavigationAthlete(),
        body: athleteDashCtrl.bodyList[athleteDashCtrl.selectedIndex.value],
      );
    });
  }
}
