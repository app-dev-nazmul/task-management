import 'package:flutter/material.dart';
import 'package:technical_task/presentation/pages/create_task_screen.dart';
import '../../presentation/pages/home.dart';
import '../domain/entities/task_entity.dart';
import 'app_routes.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final GoRouter _router = GoRouter(
    initialLocation: AppRoutes.home,
    routes: [
      GoRoute(
        path: AppRoutes.home,
        name: 'home',
        builder: (context, state) =>  HomeScreen(),
      ),
      GoRoute(
        path: AppRoutes.viewTask,
        name: 'viewTask',
        builder: (context, state) {
          final data = state.extra as Map<String, dynamic>;
          final task = data['task'] as TaskEntity;
          final isEditMode = data['isEditMode'] as bool;

          return CreateTaskScreen(task: task, isEditMode: isEditMode);
        },
      ),
    ],
    errorBuilder:
        (context, state) =>
            const Scaffold(body: Center(child: Text('Page not found'))),
  );

  static GoRouter get router => _router;
}
