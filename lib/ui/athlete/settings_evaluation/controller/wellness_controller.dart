
import 'package:fitness_metrics/backend/api_end_points.dart';
import 'package:fitness_metrics/backend/base_api_service.dart';
import 'package:fitness_metrics/ui/athlete/settings_evaluation/models/wellness_chart_model.dart';
import 'package:fitness_metrics/utils/base_colors.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:fitness_metrics/utils/base_variables.dart';
import 'package:fitness_metrics/utils/get_storage.dart';
import 'package:fitness_metrics/utils/storage_keys.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class WellnessController extends GetxController {

  var zoomPanBehavior = ZoomPanBehavior(
    enablePinching: true, // Allows pinch zoom
    enablePanning: true, // Allows dragging the chart
    maximumZoomLevel: 0.2,
  );

  RxBool isZoomedOut = false.obs;
  RxBool isZoomedIn = true.obs;

  RxString wellnessItemSelect = 'All'.obs;

  List<Map<String, dynamic>> colorList = [
    {
      'title': 'Sleep',
      'color': BaseColors.green3,
    },
    {
      'title': 'Stress',
      'color': BaseColors.red,
    },
    {
      'title': 'Fatigue',
      'color': BaseColors.yellow,
    },
    {
      'title': 'RPE',
      'color': BaseColors.purple1,
    },
    {
      'title': 'Muscle Soreness',
      'color': BaseColors.purple,
    },
  ];

  // RxString wellnessItemValue = 'All'.obs;

  // List of items in our dropdown menu
  var wellnessItems = [
    'All',
    'Sleep',
    'Stress',
    'Fatigue',
    'RPE',
    'Muscle Soreness',
  ];

  List<SplineData> sleepDataList = [];
  final List<SplineData> stressDataList = [];
  final List<SplineData> fatigueDataList = [];
  final List<SplineData> rpeDataList = [];
  final List<SplineData> sorenessDataList = [];

  List<WellnessData> wellnessDataList = [];

  void wellnessQuestionnaireChart() async {
    var userId = await BaseStorage.read(StorageKeys.userId) ?? "";
    Map<String, dynamic> mapData = {
      "athlete_id": userId.toString(),
      // "month": currentMonth.value,
      // "year": selectedYear.value
    };

    // log("$data");
    BaseApiService()
        .post(apiEndPoint: ApiEndPoints().wellnessQuestionnaireChart, data: mapData)
        .then((value) async {
      if (value?.statusCode == 200) {
        try {
          WellnessChartModel response =
          WellnessChartModel.fromJson(value?.data);
          if (response.status ?? false) {
            // showSnackBar(subtitle: response.message ?? "", isSuccess: true);
            // athleteData.value = response.data?.user ?? User();
            wellnessDataList = response.data ?? [];

            setChartData(wellnessDataList: response.data ?? []);

            // setChartData(chartData: response.data ?? []);
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

  setChartData({required List<WellnessData> wellnessDataList}) {
    sleepDataList.clear();
    stressDataList.clear();
    fatigueDataList.clear();
    sorenessDataList.clear();
    rpeDataList.clear();

    for (var entry in wellnessDataList) {
      // Add the entry if the day matches the required days

        var sleepData = SplineData(dateDDMM1(entry.date.toString()),
            double.parse(entry.sleep.toString()));

        var stressData = SplineData(dateDDMM1(entry.date.toString()),
            double.parse(entry.stress.toString()));

        var fatigueData = SplineData(dateDDMM1(entry.date.toString()),
            double.parse(entry.fatigue.toString()));

        var sorenessData = SplineData(dateDDMM1(entry.date.toString()),
            double.parse(entry.muscleSoreness.toString()));

        var rpeData = SplineData(dateDDMM1(entry.date.toString()),
            double.parse(entry.rpe.toString()));

        sleepDataList.add(sleepData);
        stressDataList.add(stressData);
        fatigueDataList.add(fatigueData);
        sorenessDataList.add(sorenessData);
        rpeDataList.add(rpeData);
        update();
    }
  }
}
