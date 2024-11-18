import 'dart:developer';

import 'package:fitness_metrics/backend/api_end_points.dart';
import 'package:fitness_metrics/backend/base_api_service.dart';
import 'package:fitness_metrics/ui/athlete/settings_evaluation/models/measurement_chart_model.dart';
import 'package:fitness_metrics/ui/coach/athlete_data/controller/athlete_data_controller.dart';
import 'package:fitness_metrics/utils/base_colors.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:fitness_metrics/utils/base_variables.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AthleteMeasurementController extends GetxController {

  var zoomPanBehavior = ZoomPanBehavior(
    enablePinching: true, // Allows pinch zoom
    enablePanning: true,  // Allows dragging the chart
    maximumZoomLevel: 0.2,
  );

  RxBool isZoomedOut = false.obs;
  RxBool isZoomedIn = true.obs;

  RxString measurementSelect = 'All'.obs;

  // List of items in our dropdown menu
  var measurementItems = [
    'All',
    'Arm',
    'Chest',
    'Thigh',
    'Hips',
    'Abs',
    'Calves',
  ];

  List<Map<String, dynamic>> measurementColorList = [
    {
      'title': 'Arm',
      'color': BaseColors.green3,
    },
    {
      'title': 'Chest',
      'color': BaseColors.red,
    },
    {
      'title': 'Thigh',
      'color': BaseColors.yellow,
    },
    {
      'title': 'Hips',
      'color': BaseColors.purple,
    },
    {
      'title': 'Abs',
      'color': BaseColors.purple1,
    },
    {
      'title': 'Calves',
      'color': BaseColors.sky,
    },
  ];

  RxString currentMonth = ''.obs;

  List<int> years = [];
  void createYear() {
    List.generate((DateTime.now().year - 1980) + 1, (index) => years.add(1980 + index));
  }
  RxInt selectedYear = (0).obs;
  void setYear() {
    selectedYear.value = DateTime.now().year;
  }

  void getCurrentMonth() {
    currentMonth.value = months[DateTime.now().month - 1];
  }

  void getPreviousMonth(String month) {
    int currentIndex = months.indexOf(month);

    if (currentIndex == -1) {
      throw ArgumentError("Invalid month name: $month");
    }

    if (currentIndex == 0) {
      return;
    }

    currentMonth.value = months[(currentIndex - 1 + 12) % 12];

    measurementChart();
  }

  void getNextMonth(String month) {
    int currentIndex = months.indexOf(month);
    int currentMonthIndex =
        DateTime.now().month - 1; // Since months are zero-indexed

    if (currentIndex == -1) {
      throw ArgumentError("Invalid month name: $month");
    }

    if (currentIndex >= currentMonthIndex) {
      return;
    }

    currentMonth.value = months[(currentIndex + 1) % 12];

    measurementChart();
  }

  List<SplineData> armDataList = [];
  final List<SplineData> chestDataList = [];
  final List<SplineData> thighDataList = [];
  final List<SplineData> hipsDataList = [];
  final List<SplineData> absDataList = [];
  final List<SplineData> calvesDataList = [];

  List<MeasurementData> measurementDataList = [];

  void measurementChart() async {
    var ctrl = Get.find<AthleteDataController>();

    Map<String, dynamic> mapData = {
      "athlete_id": ctrl.athleteData.value.userId ?? "",
      "month": currentMonth.value,
      "year": selectedYear.value
    };

    // log("$data");
    BaseApiService()
        .post(apiEndPoint: ApiEndPoints().measurementChart, data: mapData)
        .then((value) async {
      if (value?.statusCode == 200) {
        try {
          MeasurementChartModel response =
              MeasurementChartModel.fromJson(value?.data);
          if (response.status ?? false) {
            // showSnackBar(subtitle: response.message ?? "", isSuccess: true);
            // athleteData.value = response.data?.user ?? User();
            measurementDataList = response.data ?? [];

            setChartData(measurementDataList: response.data ?? []);

          } else {
            showSnackBar(subtitle: response.message ?? "");
          }
        } catch (e) {
          log("parsingError $e");
          showSnackBar(subtitle: parsingError);
        }
      } else {
        showSnackBar(subtitle: "Something went wrong, please try again");
      }
    });
  }

  setChartData({required List<MeasurementData> measurementDataList}) {
    armDataList.clear();
    chestDataList.clear();
    thighDataList.clear();
    hipsDataList.clear();
    absDataList.clear();
    calvesDataList.clear();

    // Loop through the data to collect required days
    for (var entry in measurementDataList) {

        var armData = SplineData(dateDDMM1(entry.date.toString()),
            double.parse(entry.armLight.toString()));

        var chestData = SplineData(dateDDMM1(entry.date.toString()),
            double.parse(entry.chest.toString()));

        var thighData = SplineData(dateDDMM1(entry.date.toString()),
            double.parse(entry.thighLight.toString()));

        var hipsData = SplineData(dateDDMM1(entry.date.toString()),
            double.parse(entry.hips1.toString()));

        var absData = SplineData(dateDDMM1(entry.date.toString()),
            double.parse(entry.abs.toString()));

        var calvesData = SplineData(dateDDMM1(entry.date.toString()),
            double.parse(entry.calves.toString()));

        armDataList.add(armData);
        chestDataList.add(chestData);
        thighDataList.add(thighData);
        hipsDataList.add(hipsData);
        absDataList.add(absData);
        calvesDataList.add(calvesData);
        update();
    }
  }

}
