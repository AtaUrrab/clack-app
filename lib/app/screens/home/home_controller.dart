import 'package:clack_app/app/screens/home/settings/settngs_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/res/assets_refer.dart';
import 'chats/chats_main_screen.dart';
import 'locater/view/locater_screen.dart';

class HomeController extends GetxController {
  int selectedIndex = 1;

  List<Widget> screens = [
    const LocaterScreen(),
    const ChatsMainScreen(),
    const SettingsScreen(),
  ];

  List<BottomNavigationBarItem> navigationBarItems = [
    const BottomNavigationBarItem(
      icon: Padding(
        padding: EdgeInsets.only(bottom: 8.0),
        child: ImageIcon(AssetImage(AssetsRefer.locaterIcon)),
      ),
      label: "Nearby",
    ),
    const BottomNavigationBarItem(
      icon: Padding(
        padding: EdgeInsets.only(bottom: 8.0),
        child: ImageIcon(AssetImage(AssetsRefer.chatIcon)),
      ),
      label: 'Chats',
    ),
    const BottomNavigationBarItem(
      icon: Padding(
        padding: EdgeInsets.only(bottom: 8.0),
        child: ImageIcon(AssetImage(AssetsRefer.settingsIcon)),
      ),
      label: 'Settings',
    ),
  ];

  void changePage(int index) {
    selectedIndex = index;
    update();
  }
}
