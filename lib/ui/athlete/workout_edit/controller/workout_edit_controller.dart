
import 'package:fitness_metrics/backend/api_end_points.dart';
import 'package:fitness_metrics/backend/base_api_service.dart';
import 'package:fitness_metrics/ui/athlete/workout_edit/models/chart_data_model.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:fitness_metrics/utils/base_variables.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class WorkoutEditController extends GetxController {

  var zoomPanBehavior = ZoomPanBehavior(
    enablePinching: true, // Allows pinch zoom
    enablePanning: true, // Allows dragging the chart
    maximumZoomLevel: 0.2,
  );

  RxBool isZoomedOut = false.obs;
  RxBool isZoomedIn = true.obs;

  List<SplineData> weightDataList = [];

  List<ChartData> chartData = [];

  RxString selectedMonth = 'All'.obs;

  void athleteDetailsChart() async {
    Map<String, dynamic> mapData = {
      "month": selectedMonth.value != 'All' ? selectedMonth.value : '',
    };

    // log("$data");
    BaseApiService()
        .post(apiEndPoint: ApiEndPoints().athleteDetailsChart, data: mapData)
        .then((value) {
      if (value?.statusCode == 200) {
        try {
          ChartDataModel response = ChartDataModel.fromJson(value?.data);
          if (response.status ?? false) {
            // showSnackBar(subtitle: response.message ?? "", isSuccess: true);
            // athleteData.value = response.data?.user ?? User();
            chartData = response.data ?? [];
            setChartData(chartDataList: response.data ?? []);
            // update();
          } else {
            showSnackBar(subtitle: response.message ?? "");
          }
        } catch (e) {
          // log("parsingError $e");
          showSnackBar(subtitle: parsingError);
        }
      } else {
        showSnackBar(subtitle: "Something went wrong, please try again");
      }
    });
  }

  setChartData({required List<ChartData> chartDataList}) {
    weightDataList.clear(); // Clear previous data

    // Loop through all entries and add them to the chart data
    for (var entry in chartDataList) {
      // Check if the entry has a valid weight and date
      if (entry.date != null) {
        // DateTime date = DateTime.parse(entry.date ?? '');

        // Add the entry to the chart data
        var weightData = SplineData(
          dateDDMM1(entry.date.toString()), // Format the date for display
          double.parse(entry.weight ?? "0.0"), // Convert weight to double
        );

        weightDataList.add(weightData);
      }
    }

    update(); // Trigger UI update
  }

  String showDifference({required int currentIndex}) {
    if (currentIndex > 0) {
      var currentData = double.parse(chartData[currentIndex].weight ?? '0');
      var previousData =
          double.parse(chartData[currentIndex - 1].weight ?? '0');
      var difference = currentData - previousData;
      if (previousData > 0) {
        double percentage = (difference / previousData) * 100;

        if (difference > 0) {
          return "       ↑${percentage.toStringAsFixed(2)}%";
        } else if (difference < 0) {
          return "       ↓${percentage.abs().toStringAsFixed(2)}%";
        }
      } else {
        return "";
      }
      return "";
    } else {
      return "";
    }
  }



}
