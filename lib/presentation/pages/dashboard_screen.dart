// dashboard_screen.dart
import 'package:flutter/material.dart';
import 'package:technical_task/presentation/widgets/greetings_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:technical_task/presentation/widgets/task_sections.dart';

import '../../generated/assets.dart';
import '../widgets/summary_sections.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            GreetingCard(),
            SizedBox(height: 20.h),
            SummarySection(),
            SizedBox(height: 20.h),
            Expanded(child: TaskSectionPage()),
          ],
        ),
      ),
    );
  }
}