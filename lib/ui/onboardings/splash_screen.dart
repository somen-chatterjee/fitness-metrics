

import 'package:fitness_metrics/ui/athlete/dashboard/athlete_dashboard.dart';
import 'package:fitness_metrics/ui/coach/dashboard/coach_dashboard.dart';
import 'package:fitness_metrics/ui/onboardings/onboarding_01.dart';
import 'package:fitness_metrics/utils/base_assets.dart';
import 'package:fitness_metrics/utils/base_variables.dart';
import 'package:fitness_metrics/utils/check_role_id.dart';
import 'package:fitness_metrics/utils/get_storage.dart';
import 'package:fitness_metrics/utils/storage_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      goToNext();
    });
  }

  void goToNext() {
    Future.delayed(const Duration(milliseconds: 2500), () async {
      String accessToken = await BaseStorage.read(StorageKeys.apiToken) ?? "";
      dynamic roleId = await BaseStorage.read(StorageKeys.roleId) ?? "";

      // log("access token => $accessToken");
      // log("access token => $roleId");

      if (accessToken.isNotEmpty) {
        if(roleId.toString() == CheckRoleId().coach.toString()) {
          Get.offAll(() => const CoachDashboard());
        }else{
          Get.offAll(() => const AthleteDashboard());
          // Get.offAll(() => const AthleteWeight());
        }
      } else {
        Get.to(() => const Onboarding01());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: gradient),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: SvgPicture.asset(
            BaseAssets.splash,
            width: 200,
            height: 122,
          ),
        ),
      ),
    );
  }
}
