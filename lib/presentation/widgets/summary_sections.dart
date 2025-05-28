import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constants/app_constants.dart';
import '../../themes/colors.dart';
import '../provider/task_provider.dart';
class SummarySection extends ConsumerWidget {
  const SummarySection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskList = ref.watch(taskControllerProvider);
    final completedTasksCount = taskList.where((task) => task.status == AppConstants.statusCompletedStor).length;
    final assignedTasksCount = taskList.where((task) => task.status == AppConstants.statusTodoStore).length;

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
              count: assignedTasksCount,
              color: AppColors.assignedTasksBg,
              borderColor: AppColors.assignedTaskBorderColor,
            ),
            SizedBox(width: 8.r),
            _buildSummaryCard(
              context,
              title: AppConstants.completedTasks,
              count: completedTasksCount,
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
      padding: EdgeInsets.all(AppConstants.cardPadding.w),
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
            style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14.sp),
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
