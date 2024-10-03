import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_news/app/data/models/custom_text_style_model.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:http/http.dart' as http;

import '../app/data/config/constants.dart';
import '../app/data/models/environment.dart';
import '../app/data/models/news_model.dart';

Future<void> loadingScreen(BuildContext context) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LoadingAnimationWidget.staggeredDotsWave(
              color: const Color.fromARGB(255, 30, 153, 194),
              size: 150,
            ),
            const SizedBox(height: 5),
          ],
        ),
      );
    },
  );
}

void popDialog(BuildContext context) {
  Navigator.of(context, rootNavigator: true).pop();
}

Future<bool?> showAlert(type, context, title) {
  AlertType alertType;
  if (type == "success") {
    alertType = AlertType.success;
  } else if (type == "warning") {
    alertType = AlertType.warning;
  } else if (type == "info") {
    alertType = AlertType.info;
  } else {
    alertType = AlertType.error;
  }

  return Alert(
    type: alertType,
    style: ALERT_STYLE,
    context: context,
    desc: "\n$title\n",
    buttons: [
      DialogButton(
        onPressed: () => Navigator.pop(context),
        child: Text(
          "Close",
          style: CustomTextStyles.normal(color: Colors.white),
        ),
      )
    ],
  ).show();
}

Future<Map<String, dynamic>> getNews() async {
  bool isSuccess = false;
  String message = '';
  News news = News();

  final Uri getUserUrl =
      Uri.parse('${Environment.baseUrl + Environment.latestUrl}?lr=en-US');
  final Map<String, String> headers = {
    'x-rapidapi-host': Environment.headerHost,
    'x-rapidapi-key': Environment.headerKey,
  };

  try {
    final response = await http.get(getUserUrl, headers: headers);
    final rawResponseBody = utf8.decode(response.bodyBytes);
    debugPrint("Response Body: $rawResponseBody");

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(rawResponseBody);
      debugPrint("data: $data");
    } else if (response.statusCode == 429) {
      final Map<String, dynamic> data = jsonDecode(rawResponseBody);
      message = 'Error: ${data['message'] ?? 'message is not found'}';
    } else {
      message = 'Error: status ${response.statusCode}';
    }
  } catch (e) {
    message = 'An error occurred: $e';
  }
  debugPrint(message);
  return {
    'isSuccess': isSuccess,
    'message': message,
    'news': news,
  };
}
