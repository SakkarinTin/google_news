import 'package:get/get.dart';
import 'package:google_news/app/data/models/environment.dart';

import '../controllers/app_controller.dart';
import '../controllers/network_controller.dart';
import '../data/providers/api_provider.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AppController>(() => AppController());
    Get.lazyPut<ApiProvider>(
        () => ApiProvider(newsBaseUrl: Environment.baseUrl));
    Get.put(NetworkController());
  }
}
