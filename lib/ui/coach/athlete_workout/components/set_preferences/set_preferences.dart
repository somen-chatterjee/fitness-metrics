import 'package:fitness_metrics/ui/base_components/base_app_bar.dart';
import 'package:fitness_metrics/ui/coach/profile_coach/components/coach_preferences.dart';
import 'package:flutter/material.dart';

class SetPreferences extends StatelessWidget {
  const SetPreferences({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          BaseAppBar(title: 'Coach Preferences'),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 14.0,
                vertical: 16,
              ),
              child: CoachPreferences(),
            ),
          ),
        ],
      ),
    );
  }
}
