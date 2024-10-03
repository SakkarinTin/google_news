import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../app/data/config/constants.dart';
import '../app/data/models/custom_text_style_model.dart';
import '../app/data/models/shared_pref.dart';

class CustomDrawer extends StatefulWidget {
  CustomDrawer(
      {super.key,
      required this.selectedMenu,
      required Null Function() onDrawerOpen});

  String selectedMenu;

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final AssetImage userImage =
      const AssetImage('assets/images/blank_profile_user.png');

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 35,
                          backgroundImage: userImage,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          sharedPrefs.userDisplayName,
                          style: CustomTextStyles.appBar(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  _buildMenuItem(
                    icon: Icons.home_filled,
                    text: DRAWER_MENU_HOME,
                    isSelected: widget.selectedMenu == DRAWER_MENU_HOME,
                    onTap: () {
                      setState(() {
                        widget.selectedMenu = DRAWER_MENU_HOME;
                      });
                      debugPrint("Go to Home view");
                      Get.toNamed('/home');
                    },
                  ),
                  _buildMenuItem(
                    icon: Icons.bookmark_border_rounded,
                    text: DRAWER_MENU_SAVED_NEWS,
                    isSelected: widget.selectedMenu == DRAWER_MENU_SAVED_NEWS,
                    onTap: () {
                      setState(() {
                        widget.selectedMenu = DRAWER_MENU_SAVED_NEWS;
                      });
                      debugPrint("Go to Saved News view");
                      Get.toNamed('/saved-news');
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text("$APP_NAME  $VERSION_SOFTWARE",
                  style: CustomTextStyles.small(color: Colors.grey)),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String text,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Container(
      color: isSelected ? Colors.grey : Colors.transparent,
      child: ListTile(
        leading: Icon(
          icon,
          color: isSelected ? Colors.lightBlueAccent : Colors.black,
        ),
        title: Text(
          text,
          style: isSelected
              ? CustomTextStyles.drawer(color: Colors.white)
              : CustomTextStyles.drawer(),
        ),
        onTap: onTap,
      ),
    );
  }
}
