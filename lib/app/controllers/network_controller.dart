import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_news/app/data/models/custom_text_style_model.dart';

class NetworkController extends GetxController {
  var isOnline = true.obs;

  @override
  void onInit() {
    super.onInit();
    _checkInitialConnection();
    _monitorConnection();
  }

  void _checkInitialConnection() async {
    ConnectivityResult connectivityResult =
        (await Connectivity().checkConnectivity()) as ConnectivityResult;
    _updateConnectionStatus(connectivityResult);
  }

  // Monitor connection changes
  void _monitorConnection() {
    Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> connectivityResults) {
      // Handle each result from the list of ConnectivityResult
      if (connectivityResults.isNotEmpty) {
        // We're only interested in the first result for now
        _updateConnectionStatus(connectivityResults.first);
      }
    });
  }

  void _updateConnectionStatus(ConnectivityResult result) {
    if (result == ConnectivityResult.none) {
      // No internet connection
      isOnline.value = false;
      Get.snackbar(
        '',
        '',
        titleText: Text('No Internet Connection',
            style: CustomTextStyles.appBar(color: Colors.white)),
        messageText: Text('Please check your internet settings.',
            style: CustomTextStyles.normal(color: Colors.white)),
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 4),
      );
    } else {
      // Come back online
      if (!isOnline.value) {
        isOnline.value = true;
        Get.snackbar(
          'Online',
          'Internet connection is restored.',
          titleText: Text('Online',
              style: CustomTextStyles.appBar(color: Colors.white)),
          messageText: Text('Internet connection is restored.',
              style: CustomTextStyles.normal(color: Colors.white)),
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 4),
        );
      }
    }
  }
}
