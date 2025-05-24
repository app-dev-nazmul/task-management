import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hifzpro/constants/drawer_menu_items.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final menuItems = DrawerMenuItems.getMenuItems(context);
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(child: Text("data")),
          ...menuItems.map((item)=>ListTile(
            leading: Icon(item.icons,color: item.colors,),
            title: Text(item.title),
            onTap: item.onTap,
          ))
        ],
      )
    );
  }
}
