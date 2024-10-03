import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_news/app/data/models/custom_text_style_model.dart';

import '../../../../widgets/custom_drawer.dart';
import '../../../controllers/network_controller.dart';
import '../../../data/config/constants.dart';
import '../controllers/saved_news_controller.dart';

class SavedNewsView extends GetView<SavedNewsController> {
  const SavedNewsView({super.key});
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Saved News',
            style: CustomTextStyles.appBar(isBold: true),
          ),
          centerTitle: true,
          actions: [
            Obx(() {
              return Get.find<NetworkController>().isOnline.value
                  ? Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.brightness_1,
                            color: Colors.green,
                            size: 10,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Online',
                            style: CustomTextStyles.normal(
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.brightness_1,
                            color: Colors.red,
                            size: 10,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Offline',
                            style: CustomTextStyles.normal(
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    );
            }),
          ],
        ),
        drawer: CustomDrawer(
          selectedMenu: DRAWER_MENU_SAVED_NEWS,
          onDrawerOpen: () {},
        ),
        body: Center(
          child: Text(
            "Gridview of square card article widget\n\n2 columns and scrollable vertical.",
            style: CustomTextStyles.appBar(),
          ),
        ),
      ),
    );
  }
}
