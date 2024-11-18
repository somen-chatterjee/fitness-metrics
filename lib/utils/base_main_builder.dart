
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fitness_metrics/ui/base_components/base_text.dart';
import 'package:fitness_metrics/utils/base_assets.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:lottie/lottie.dart';
import 'package:scaled_app/scaled_app.dart';
import 'base_colors.dart';
import 'customised_grey_error_screen.dart';

class BaseMainBuilder extends StatefulWidget {
  final BuildContext context;
  final Widget? child;

  const BaseMainBuilder(
      {super.key, required this.context, required this.child});

  @override
  State<BaseMainBuilder> createState() => _BaseMainBuilderState();
}

class _BaseMainBuilderState extends State<BaseMainBuilder> with TickerProviderStateMixin{
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {

    });
    controller = AnimationController(
      /// [AnimationController]s can be created with `vsync: this` because of
      /// [TickerProviderStateMixin].
        vsync: this,
        duration: const Duration(seconds: 2)
    )..addListener(() {
      setState(() {});
    });
    controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
      return CustomisedGreyErrorScreen(errorDetails: errorDetails);
    };
    return MediaQuery(
      data: MediaQuery.of(context)
          .copyWith(textScaler: const TextScaler.linear(1.0)),
      child: Column(
        children: [
          Expanded(
            child: LoaderOverlay(
              useDefaultLoading: false,
              overlayColor: Colors.black.withOpacity(0.6),
              overlayWidgetBuilder: (_) {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 80,
                        child: OverflowBox(
                          minHeight: 150,
                          maxHeight: 150,
                          minWidth: 150,
                          maxWidth: 150,
                          child: Lottie.asset(
                              BaseAssets.runningLoaderJson,
                              height: 200,
                              width: 200
                          ),
                        ),
                      ),
                      buildSizeHeight(20),
                      SizedBox(
                        width: 120,
                        child: LinearProgressIndicator(
                          value: controller.value,
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          minHeight: 5,
                          backgroundColor: BaseColors.white.withOpacity(0.32),
                        ),
                      )
                    ],
                  ),
                );
              },
              child: MediaQuery(
                data: MediaQuery.of(context).scale(),
                child: widget.child!,
              ),
            ),
          ),

          StreamBuilder(
            stream: Connectivity().onConnectivityChanged,
            builder: (context, connectivity) {
              return Visibility(
                visible: connectivity.data != null &&
                    connectivity.data![0] != ConnectivityResult.mobile &&
                    connectivity.data![0] != ConnectivityResult.wifi,
                child: SizedBox(
                  height: 20,
                  child: Scaffold(
                    backgroundColor: Colors.red,
                    body: Container(
                      height: 20,
                      color: Colors.red,
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      child: const BaseText(
                        value: "No Connection!",
                        fontSize: 11,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),

          // StreamBuilder(
          //   stream: Connectivity().onConnectivityChanged,
          //   builder: (BuildContext context,AsyncSnapshot<ConnectivityResult> connectivity) {
          //     return Visibility(
          //       visible: connectivity.data != null && connectivity.data != ConnectivityResult.mobile &&
          //           connectivity.data != ConnectivityResult.wifi,
          //       child: SizedBox(
          //         height: 20,
          //         child: Scaffold(
          //           backgroundColor: Colors.red,
          //           body: Visibility(
          //             visible: connectivity.data != ConnectivityResult.mobile &&
          //                 connectivity.data != ConnectivityResult.wifi,
          //             child: Container(
          //               height: 20,
          //               color: (connectivity.data !=
          //                           ConnectivityResult.mobile &&
          //                       connectivity.data != ConnectivityResult.wifi)
          //                   ? Colors.red
          //                   : Colors.green.shade800,
          //               width: MediaQuery.of(context).size.width,
          //               alignment: Alignment.center,
          //               child: const BaseText(
          //                 value: "No Connection!",
          //                 fontSize: 11,
          //                 color: Colors.white,
          //                 fontWeight: FontWeight.w400,
          //               ),
          //             ),
          //           ),
          //         ),
          //       ),
          //     );
          //   },
          // ),
        ],
      ),
    );
  }
}
