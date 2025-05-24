import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';

class DrawerMenuItem {
  final IconData icons;
  final String title;
  final VoidCallback onTap;
  final Color? colors;

  DrawerMenuItem({
    required this.icons,
    required this.title,
    required this.onTap,
    this.colors,
  });
}

class DrawerMenuItems {
  static List<DrawerMenuItem> getMenuItems (BuildContext context){
    final loc = AppLocalizations.of(context)!;
    return [
      DrawerMenuItem(icons: Icons.settings, title:loc.appName , onTap: (){}),
      DrawerMenuItem(icons: Icons.settings, title:loc.appName , onTap: (){}),
      DrawerMenuItem(icons: Icons.settings, title:loc.appName , onTap: (){}),
    ];
  }
}
