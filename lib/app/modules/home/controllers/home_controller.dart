import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_news/utils/helpers.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../data/models/api_error_model.dart';
import '../../../data/models/news_model.dart';
import '../../../data/providers/api_provider.dart';

class HomeController extends GetxController {
  final RxString thumbnailUrl = ''.obs;
  final RxString fullArticleUrl = ''.obs;
  final RxString title = ''.obs;
  final RxString snippet = ''.obs;
  final RxString publisher = ''.obs;
  final RxString timestamp = ''.obs;

  final RxInt selectedCategoryIndex = 0.obs;
  final RxInt currentArticleIndex = 0.obs;

  var news = News().obs; // Observes the News data
  var errorMessage = ''.obs; // Observes the error message (if any)
  var isLoading = true.obs; // Observes the loading state

  @override
  void onInit() {
    super.onInit();
    // getNews();
    fetchNews();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // Fetch news according to selectedCategoryIndex
  Future<void> fetchNews() async {
    debugPrint("Start fetchNews..");
    try {
      isLoading.value = true;
      final result = await Get.find<ApiProvider>()
          .getNewsData(selectedCategoryIndex.value);

      if (result is News) {
        news.value = result;
        errorMessage.value = '';

        // Update UI elements with the fetched news data
        if (news.value.articles != null && news.value.articles!.isNotEmpty) {
          final firstArticle = news.value.articles![0];
          thumbnailUrl.value = firstArticle.images?['thumbnail'] ?? '';
          fullArticleUrl.value = firstArticle.newsUrl ?? '';
          title.value = firstArticle.title ?? 'Title is not found';
          snippet.value = firstArticle.snippet ?? 'Snippet is not found';
          publisher.value = firstArticle.publisher ?? 'Publisher is not found';
          timestamp.value = firstArticle.timestamp ?? '';
        }
      } else if (result is ApiError) {
        errorMessage.value = result.message;
        debugPrint("Error fetch news: ${errorMessage.value}");
      }
    } catch (e) {
      errorMessage.value = 'Error: $e';
    } finally {
      isLoading.value = false;
    }
  }

  void setSelectedCategoryIndex(int index) {
    selectedCategoryIndex.value = index;
    return;
  }

  Future<void> openUrl(BuildContext context) async {
    try {
      Uri uri = Uri.parse(thumbnailUrl.value);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri); // Specify mode for launching
      } else {
        throw 'Could not launch ${thumbnailUrl.value}';
      }
    } catch (e) {
      debugPrint("Error opening URL: $e");
      showAlert('error', context, e.toString());
    }
    return;
  }

  String getFormattedDate() {
    String formattedDate = "";
    try {
      DateTime timestampDatetime =
          DateTime.fromMillisecondsSinceEpoch(int.parse(timestamp.value));
      formattedDate = DateFormat.yMMMMd().add_jm().format(timestampDatetime);
    } catch (e) {
      debugPrint("Error format date: $e");
      formattedDate = "Sorry, issue with date conversion!";
    }
    return formattedDate;
  }

  String getTimePassed() {
    String timePassedString = "";
    List<String> timeParts = [];
    if (timestamp.value.isEmpty) return 'Waiting..';
    try {
      DateTime timestampDatetime =
          DateTime.fromMillisecondsSinceEpoch(int.parse(timestamp.value));
      Duration difference = DateTime.now().difference(timestampDatetime);

      int days = difference.inDays;
      int hours = difference.inHours.remainder(24);
      int minutes = difference.inMinutes.remainder(60);

      if (days > 0) {
        timeParts.add('${days}d');
      }
      if (hours > 0) {
        timeParts.add('${hours}hr');
      }
      if (minutes > 0) {
        timeParts.add('${minutes}min');
      }
      timePassedString =
          timeParts.isNotEmpty ? '${timeParts.join(' ')} ago' : 'Just now';
    } catch (e) {
      debugPrint("Error calculate time passed: $e");
      timePassedString = "Sorry, issue with getting time passed!";
    }
    return timePassedString;
  }

  void pressedNextButton() {
    debugPrint("Click next button!");
    debugPrint("News: ${news.value}");
  }
}
