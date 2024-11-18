// import 'package:fitness_metrics/ui/base_components/base_text.dart';
// import 'package:fitness_metrics/ui/base_components/base_text_field.dart';
// import 'package:fitness_metrics/ui/coach/profile_coach/controller/profile_coach_controller.dart';
// import 'package:fitness_metrics/utils/base_colors.dart';
// import 'package:fitness_metrics/utils/base_functions.dart';
// import 'package:fitness_metrics/utils/custom_switch.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../controller/coach_preferences_controller.dart';
//
// class LibrarySettingsCards extends StatefulWidget {
//   final int itemIndex;
//
//   const LibrarySettingsCards({super.key, required this.itemIndex});
//
//   @override
//   State<LibrarySettingsCards> createState() => _LibrarySettingsCardsState();
// }
//
// class _LibrarySettingsCardsState extends State<LibrarySettingsCards> {
//   var profileCtrl = Get.find<CoachPreferencesController>();
//   bool _switchValue = true;
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Row(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Expanded(
//               child: BaseText(
//                 value: profileCtrl.trainingList[widget.itemIndex].name ?? "",
//                 fontWeight: FontWeight.w400,
//                 fontSize: 16,
//                 color: BaseColors.black1,
//               ),
//             ),
//             buildSizeWidth(20),
//             CustomSwitch(
//               value: _switchValue,
//               activeColor: BaseColors.green2,
//               onChanged: (bool val) {
//                 setState(() {
//                   _switchValue = val;
//                 });
//               },
//             ),
//             // BaseText(
//             //   value: itemIndex != 0 ? 'Inactive' : 'Active',
//             //   fontWeight: FontWeight.w400,
//             //   fontSize: 14,
//             //   color: itemIndex != 0 ? BaseColors.grey2 : BaseColors.green1,
//             // ),
//           ],
//         ),
//         buildSizeHeight(10),
//         BaseTextField(
//           // controller: dataEditCtrl.nameController,
//           textInputType: TextInputType.name,
//           textCapitalization: TextCapitalization.sentences,
//           labelText: '',
//           hintText: profileCtrl.trainingList[widget.itemIndex].name ?? "",
//           hintTextColor: BaseColors.grey,
//           borderColor: BaseColors.textFilledBorder,
//           fillColor: BaseColors.white,
//           contentPadding:
//               const EdgeInsets.symmetric(horizontal: 16.0, vertical: 17.0),
//           borderRadius: 15,
//           // validator: (val) {
//           //   if (controller.fullName.value.text
//           //       .trim()
//           //       .isEmpty) {
//           //     return "Please Enter Name";
//           //   }
//           //   return null;
//           // },
//         ),
//       ],
//     );
//   }
// }
