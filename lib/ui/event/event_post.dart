import 'package:fitness_metrics/ui/base_components/base_app_bar.dart';
import 'package:fitness_metrics/ui/base_components/base_column.dart';
import 'package:fitness_metrics/ui/base_components/base_text.dart';
import 'package:fitness_metrics/utils/base_colors.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:flutter/material.dart';

class EventPost extends StatelessWidget {
  const EventPost({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const BaseAppBar(
            title: 'Event Posted',
            showIcon: false,
          ),
          buildSizeHeight(20),
          BaseColumn(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: BaseColors.grey5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const BaseText(
                      value: 'Event Name',
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: BaseColors.black1,
                    ),
                    buildSizeHeight(10),
                    const BaseText(
                      value: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took. Lorem Ipsu is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took.',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: BaseColors.grey2,
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
