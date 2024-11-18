import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:fitness_metrics/ui/base_components/base_text.dart';
import 'package:fitness_metrics/ui/role/role_screen.dart';
import 'package:fitness_metrics/utils/base_assets.dart';
import 'package:fitness_metrics/utils/base_colors.dart';
import 'package:fitness_metrics/utils/base_variables.dart';
import 'package:fitness_metrics/utils/get_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:url_launcher/url_launcher.dart';

triggerHapticFeedback() {
  if (Platform.isAndroid) {
    HapticFeedback.vibrate();
  } else {
    HapticFeedback.lightImpact();
  }
}

void showBaseLoader({bool? showLoader}) {
  if (showLoader ?? true) {
    Get.context!.loaderOverlay.show();
    Future.delayed(const Duration(seconds: apiTimeOut), () {
      Get.context!.loaderOverlay.hide();
    });
  }
}

void dismissBaseLoader({bool? showLoader}) {
  if (showLoader ?? true) {
    Get.context!.loaderOverlay.hide();
  }
}

showSnackBar(
    {bool? isSuccess,
    String? title,
    String? subtitle,
    BuildContext? context,
    int? duration}) {
  if (Get.isSnackbarOpen) {
    Get.closeAllSnackbars();
  } else {
    Get.snackbar("", "",
        padding:
            const EdgeInsets.only(left: 24, right: 18, top: 24, bottom: 24),
        titleText: Row(
          children: [
            Expanded(
              child: BaseText(
                value: (title ?? "").isEmpty
                    ? (isSuccess ?? false)
                        ? "Success!"
                        : "Error!"
                    : title ?? "",
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            GestureDetector(
              onTap: () {
                triggerHapticFeedback();
                Get.closeCurrentSnackbar();
              },
              child: const Icon(
                Icons.close,
                color: Colors.white,
                size: 20,
              ),
            ),
          ],
        ),
        messageText: BaseText(
          value: subtitle ?? "",
          fontSize: 13,
          color: Colors.white,
          fontWeight: FontWeight.w400,
        ),
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.only(
            right: horizontalScreenPadding,
            left: horizontalScreenPadding,
            top: 18),
        backgroundColor: (isSuccess ?? false)
            ? Colors.green.shade900.withOpacity(0.8)
            : Colors.red.withOpacity(0.8),
        colorText: Colors.white,
        duration: Duration(seconds: duration ?? 2));
  }

  // final snackBar = SnackBar(
  //   elevation: 0,
  //   margin: EdgeInsets.only(right: horizontalScreenPadding, left: ),
  //   behavior: SnackBarBehavior.floating,
  //   backgroundColor: Colors.transparent,
  //   content: AwesomeSnackbarContent(
  //     title: (title??"").isEmpty ? (isSuccess??false) ? "Success!" : "Error!" : title??"",
  //     message: subtitle??"",
  //     contentType: (isSuccess??false) ? ContentType.success : ContentType.failure,
  //   ),
  // );
  //
  // ScaffoldMessenger.of(context??Get.context!)
  //   ..hideCurrentSnackBar()
  //   ..showSnackBar(snackBar);
}

SizedBox buildSizeHeight(double height) {
  return SizedBox(
    height: height,
  );
}

SizedBox buildSizeWidth(double width) {
  return SizedBox(
    width: width,
  );
}

Future<String> showBaseDatePicker(BuildContext context,
    {DateTime? firstDate, DateTime? lastDate}) async {
  FocusManager.instance.primaryFocus?.unfocus();
  DateTime? selectedDate = DateTime.now();
  final DateTime? picked = await showDatePicker(
    barrierDismissible: false,
    context: context,
    initialDate: firstDate ?? selectedDate,
    firstDate: firstDate ?? DateTime(1900),
    // initialEntryMode: DatePickerEntryMode.calendarOnly,
    builder: (context, child) {
      return Theme(
        data: ThemeData.light().copyWith(
          colorScheme: const ColorScheme.light(
            primary: BaseColors.primaryColor,
            onPrimary: Colors.white,
            surface: Colors.white,
            onSurface: BaseColors.primaryColor,
          ),
          dialogBackgroundColor: Colors.white,
        ),
        child: child!,
      );
    },
    lastDate: lastDate ?? DateTime(2100),
  );
  if (picked != null && picked != selectedDate) {
    selectedDate = picked;
    // log("selected date $picked");

    return picked.toString();
    // return "${picked.year.toString().padLeft(2, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
    // return "${picked.day.toString().padLeft(2, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.year.toString().padLeft(2, '0')}";
  } else {
    return "";
  }
}

Future<TimeOfDay?> showBaseTimePicker(
    {required BuildContext context, TimeOfDay? initialTime}) {
  Future<TimeOfDay?> selectedTime = showTimePicker(
    initialTime: initialTime ?? TimeOfDay.now(),
    context: context,
    builder: (context, child) {
      return MediaQuery(
        data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
        child: child!,
      );
      // return Theme(
      //   data: ThemeData.light().copyWith(
      //     colorScheme: const ColorScheme.light(
      //       primary: BaseColors.primaryColor,
      //       secondary: BaseColors.secondaryColor,
      //       onPrimary: Colors.white,
      //       surface: Colors.white,
      //       onSurface: BaseColors.primaryColor,
      //     ),
      //     dialogBackgroundColor: Colors.white,
      //   ),
      //   child: child!,
      // );
    },
  );
  return selectedTime;
}

String formatTimeOfDay(TimeOfDay time) {
  final now = DateTime.now();
  final dateTime =
      DateTime(now.year, now.month, now.day, time.hour, time.minute);
  return DateFormat('hh:mm a').format(dateTime);
}

String convertTo12HourFormat(String time24Hour) {
  if (time24Hour.isEmpty) {
    return "";
  }
  DateTime dateTime = DateFormat("HH:mm:ss").parse(time24Hour);
  String formattedTime = DateFormat("h:mm a").format(dateTime);
  return formattedTime;
}

void clearSessionData() async {
  triggerHapticFeedback();
  // if (await GoogleSignIn().isSignedIn()) {
  //   await GoogleSignIn().signOut();
  // }
  BaseStorage.box.erase();
  // getFcmToken();
  Get.offAll(() => const RoleScreen());
}

const String parsingError =
    "Some Error occurred while parsing data, Please try again later.";

String dateYYMMDD(String date) {
  var parsedDate = DateTime.parse(date);
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  return formatter.format(parsedDate);
}

String dateDDMMYY(String date) {
  if(date.isEmpty){
    return '';
  }
  var parsedDate = DateTime.parse(date);
  final DateFormat formatter = DateFormat('dd/MM/yyyy');
  return formatter.format(parsedDate);
}

String dateDDMM(String date) {
  // "1 August"
  // Parse the string into a DateTime object
  DateTime parsedDate = DateTime.parse(date);

  // Format the DateTime object to the desired format
  return DateFormat('d MMMM').format(parsedDate);
}

String dateDDMM1(String date) {
  // "1 Aug"
  // Parse the string into a DateTime object
  DateTime parsedDate = DateTime.parse(date);

  // Format the DateTime object to the desired format
  return DateFormat('d MMM').format(parsedDate);
}

DateTime dateTimeDMMM(String inputDate) {
  // Input date as a string

  // Define the date format
  DateFormat dateFormat = DateFormat("d MMM");

  // Parse the input date string to a DateTime object
  DateTime parsedDate = dateFormat.parse(inputDate);

  // Display the parsed date (Year will default to 1970 as year is not provided)
  // print(parsedDate);

  // If you need to assign a specific year, you can do so like this:
  DateTime finalDate =
      DateTime(DateTime.now().year, parsedDate.month, parsedDate.day);
  // print(finalDate);

  return finalDate;
}

DateTime changeToDateTime({required String dateString}) {
  DateFormat dateFormat = DateFormat("dd/MM/yyyy");
  DateTime dateTime = dateFormat.parse(dateString);
  // dPrint("${dateTime}");
  return dateTime;
}

int daysInMonth(DateTime date) {
  var firstDayThisMonth = DateTime(date.year, date.month, date.day);
  var firstDayNextMonth = DateTime(firstDayThisMonth.year,
      firstDayThisMonth.month + 1, firstDayThisMonth.day);
  return firstDayNextMonth.difference(firstDayThisMonth).inDays;
}

TimeOfDay stringToTimeOfDay(String time) {
  // Split the string by colon
  List<String> parts = time.split(':');

  // Convert parts to int (hours, minutes)
  int hour = int.parse(parts[0]);
  int minute = int.parse(parts[1]);

  // Return TimeOfDay object
  return TimeOfDay(hour: hour, minute: minute);
}

Future<File?> showMediaPicker({bool? isCropEnabled}) async {
  FocusManager.instance.primaryFocus?.unfocus();
  XFile? pickedFile = XFile("");
  await Get.bottomSheet(
    Container(
      alignment: Alignment.center,
      height: 150,
      margin: const EdgeInsets.symmetric(
          horizontal: horizontalScreenPadding,
          vertical: horizontalScreenPadding),
      padding: const EdgeInsets.only(
          top: 5,
          right: horizontalScreenPadding,
          left: horizontalScreenPadding),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          Container(
            width: 100,
            height: 4,
            decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(30)),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () async {
                    await chooseCameraFile(isCropEnabled).then((value) {
                      if (value != null) {
                        pickedFile = XFile(value.path);
                      }
                      if (Get.isBottomSheetOpen ?? false) {
                        Get.back();
                      }
                    });
                    // await ImagePicker().pickImage(source: ImageSource.camera).then((value) {
                    //   pickedFile = value;
                    //   if (Get.isBottomSheetOpen??false) {
                    //     Get.back();
                    //   }
                    // });
                  },
                  child: const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.camera_alt_outlined,
                          color: BaseColors.secondaryColor, size: 60),
                      BaseText(
                        topMargin: 10,
                        value: "Camera",
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () async {
                    await chooseGalleryFile(isCropEnabled).then((value) {
                      if (value != null) {
                        pickedFile = XFile(value.path);
                      }
                      if (Get.isBottomSheetOpen ?? false) {
                        Get.back();
                      }
                    });
                    // await ImagePicker().pickImage(source: ImageSource.gallery).then((value) {
                    //   pickedFile = value;
                    //   if (Get.isBottomSheetOpen??false) {
                    //     Get.back();
                    //   }
                    // });
                  },
                  child: const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.photo_library_outlined,
                          color: BaseColors.secondaryColor, size: 60),
                      BaseText(
                        topMargin: 10,
                        value: "Gallery",
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ),
    backgroundColor: Colors.transparent,
  );
  return File(pickedFile?.path ?? "");
}

Future<File?> chooseCameraFile(bool? isCropEnabled) async {
  final imgPicker = ImagePicker();
  File? files;
  dynamic choosenFile;
  await imgPicker.pickImage(source: ImageSource.camera).then((value) async {
    if (value != null) {
      if (isCropEnabled ?? false) {
        choosenFile = await cropImage(
          File(value.path),
        );
      } else {
        choosenFile = File(value.path);
      }
    }
  });
  if (choosenFile != null) {
    files = File(choosenFile?.path ?? "");
  }
  return files;
}

Future<File?> chooseGalleryFile(bool? isCropEnabled) async {
  final imgPicker = ImagePicker();
  File? files;
  dynamic chooseFile;
  await imgPicker.pickImage(source: ImageSource.gallery).then((value) async {
    if (value != null) {
      if (isCropEnabled ?? false) {
        chooseFile = await cropImage(
          File(value.path),
        );
      } else {
        chooseFile = File(value.path);
      }
    }
  });
  if (chooseFile != null) {
    files = File(chooseFile?.path ?? "");
  }
  return files;
}

Future<CroppedFile?> cropImage(File imageFile) async {
  CroppedFile? croppedFile;
  await ImageCropper().cropImage(
    sourcePath: imageFile.path,
    // aspectRatioPresets: [CropAspectRatioPreset.square],
    aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
    uiSettings: [
      AndroidUiSettings(
        toolbarTitle: 'Cropper',
        activeControlsWidgetColor: Colors.black,
        toolbarColor: CupertinoColors.white,
        toolbarWidgetColor: Colors.black,
        initAspectRatio: CropAspectRatioPreset.original,
        lockAspectRatio: true,
        aspectRatioPresets: [
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.square,
        ],
      ),
      IOSUiSettings(
        title: 'Cropper',
        rotateButtonsHidden: true,
        aspectRatioLockEnabled: true,
        aspectRatioPresets: [
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.square,
        ],
      ),
    ],
  ).then((value) {
    croppedFile = value;
  });
  return croppedFile;
}

Future<File?> pickAndUploadFile(
    {required List<String> allowExtensionsList}) async {
  var result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: allowExtensionsList,
    // allowedExtensions: ['mp4', 'mov', 'pdf','jpg'],
  );

  if (result != null) {
    return File(result.files.single.path!);
  }

  return null;

  // if (result != null) {
  //   File selectedFile = File(result.files.single.path!);
  //   int sizeInBytes = selectedFile.lengthSync();
  //   double sizeInMb = sizeInBytes / (1024 * 1024);
  //   if (sizeInMb > 15) {
  //     showToastError('File should be less than 15Mb.');
  //   } else {
  //     showLoader(true);
  //     await uploadfiles(
  //         photos: [selectedFile], fileUploadingProgress: fileUploadingProgress)
  //         .then((value) {
  //       showLoader(false);
  //       if (value.data != null) {
  //         onSendMessage(
  //             '', '${value.data?.type}', message_file: value.data?.image);
  //       } else {
  //         showToastError('${value.message}'); // popup
  //       }
  //     });
  //   }
  // }
}

void urlLaunch({required String url}) async {
  try {
    await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  } catch (e) {
    log("message $e");
    showSnackBar(subtitle: "Failed to launch URL");
  }
}

Widget errorWidget() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 30),
    child: SvgPicture.asset(
      BaseAssets.noImage,
    ),
  );
}

String getGreetingMessage() {
  var hour = DateTime.now().hour;

  if (hour < 12) {
    return 'Hello, Good Morning';
  } else if (hour < 17) {
    return 'Hello, Good Afternoon';
  } else if (hour < 21) {
    return 'Hello, Good Evening';
  } else {
    return 'Hello, Good Night';
  }
}

