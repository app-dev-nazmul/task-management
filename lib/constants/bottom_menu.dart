import '../generated/assets.dart';

class BottomNavItem {
  final String assetPath;
  final String route;

  const BottomNavItem({
    required this.assetPath,
    required this.route,
  });
}


 List<BottomNavItem> bottomNavItems = [
  BottomNavItem(
    assetPath: Assets.imagesHome,
    route: '/home',
  ),
  BottomNavItem(
    assetPath: Assets.imagesClipboardListCheck,
    route: '/tasks',
  ),
  BottomNavItem(
    assetPath: Assets.imagesCalendar,
    route: '/calendar',
  ),
];