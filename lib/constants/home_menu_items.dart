import 'package:flutter/material.dart';

class HomeMenuItem {
  final String title;
  final IconData icon;
  final String route;

  const HomeMenuItem({
    required this.title,
    required this.icon,
    required this.route,
  });
}

const List<HomeMenuItem> homeMenuItems = [
  HomeMenuItem(
    title: 'Dashboard',
    icon: Icons.dashboard,
    route: '/dashboard',
  ),
  HomeMenuItem(
    title: 'Profile',
    icon: Icons.person,
    route: '/profile',
  ),
  HomeMenuItem(
    title: 'Settings',
    icon: Icons.settings,
    route: '/settings',
  ),
];
