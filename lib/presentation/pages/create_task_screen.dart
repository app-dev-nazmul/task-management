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
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Task Name Section
                        Container(
                          width: double.infinity,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: double.infinity,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        AppConstants.taskNameLabel,
                                        style: TextStyle(
                                          color: const Color(0xFF0D101C),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          height: 1.30,
                                          letterSpacing: -0.28,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                width: double.infinity,
                                height: 48,
                                padding: const EdgeInsets.all(16),
                                decoration: ShapeDecoration(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      width: 1,
                                      color: const Color(0xFFDCE0EE),
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: TextField(
                                  controller: taskNameController,
                                  style: TextStyle(
                                    color: const Color(0xFF6D7491),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    height: 1.40,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: AppConstants.taskNameHint,
                                    hintStyle: TextStyle(
                                      color: const Color(0xFF6D7491),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      height: 1.40,
                                    ),
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.zero,
                                    isDense: true,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 12),
                        // Task Description Section
                        Container(
                          width: double.infinity,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                width: double.infinity,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      AppConstants.taskDescription ,style: TextStyle(
                                        color: const Color(0xFF0D101C),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        height: 1.30,
                                        letterSpacing: -0.28,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.all(12),
                                      decoration: ShapeDecoration(
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                            width: 1,
                                            color: const Color(0xFFDCE0EE),
                                          ),
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                      ),
                                      child: TextField(
                                        controller: taskDescController,
                                        maxLines: 5,
                                        maxLength: AppConstants.maxDescriptionLength,
                                        style: TextStyle(
                                          color: const Color(0xFF6D7491),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          height: 1.40,
                                        ),
                                        decoration: InputDecoration(
                                          hintText: AppConstants.taskDescription,
                                          hintStyle: TextStyle(
                                            color: const Color(0xFF6D7491),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            height: 1.40,
                                          ),
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.zero,
                                          counterText: '',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 8),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: '${taskDescController.text.length}',
                                      style: TextStyle(
                                        color: const Color(0xFF613BE7),
                                        fontSize: 8,
                                        fontWeight: FontWeight.w600,
                                        height: 1.40,
                                      ),
                                    ),
                                    TextSpan(
                                      text: '/${AppConstants.maxDescriptionLength}',
                                      style: TextStyle(
                                        color: const Color(0xFF6D7491),
                                        fontSize: 8,
                                        fontWeight: FontWeight.w400,
                                        height: 1.40,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 12),
                        // Date Selection Row
                        Container(
                          width: double.infinity,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      AppConstants.startDate,
                                      style: TextStyle(
                                        color: const Color(0xFF0D101C),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        height: 1.30,
                                        letterSpacing: -0.28,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Opacity(
                                      opacity: 0.40,
                                      child: GestureDetector(
                                        onTap: () => _selectDate(context, true),
                                        child: Container(
                                          width: double.infinity,
                                          height: 48,
                                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                                          decoration: ShapeDecoration(
                                            color: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              side: BorderSide(
                                                width: 1,
                                                color: const Color(0xFFDCE0EE),
                                              ),
                                              borderRadius: BorderRadius.circular(20),
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  formatDate(startDate),
                                                  style: TextStyle(
                                                    color: const Color(0xFF6D7491),
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                    height: 1.40,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 8),
                                              Container(
                                                width: 16,
                                                height: 16,
                                                child: Image.asset(
                                                  Assets.imagesCalendar,
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      AppConstants.endDate,
                                      style: TextStyle(
                                        color: const Color(0xFF0D101C),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        height: 1.30,
                                        letterSpacing: -0.28,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    GestureDetector(
                                      onTap: () => _selectDate(context, false),
                                      child: Container(
                                        width: double.infinity,
                                        height: 48,
                                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                                        decoration: ShapeDecoration(
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                              width: 1,
                                              color: const Color(0xFFDCE0EE),
                                            ),
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                formatDate(endDate),
                                                style: TextStyle(
                                                  color: const Color(0xFF6D7491),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  height: 1.40,
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 8),
                                            Container(
                                              width: 16,
                                              height: 16,
                                              child: Image.asset(
                                                Assets.imagesCalendar,
                                                fit: BoxFit.contain,
                                                color: AppColors.primary,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 32),
            // Create Task Button
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: ShapeDecoration(
                color: const Color(0xFF613BE7),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(80),
                ),
              ),
              child: GestureDetector(
                onTap: isLoading ? null : _createOrUpdateTask,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (isLoading)
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    else
                      Expanded(
                        child: Text(
                          widget.isEditMode
                              ? AppConstants.completedTasks
                              : AppConstants.createTaskButtonText,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            height: 1.40,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
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
}
