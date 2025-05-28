import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:technical_task/domain/entities/task_entity.dart';
import 'package:technical_task/routes/app_router.dart';
import 'package:technical_task/routes/app_routes.dart';

import '../../constants/app_constants.dart';
import '../../di/di.dart';
import '../../domain/use_case/task_usecase.dart';
import '../../generated/assets.dart';
import '../../themes/colors.dart';
import '../provider/task_provider.dart';

class CreateTaskScreen extends ConsumerStatefulWidget {
  final TaskEntity? task;
  final bool isEditMode;

  const CreateTaskScreen({super.key, this.task, required this.isEditMode});

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
    if (widget.isEditMode && widget.task != null) {
      taskNameController.text = widget.task!.title;
      taskDescController.text = widget.task!.description;

      startDate = DateFormat(
        AppConstants.dateStyles,
      ).parse(widget.task!.startDate);
      endDate = DateFormat(AppConstants.dateStyles).parse(widget.task!.endDate);
    } else {
      startDate = DateTime.now();
      endDate = DateTime.now();
    }
    taskDescController.addListener(() {
      setState(() {});
    });
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
      initialDate:
          isStartDate
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
        ? DateFormat(AppConstants.dateStyles).format(date)
        : AppConstants.emptyString;
  }

  Future<void> _createOrUpdateTask() async {
    final validator = ValidateTaskUseCase();
    final validation = validator(
      title: taskNameController.text,
      description: taskDescController.text,
      startDate: startDate,
      endDate: endDate,
    );

    if (!validation.isValid) {
      _showErrorSnackBar(validation.message!);
      return;
    }

    setState(() => isLoading = true);
    final controller = ref.read(taskControllerProvider.notifier);

    try {
      if (widget.isEditMode) {
        final updatedTask = widget.task!.copyWith(
          title: taskNameController.text.trim(),
          description: taskDescController.text.trim(),
          startDate: DateFormat(AppConstants.dateStyles).format(startDate!),
          endDate: DateFormat(AppConstants.dateStyles).format(endDate!),
          status: AppConstants.statusCompletedStor,
        );
        await controller.updateTask(updatedTask);

        if (!mounted) return;
        _showSuccess(AppConstants.taskUpdated);
      } else {
        await controller.createTask(
          title: taskNameController.text.trim(),
          description: taskDescController.text.trim(),
          startDate: startDate!,
          endDate: endDate!,
          createdAt: DateFormat(AppConstants.dateStyles).format(DateTime.now()),
          status: AppConstants.statusTodoStore,
        );
        if (!mounted) return;
        _showSuccess(AppConstants.taskCreatedSuccess);
      }
      Future.delayed(const Duration(milliseconds: 800), () {
        if (mounted) {
          AppRouter.router.push(AppRoutes.home);
        }
      });
    } catch (e) {
      _showErrorSnackBar('Error: $e');
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  void _showSuccess(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.green),
    );
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading:
            widget.isEditMode
                ? IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed:
                      () => AppRouter.router.pushReplacement(AppRoutes.home),
                )
                : null,
        title: Text(
          widget.isEditMode
              ? AppConstants.viewTask
              : AppConstants.createTaskTitle,
          style: TextStyle(fontSize: 16.sp, color: Colors.black),
        ),
        elevation: 0,
        actions:
            widget.isEditMode
                ? [
                  SizedBox(
                    width: 59,
                    height: 29,
                    child: TextButton(
                      onPressed: _deleteTask,
                      style: TextButton.styleFrom(
                        backgroundColor: AppColors.buttonBackgroundColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40.r),
                        ),
                        padding:
                            EdgeInsets
                                .zero, // Avoid internal padding interfering with fixed size
                      ),
                      child: Text(
                        AppConstants.delete,
                        style: TextStyle(
                          color: AppColors.buttonDeleteColor,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                ]
                : null,
      ),
      body: Container(
        height: 500.h,
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
            // _buildCharacterCount(),
            SizedBox(height: 12.h),
            _buildDateSelectionRow(),
            SizedBox(height: 32.h),
            _buildCreateTaskButton(),
          ],
        ),
      ),
    );
  }

  Future<void> _deleteTask() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text(AppConstants.deleteConfirm),
            content: const Text(AppConstants.areYouSureDelete),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text(AppConstants.cancel),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text(AppConstants.delete),
              ),
            ],
          ),
    );

    if (confirm == true && mounted) {
      final controller = ref.read(taskControllerProvider.notifier);
      await controller.deleteTask(widget.task!.id);

      if (!mounted) return;
      _showSuccess(AppConstants.deleteSuccessfully);
      Future.delayed(const Duration(milliseconds: 800), () {
        if (mounted) {
          AppRouter.router.go(AppRoutes.home);
        }
      });
    }
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
            hintStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
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
        TextField(
          controller: taskDescController,
          maxLines: 5,
          maxLength: AppConstants.maxDescriptionLength,
          decoration: InputDecoration(
            hintText: AppConstants.taskDescriptionHint,
            hintStyle: TextStyle(
              color: const Color(0xFF6E7591),
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.r),
            ),
            counter: _buildCharacterCount(),
          ),
        ),
      ],
    );
  }

  Widget _buildCharacterCount() {
    final characterCount = taskDescController.text.length;
    return Align(
      alignment: Alignment.centerRight,
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: characterCount.toString(),
              style: TextStyle(
                color: const Color(0xFF613BE7),
                fontSize: 8.sp,
                fontWeight: FontWeight.w600,
                height: 1.40,
              ),
            ),
            TextSpan(
              text: "/${AppConstants.maxDescriptionLength}",
              style: TextStyle(
                color: const Color(0xFF6D7491),
                fontSize: 8.sp,
                fontWeight: FontWeight.w400,
                height: 1.40,
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
              isStartDate
                  ? AppConstants.startDateLabel
                  : AppConstants.endDateLabel,
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
    final isEditMode = widget.isEditMode;

    return SizedBox(
      height: 52.h,
      width: double.infinity,
      child: ElevatedButton(
        onPressed:
            isLoading
                ? null
                : () {
                  _createOrUpdateTask();
                  // if (isEditMode) {
                  //   _createOrUpdateTask();
                  // } else {
                  //   // _createTask();
                  //   _createOrUpdateTask();
                  // }
                },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppConstants.primaryButtonColor,
          padding: EdgeInsets.symmetric(vertical: 16.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.r),
          ),
        ),
        child:
            isLoading
                ? SizedBox(
                  height: 20.h,
                  width: 20.w,
                  child: const CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
                : Text(
                  isEditMode
                      ? AppConstants.completedTasks
                      : AppConstants.createTaskButtonText,
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
