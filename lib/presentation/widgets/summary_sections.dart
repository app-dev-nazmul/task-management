import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:technical_task/constants/app_size.dart';
import '../../constants/app_constants.dart';
import '../../constants/dummy.dart';
import '../../themes/colors.dart';

class SummarySection extends StatelessWidget {
  const SummarySection({super.key});

  @override
  Widget build(BuildContext context) {
    final summaryData = DummyData.getTaskSummary();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 12.h),
          child: Text(
            AppConstants.summaryTitle,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildSummaryCard(
              context,
              title: AppConstants.assignedTasks,
              count: summaryData['assignedTasks']!,
              color: AppColors.assignedTasksBg,
              borderColor: AppColors.assignedTaskBorderColor,
            ),
            SizedBox(width: 8.r),
            _buildSummaryCard(
              context,
              title: AppConstants.completedTasks,
              count: summaryData['completedTasks']!,
              color: AppColors.completedTasksBg,
              borderColor: AppColors.completedTasksBorderColor,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSummaryCard(
    BuildContext context, {
    required String title,
    required int count,
    required Color color,
    required Color borderColor,
  }) {
    return Container(
      width: 163.5.w,
      height: 83.h,
      padding: EdgeInsets.all(AppSizes.cardPadding.w),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: borderColor, width: 1.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.titleSmall?.copyWith(fontSize: 14),
            textAlign: TextAlign.left,
          ),
          SizedBox(height: 8.h),
          Text(
            count.toString(),
            style: Theme.of(
              context,
            ).textTheme.headlineMedium?.copyWith(fontSize: 24),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
