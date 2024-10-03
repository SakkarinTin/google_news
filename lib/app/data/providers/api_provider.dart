import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_news/app/data/models/environment.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/api_error_model.dart';
import '../models/news_model.dart';

class ApiProvider extends GetConnect implements GetxService {
  final String newsBaseUrl;
  late Map<String, String> _mainHeaders;
  late Map<String, String> _mainQuery;

  ApiProvider({required this.newsBaseUrl}) {
    baseUrl = newsBaseUrl;
    _mainHeaders = {
      'x-rapidapi-host': Environment.headerHost,
      'x-rapidapi-key': Environment.headerKey,
    };
    _mainQuery = {"lr": "en-US"};
  }

  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) {
        if (map.containsKey('items')) {
          return News.fromJson(map);
        }
        if (map.containsKey('message')) {
          return ApiError.fromJson(map);
        }
      }
      return null;
    };
    httpClient.baseUrl = Environment.baseUrl;
  }

  Future getNewsData(
    int categoryIndex, {
    Map<String, dynamic>? query,
    String? contentType,
    Map<String, String>? headers,
    Function(dynamic)? decoder,
  }) async {
    final Map<int, String> categoryUrls = {
      0: Environment.latestUrl, // Default
      1: Environment.entertainmentUrl,
      2: Environment.worldUrl,
      3: Environment.businessUrl,
      4: Environment.healthUrl,
      5: Environment.sportUrl,
      6: Environment.scienceUrl,
      7: Environment.technologyUrl,
    };
    final String url = categoryUrls[categoryIndex] ?? Environment.latestUrl;

    debugPrint("Start calling $url");
    try {
      Response response = await get(
        url,
        contentType: contentType,
        query: query ?? _mainQuery,
        headers: headers ?? _mainHeaders,
      );

      if (response.statusCode == 200) {
        debugPrint("success: 200");
        return response.body;
      } else if (response.statusCode == 429) {
        debugPrint("fail: 429");
        final error = response.body as ApiError;
        debugPrint("Error: ${error.message}");
        return error;
      } else {
        debugPrint(
            "Error: ${response.statusCode} - ${response.statusText}\n${response.body}");
        return null;
      }
    } catch (e) {
      debugPrint("Exception occurred: $e");
      return null;
    }
  }
}
