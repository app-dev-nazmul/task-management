import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/app_constants.dart';
import '../../generated/assets.dart';
import '../../themes/colors.dart';
import '../provider/task_provider.dart';

class CreateTaskScreen extends ConsumerStatefulWidget {
  const CreateTaskScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends ConsumerState<CreateTaskScreen> {
  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController taskDescController = TextEditingController();
  DateTime? startDate;
  DateTime? endDate;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    startDate = DateTime.now();
    endDate = DateTime.now();
  }

  @override
  void dispose() {
    taskNameController.dispose();
    taskDescController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStartDate
          ? (startDate ?? DateTime.now())
          : (endDate ?? DateTime.now()),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        if (isStartDate) {
          startDate = picked;
        } else {
          endDate = picked;
        }
      });
    }
  }

  String formatDate(DateTime? date) {
    return date != null
        ? DateFormat(AppConstants.dateFormat).format(date)
        : AppConstants.emptyString;
  }

  Future<void> _createTask() async {
    if (!_validateInputs()) return;

    setState(() => isLoading = true);

    try {
      await ref.read(taskControllerProvider.notifier).createTask(
        title: taskNameController.text.trim(),
        description: taskDescController.text.trim(),
        startDate: formatDate(startDate),
        endDate: formatDate(endDate),
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text(AppConstants.taskCreatedSuccess)),
        );
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  bool _validateInputs() {
    if (taskNameController.text.trim().isEmpty) {
      _showErrorSnackBar(AppConstants.taskNameRequired);
      return false;
    }
    if (taskDescController.text.trim().isEmpty) {
      _showErrorSnackBar(AppConstants.taskDescriptionRequired);
      return false;
    }
    if (taskDescController.text.length > AppConstants.maxDescriptionLength) {
      _showErrorSnackBar(AppConstants.descriptionTooLong);
      return false;
    }
    if (startDate == null || endDate == null) {
      _showErrorSnackBar(AppConstants.datesRequired);
      return false;
    }
    if (endDate!.isBefore(startDate!)) {
      _showErrorSnackBar(AppConstants.invalidDateRange);
      return false;
    }
    return true;
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text(
          AppConstants.createTaskTitle,
          style: TextStyle(fontSize: 16.sp),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        height: 466.h,
        padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 20.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTaskNameField(),
            SizedBox(height: 12.h),
            _buildTaskDescriptionField(),
            SizedBox(height: 8.h),
            _buildCharacterCount(),
            SizedBox(height: 12.h),
            _buildDateSelectionRow(),
            SizedBox(height: 32.h),
            _buildCreateTaskButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppConstants.taskNameLabel,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
        ),
        SizedBox(height: 10.h),
        TextField(
          controller: taskNameController,
          decoration: InputDecoration(
            hintText: AppConstants.taskNameHint,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.r),
              borderSide: BorderSide(color: Colors.grey, width: 2.0.w),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.r),
              borderSide: BorderSide(color: Colors.grey, width: 2.0.w),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTaskDescriptionField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppConstants.taskDescriptionLabel,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
        ),
        SizedBox(height: 10.h),
        SizedBox(
          height: 109.h,
          child: TextField(
            controller: taskDescController,
            maxLines: AppConstants.maxDescriptionLines,
            onChanged: (value) => setState(() {}), // Update character count
            decoration: InputDecoration(
              hintText: AppConstants.taskDescriptionHint,
              hintStyle: TextStyle(
                color: const Color(0xFF6E7591),
                fontSize: 12.sp,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.r),
              ),
              counterText: AppConstants.emptyString, // Hide default counter
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCharacterCount() {
    final characterCount = taskDescController.text.length;
    final isValid = characterCount <= AppConstants.maxDescriptionLength;

    return Align(
      alignment: Alignment.bottomRight,
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: '$characterCount',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 10.sp,
                color: isValid ? AppColors.primary : Colors.red,
              ),
            ),
            TextSpan(
              text: '/${AppConstants.maxDescriptionLength}',
              style: TextStyle(
                fontSize: 10.sp,
                color: AppColors.disableTextColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateSelectionRow() {
    return Row(
      children: [
        Expanded(child: _buildDateField(true)),
        SizedBox(width: 12.w),
        Expanded(child: _buildDateField(false)),
      ],
    );
  }

  Widget _buildDateField(bool isStartDate) {
    return GestureDetector(
      onTap: () => _selectDate(context, isStartDate),
      child: AbsorbPointer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isStartDate ? AppConstants.startDateLabel : AppConstants.endDateLabel,
              style: TextStyle(fontSize: 14.sp),
            ),
            SizedBox(height: 10.h),
            SizedBox(
              height: 48,
              child: TextField(
                style: TextStyle(
                  fontSize: 12.sp,
                  color: isStartDate ? null : AppColors.disableTextColor,
                ),
                enabled: false,
                decoration: InputDecoration(
                  labelStyle: TextStyle(fontSize: 14.sp),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 16,
                    ),
                    child: SizedBox(
                      width: 16.w,
                      height: 16.h,
                      child: Image.asset(
                        Assets.imagesCalendar,
                        fit: BoxFit.contain,
                        color: isStartDate ? null : AppColors.primary,
                      ),
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 12.0,
                    horizontal: 12.0,
                  ),
                ),
                controller: TextEditingController(
                  text: formatDate(isStartDate ? startDate : endDate),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCreateTaskButton() {
    return SizedBox(
      height: 52.h,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isLoading ? null : _createTask,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppConstants.primaryButtonColor,
          padding: EdgeInsets.symmetric(vertical: 16.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.r),
          ),
        ),
        child: isLoading
            ? SizedBox(
          height: 20.h,
          width: 20.w,
          child: const CircularProgressIndicator(
            color: Colors.white,
            strokeWidth: 2,
          ),
        )
            : Text(
          AppConstants.createTaskButtonText,
          style: TextStyle(
            fontSize: 16.sp,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
