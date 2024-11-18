
import 'package:fitness_metrics/backend/api_end_points.dart';
import 'package:fitness_metrics/backend/base_api_service.dart';
import 'package:fitness_metrics/ui/athlete/settings_evaluation/models/load_chart_model.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:fitness_metrics/utils/base_variables.dart';
import 'package:fitness_metrics/utils/get_storage.dart';
import 'package:fitness_metrics/utils/storage_keys.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LoadManagementController extends GetxController {
  //load management
  RxString loadManageType = 'All'.obs;

  List<String> loadManageList = ['All', 'Total Volume', '1RM Estimation'];

  var zoomPanBehavior = ZoomPanBehavior(
    enablePinching: true, // Allows pinch zoom
    enablePanning: true, // Allows dragging the chart
    maximumZoomLevel: 0.2,
  );

  RxBool isZoomedOut = false.obs;
  RxBool isZoomedIn = true.obs;

  List<SplineData> totalLoadList = [];
  List<SplineData> totalRmList = [];

  List<LoadData> measurementDataList = [];
  RxList<Exercise> measurementExerciseList = <Exercise>[].obs;

  RxString currentMonth = ''.obs;

  List<int> years = [];

  void createYear() {
    List.generate(
        (DateTime.now().year - 1990) + 1, (index) => years.add(1990 + index));
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

    loadChart();
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

    loadChart();
  }

  RxString selectedExercise = ''.obs;

  String exerciseId = '';

  void loadChart() async {
    dynamic userId = await BaseStorage.read(StorageKeys.userId) ?? "";

    Map<String, dynamic> mapData = {
      "athlete_id": userId ?? '',
      "month": currentMonth.value,
      "year": selectedYear.value,
      "exercise_id": exerciseId,
    };

    // log("$data");
    BaseApiService()
        .post(apiEndPoint: ApiEndPoints().loadChart, data: mapData)
        .then((value) async {
      if (value?.statusCode == 200) {
        try {
          LoadChartModel response = LoadChartModel.fromJson(value?.data);
          if (response.status ?? false) {
            // showSnackBar(subtitle: response.message ?? "", isSuccess: true);
            // athleteData.value = response.data?.user ?? User();
            measurementDataList = response.data?.loadData ?? [];
            measurementExerciseList.value = response.data?.exercise ?? [];

            setChartData(measurementDataList: response.data?.loadData ?? []);

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

  setChartData({required List<LoadData> measurementDataList}) {
    totalLoadList.clear();
    totalRmList.clear();

    // Loop through the data to collect required days
    for (var entry in measurementDataList) {
      // Add the entry if the day matches the required days
        var totalLoadData = SplineData(dateDDMM1(entry.date.toString()),
            double.parse(entry.total.toString()));

        var totalRmData = SplineData(dateDDMM1(entry.date.toString()),
            double.parse(entry.rmValue.toString()));

        totalLoadList.add(totalLoadData);
        totalRmList.add(totalRmData);

        update();
    }
  }
}

