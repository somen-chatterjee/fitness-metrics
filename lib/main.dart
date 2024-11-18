import 'package:fitness_metrics/common_controller/common_controller.dart';
import 'package:fitness_metrics/ui/onboardings/splash_screen.dart';
import 'package:fitness_metrics/utils/base_colors.dart';
import 'package:fitness_metrics/utils/base_main_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() {
  runApp(const MyApp());
}

//Build by Somen Chatterjee
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{
      Get.put(CommonController());
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitUp,
      ]);
      await GetStorage.init('MyStorage');
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (FocusManager.instance.primaryFocus!.hasFocus) {
          FocusManager.instance.primaryFocus!.unfocus();
        }
      },
      child: GetMaterialApp(
        title: 'Fitness Metrics',
        debugShowCheckedModeBanner: false,
        builder: (BuildContext context, Widget? child) {
          return BaseMainBuilder(context: context, child: child);
        },
        theme: ThemeData(
          // colorScheme: ColorScheme.fromSeed(seedColor: BaseColors.primaryColor),
          scaffoldBackgroundColor: BaseColors.white2,
          useMaterial3: true,
            fontFamily: 'LeagueSpartan'
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
