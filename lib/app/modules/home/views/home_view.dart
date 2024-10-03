import 'dart:ui' as ui;
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../config/constants.dart';
import '../../../controllers/network_controller.dart';
import '../../../data/models/custom_text_style_model.dart';
import '../../../../widgets/custom_drawer.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Today\'s News',
            style: CustomTextStyles.appBar(isBold: true),
          ),
          centerTitle: true,
          // Add a widget to the right side of the AppBar to display offline status
          actions: [
            Obx(() {
              // Show "Offline" with red bullet if isOnline is false
              return Get.find<NetworkController>().isOnline.value
                  ? const SizedBox.shrink() // Nothing when online
                  : Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.brightness_1, // Red bullet
                            color: Colors.red,
                            size: 10,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Offline',
                            style: CustomTextStyles.normal(
                              color: Colors.red,
                              isBold: true,
                            ),
                          ),
                        ],
                      ),
                    );
            }),
          ],
        ),
        drawer: CustomDrawer(
          selectedMenu: DRAWER_MENU_HOME,
          onDrawerOpen: () {},
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 16.0),
              child: SizedBox(
                height: 60,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: CATEGORIES.length,
                  itemBuilder: (context, index) {
                    // Get text width for the blue line to match the text length (Category text)
                    final TextPainter textPainter = TextPainter(
                      text: TextSpan(
                          text: CATEGORIES[index],
                          style: CustomTextStyles.normal()),
                      maxLines: 1,
                      textDirection: ui.TextDirection.ltr,
                    )..layout(minWidth: 0, maxWidth: double.infinity);
                    double textWidth = textPainter.size.width;

                    return GestureDetector(
                      onTap: () {
                        debugPrint('Click ${CATEGORIES[index]}');
                        controller.setSelectedCategoryIndex(index);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14.0),
                        child: Obx(() => Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  CATEGORIES[index],
                                  style: index ==
                                          controller.selectedCategoryIndex.value
                                      ? CustomTextStyles.normal(isBold: true)
                                      : CustomTextStyles.normal(
                                          isBold: true, color: Colors.grey),
                                ),
                                const SizedBox(height: 4),
                                Container(
                                  height: 2,
                                  width: textWidth,
                                  color: index ==
                                          controller.selectedCategoryIndex.value
                                      ? Colors.lightBlueAccent
                                      : Colors.transparent,
                                ),
                              ],
                            )),
                      ),
                    );
                  },
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 10,
                  child: isLandscape
                      ? Row(
                          children: [
                            // Image on the left side
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: InkWell(
                                    onTap: () async =>
                                        await controller.openUrl(context),
                                    child: Obx(() => Image.network(
                                          controller.thumbnailUrl.value,
                                          height: screenSize.height * 0.4,
                                          width: double.infinity,
                                          fit: BoxFit.fill,
                                          errorBuilder: (BuildContext context,
                                              Object exception,
                                              StackTrace? stackTrace) {
                                            return Image.asset(
                                              'assets/images/not_found_image.jpg',
                                              height: screenSize.height * 0.4,
                                              width: double.infinity,
                                              fit: BoxFit.fill,
                                            );
                                          },
                                        )),
                                  ),
                                ),
                              ),
                            ),
                            // Text on the right side
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 26.0, horizontal: 16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Obx(() => Text(
                                          controller.title.value,
                                          style: CustomTextStyles.normal(
                                              isBold: true),
                                        )),
                                    const SizedBox(height: 6),
                                    Obx(() => Text(
                                          controller.snippet.value,
                                          style: CustomTextStyles.small(),
                                        )),
                                    const SizedBox(height: 20),
                                    Row(
                                      children: [
                                        Obx(
                                          () => RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: controller
                                                      .publisher.value,
                                                  style:
                                                      CustomTextStyles.normal(
                                                          color: Colors
                                                              .lightBlueAccent),
                                                ),
                                                WidgetSpan(
                                                  alignment:
                                                      PlaceholderAlignment
                                                          .middle,
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 10.0),
                                                    child: Icon(
                                                      Icons.brightness_1,
                                                      size: 8,
                                                      color:
                                                          Colors.grey.shade400,
                                                    ),
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: controller
                                                      .getTimePassed(),
                                                  style: CustomTextStyles.small(
                                                      color:
                                                          Colors.grey.shade400),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                InkWell(
                                  onTap: () async =>
                                      await controller.openUrl(context),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: Obx(() => Image.network(
                                          controller.thumbnailUrl.value,
                                          height: screenSize.height * 0.4,
                                          width: double.infinity,
                                          fit: BoxFit.fill,
                                          errorBuilder: (BuildContext context,
                                              Object exception,
                                              StackTrace? stackTrace) {
                                            return Image.asset(
                                              'assets/images/not_found_image.jpg',
                                              height: screenSize.height * 0.4,
                                              width: double.infinity,
                                              fit: BoxFit.fill,
                                            );
                                          },
                                        )),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Obx(() => Text(
                                        controller.title.value,
                                        style: CustomTextStyles.normal(
                                            isBold: true),
                                      )),
                                  const SizedBox(height: 6),
                                  Obx(() => Text(
                                        controller.snippet.value,
                                        style: CustomTextStyles.small(),
                                      )),
                                  const SizedBox(height: 20),
                                  Row(
                                    children: [
                                      Obx(
                                        () => RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text:
                                                    controller.publisher.value,
                                                style: CustomTextStyles.normal(
                                                    color:
                                                        Colors.lightBlueAccent),
                                              ),
                                              WidgetSpan(
                                                alignment:
                                                    PlaceholderAlignment.middle,
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 10.0),
                                                  child: Icon(
                                                    Icons.brightness_1,
                                                    size: 8,
                                                    color: Colors.grey.shade400,
                                                  ),
                                                ),
                                              ),
                                              TextSpan(
                                                text:
                                                    controller.getTimePassed(),
                                                style: CustomTextStyles.small(
                                                    color:
                                                        Colors.grey.shade400),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      debugPrint("Click previous button!");
                    },
                    style: TextButton.styleFrom(
                      backgroundColor:
                          Colors.grey.shade200, // Light grey background
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 24),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.arrow_back,
                            color: Colors.black87, // Dark grey icon
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Previous',
                            style: CustomTextStyles.normal(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      controller.pressedNextButton();
                    },
                    style: TextButton.styleFrom(
                      backgroundColor:
                          Colors.black87, // Dark grey/black background
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 24),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        children: [
                          Text(
                            'Next',
                            style: CustomTextStyles.normal(color: Colors.white),
                          ),
                          const SizedBox(width: 8),
                          const Icon(
                            Icons.arrow_forward,
                            color: Colors.white, // White icon
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
