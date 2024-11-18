
import 'package:fitness_metrics/backend/api_end_points.dart';
import 'package:fitness_metrics/backend/base_api_service.dart';
import 'package:fitness_metrics/ui/coach/subscription/model/subscription_order_model.dart';
import 'package:fitness_metrics/ui/web_view_stack/web_view_stack.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:get/get.dart';

class SubscriptionController extends GetxController {

  void subscriptionOrder({required String amount}) async {

    Map<String, dynamic> mapData = {
      "amount": amount,
    };

    // log("$mapData");
    BaseApiService()
        .post(apiEndPoint: ApiEndPoints().subscriptionOrder, data: mapData)
        .then((value) {
      if (value?.statusCode == 200) {
        try {
          SubscriptionOrderModel response =
            SubscriptionOrderModel.fromJson(value?.data);
          if (response.status ?? false) {
            // Get.back();
            // showSnackBar(subtitle: response.message ?? "", isSuccess: true);
            // athleteData.value = response.data?.user ?? User();
            // chartData = response.data ?? [];
            Get.to(()=>WebViewStack(
              url: response.data?.paymentUrl ?? "",
            ));
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

}