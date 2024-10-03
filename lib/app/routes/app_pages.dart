import 'package:get/get.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/saved_news/bindings/saved_news_binding.dart';
import '../modules/saved_news/views/saved_news_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SAVED_NEWS,
      page: () => const SavedNewsView(),
      binding: SavedNewsBinding(),
    ),
  ];
}
