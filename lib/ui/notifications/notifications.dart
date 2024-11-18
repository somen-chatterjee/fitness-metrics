import 'package:fitness_metrics/common_controller/notification_controller.dart';
import 'package:fitness_metrics/ui/base_components/base_app_bar.dart';
import 'package:fitness_metrics/ui/base_components/base_column.dart';
import 'package:fitness_metrics/ui/base_components/base_text.dart';
import 'package:fitness_metrics/ui/notifications/components/notification_cards.dart';
import 'package:fitness_metrics/utils/base_colors.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:fitness_metrics/utils/base_no_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  late NotificationController notificationCtrl;

  @override
  void initState() {
    super.initState();
    Get.delete<NotificationController>();
    notificationCtrl = Get.put(NotificationController());
    notificationCtrl.getNotificationsList(page: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const BaseAppBar(
            title: 'Notifications',
            showIcon: false,
          ),
          buildSizeHeight(20),
          Expanded(
            child: BaseColumn(
              children: [
                Flexible(
                  child: Obx(() {
                    return SmartRefresher(
                      enablePullUp: notificationCtrl.currentPage !=
                          notificationCtrl.lastPage,
                      controller: notificationCtrl.refreshController,
                      onLoading: () {
                        if (notificationCtrl.currentPage !=
                            notificationCtrl.lastPage) {
                          notificationCtrl.getNotificationsList(
                              page: notificationCtrl.currentPage += 1);
                        }
                      },
                      onRefresh: () {
                        notificationCtrl.getNotificationsList(page: 1);
                      },
                      child: notificationCtrl.notificationDataList.isNotEmpty
                          ? ListView.separated(
                              shrinkWrap: true,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              itemCount:
                                  notificationCtrl.notificationDataList.length,
                              itemBuilder: (context, index) {
                                return NotificationCards(
                                  notificationData: notificationCtrl
                                      .notificationDataList[index],
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Divider(
                                    thickness: 1,
                                    color: BaseColors.primaryColor
                                        .withOpacity(0.2),
                                  ),
                                );
                              },
                            )
                          : const BaseNoData(message: "No Notification Found!"),
                    );
                  }),
                ),
                buildSizeHeight(10),
                if (notificationCtrl.notificationDataList.isNotEmpty)
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        notificationCtrl.showDeleteNotification(
                            context: context);
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12.0),
                        child: BaseText(
                          value: 'Delete all',
                          fontWeight: FontWeight.w400,
                          underline: true,
                          fontSize: 16,
                          color: BaseColors.black1,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
