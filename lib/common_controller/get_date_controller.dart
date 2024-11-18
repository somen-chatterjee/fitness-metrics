import 'dart:developer';

import 'package:fitness_metrics/utils/base_variables.dart';
import 'package:get/get.dart';

class GetDateController extends GetxController{

  Rx<DateTime> focusedDay = (DateTime.now()).obs;

  // Rx<DateTime> selectedDate = (DateTime.now()).obs;

  RxString currentMonth = ''.obs;

  List<int> years = List.generate((DateTime.now().year - 1980) + 1, (index) => 1980 + index);

  RxInt selectedYear = (0).obs;

  void setYear() {
    // log("$index");
    selectedYear.value = DateTime.now().year;
  }

  void getCurrentMonth() {
    currentMonth.value = months[DateTime.now().month - 1];
  }

  void getPreviousMonth(String month) {
    // int currentYear = DateTime.now().year;
    // int currentMonthIndex = DateTime.now().month - 1; // Zero-indexed month (Jan = 0)

    // int selectedYearValue = selectedYear.value;
    int currentIndex = months.indexOf(month);

    if (currentIndex == -1) {
      throw ArgumentError("Invalid month name: $month");
    }

    // Check if the selected year is the current year
    // if (selectedYearValue == currentYear) {
    //   // Prevent going back to a future month
    //   if (currentIndex == 0) {
    //     log("Cannot go earlier than January of the current year.");
    //     return; // Stop further action
    //   }
    // }

    // Proceed to select the previous month
    focusedDay.value = DateTime(
        focusedDay.value.year, focusedDay.value.month - 1, focusedDay.value.day);

    currentMonth.value = months[(currentIndex - 1 + 12) % 12];

    log("getPreviousMonth ${focusedDay.value}");

    selectedYear.value = focusedDay.value.year;
  }


  void getNextMonth(String month) {
    int currentYear = DateTime.now().year;
    int currentMonthIndex = DateTime.now().month - 1; // Since months are zero-indexed

    int selectedYearValue = selectedYear.value;
    int currentIndex = months.indexOf(month);

    if (currentIndex == -1) {
      throw ArgumentError("Invalid month name: $month");
    }

    // Check if selected year is the current year
    if (selectedYearValue == currentYear) {
      // Ensure that the next month can't be selected if it's beyond the current month
      if (currentIndex >= currentMonthIndex) {
        log("Cannot select the next month as it exceeds the current month.");
        return; // Prevent further action
      }
    }

    // Proceed normally if the selected year is less than the current year
    focusedDay.value = DateTime(
        focusedDay.value.year, focusedDay.value.month + 1, focusedDay.value.day);

    currentMonth.value = months[(currentIndex + 1) % 12];
    log("getNextMonth ${focusedDay.value}");

    selectedYear.value = focusedDay.value.year;

  }


  void getCurrentCalender({required int year}) {
    int currentYear = DateTime.now().year;
    int currentMonthIndex = DateTime.now().month - 1; // Zero-indexed month (Jan = 0)

    selectedYear.value = year;

    // Determine the month index from the currentMonth
    int monthIndex = months.indexOf(currentMonth.value);

    if (monthIndex == -1) {
      throw ArgumentError("Invalid current month value: ${currentMonth.value}");
    }

    // Create a new DateTime for the start of the month in the new year
    DateTime newFocusedDay = DateTime(year, monthIndex + 1, focusedDay.value.day);

    // Check if the new year is the current year
    if (year == currentYear) {
      // If the new focused month is beyond the current month
      if (monthIndex > currentMonthIndex) {
        // Set focusedDay to the current date
        focusedDay.value = DateTime.now();
        currentMonth.value = months[DateTime.now().month - 1];
      } else {
        // Ensure focusedDay is within the valid range of the new month
        DateTime lastDayOfMonth = DateTime(year, monthIndex + 2, 0); // Last day of the month
        if (newFocusedDay.isAfter(lastDayOfMonth)) {
          focusedDay.value = lastDayOfMonth;
        } else {
          focusedDay.value = newFocusedDay;
        }
      }
    } else {
      // For years other than the current year, just set focusedDay to the new year and month
      DateTime lastDayOfMonth = DateTime(year, monthIndex + 2, 0); // Last day of the month
      if (newFocusedDay.isAfter(lastDayOfMonth)) {
        focusedDay.value = lastDayOfMonth;
      } else {
        focusedDay.value = newFocusedDay;
      }
    }

    log("getCurrentCalender: selectedYear = $selectedYear, focusedDay = ${focusedDay.value}");
  }


}