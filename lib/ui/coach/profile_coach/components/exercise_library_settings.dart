// import 'package:fitness_metrics/ui/base_components/base_app_bar.dart';
// import 'package:fitness_metrics/ui/base_components/base_button.dart';
// import 'package:fitness_metrics/ui/base_components/base_text.dart';
// import 'package:fitness_metrics/ui/coach/profile_coach/components/small_components/library_settings_cards.dart';
// import 'package:fitness_metrics/ui/coach/profile_coach/controller/profile_coach_controller.dart';
// import 'package:fitness_metrics/utils/base_functions.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class ExerciseLibrarySettings extends StatefulWidget {
//   const ExerciseLibrarySettings({super.key});
//
//   @override
//   State<ExerciseLibrarySettings> createState() =>
//       _ExerciseLibrarySettingsState();
// }
//
// class _ExerciseLibrarySettingsState extends State<ExerciseLibrarySettings> {
//   var profileCtrl = Get.find<ProfileController>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const BaseAppBar(title: 'Warm-Up Settings'),
//           buildSizeHeight(20),
//           const Padding(
//             padding: EdgeInsets.symmetric(horizontal: 14.0),
//             child: BaseText(
//               value: 'Variable',
//               fontWeight: FontWeight.w500,
//               fontSize: 16,
//             ),
//           ),
//           Expanded(
//             child: GridView.builder(
//               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 mainAxisSpacing: 0,
//                 crossAxisSpacing: 25,
//                 childAspectRatio: 1.7,
//               ),
//               shrinkWrap: true,
//               itemCount: profileCtrl.settingsList.length,
//               itemBuilder: (context, index) {
//                 return LibrarySettingsCards(itemIndex: index);
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(
//               horizontal: 14.0,
//               vertical: 20,
//             ),
//             child: BaseButton(
//               title: 'Update',
//               btnHeight: 45,
//               leftMargin: 20,
//               rightMargin: 20,
//               onPressed: () {
//                 Get.back();
//                 Get.back();
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
