import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_news/app/data/models/custom_text_style_model.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../models/environment.dart';

// App Information
const String APP_NAME = 'Google News';
const String VERSION_SOFTWARE = 'v1.0.0';
const String DRAWER_MENU_HOME = 'Home';
const String DRAWER_MENU_SAVED_NEWS = 'Saved News';

// API Related
final Duration REQ_TIMEOUT_API =
    Duration(seconds: Environment.requestTimeoutApi);

// UI
const double NORMAL_FONT_SIZE = 17.0;
const double SMALL_FONT_SIZE = 14.0;
const double APP_BAR_FONT_SIZE = 24.0;
const double DRAWER_FONT_SIZE = 20.0;
const double ALERT_FONT_SIZE = 24.0;
const double BUTTON_FONT_SIZE = 20.0;
final AlertStyle ALERT_STYLE = AlertStyle(
  animationType: AnimationType.grow,
  isCloseButton: false,
  isOverlayTapDismiss: false,
  descStyle: CustomTextStyles.custom(fontSize: ALERT_FONT_SIZE),
  descTextAlign: TextAlign.center,
  animationDuration: const Duration(milliseconds: 200),
  alertAlignment: Alignment.center,
);

// Categories
final List<String> CATEGORIES = [
  "Latest",
  "Entertainment",
  "World",
  "Business",
  "Health",
  "Sport",
  "Science",
  "Technology",
];

final List<Map<String, dynamic>> mockUpData = [
  {
    'title': "John Amos, a Star of ‘Good Times’ and ‘Roots,’ Is Dead at 84",
    'snippet':
        "John Amos, who played a stern patriarch on “Good Times,” America's first sitcom featuring a two-parent Black family, and who had a starring role in “Roots,” ...",
    'publisher': "The New York Times",
    'timestamp': "1727844120000",
    'newsUrl': "https://www.nytimes.com/2024/10/01/arts/john-amos-dead.html",
    'images': {
      'thumbnail':
          "https://news.google.com/api/attachments/CC8iI0NnNWtTbFJQU25VNVlsRjRhMWc0VFJEdkJCanNBeWdLTWdB=-w280-h168-p-df-rw",
      'thumbnailProxied':
          "https://i.zedtranslate.com/newsimage/CC8iI0NnNWtTbFJQU25VNVlsRjRhMWc0VFJEdkJCanNBeWdLTWdB"
    },
    'hasSubnews': true,
    'subnews': [
      {
        'title': "John Amos, ‘Good Times’ Dad, Dies at 84",
        'snippet':
            "John Amos, who starred as the stoic father on 'Good Times,' on 'The Mary Tyler Moore Show' and on 'Roots,' has died.",
        'publisher': "Hollywood Reporter",
        'timestamp': "1727805019000",
        'newsUrl':
            "https://www.hollywoodreporter.com/tv/tv-news/john-amos-dead-good-times-roots-1236019054/",
        'images': {
          'thumbnail':
              "https://news.google.com/api/attachments/CC8iI0NnNDJRV2RoVGxWdFQxSkRNeTF1VFJDZkF4amlCU2dLTWdB=-w280-h168-p-df-rw",
          'thumbnailProxied':
              "https://i.zedtranslate.com/newsimage/CC8iI0NnNDJRV2RoVGxWdFQxSkRNeTF1VFJDZkF4amlCU2dLTWdB"
        }
      },
      {
        'title':
            "John Amos, patriarch on 'Good Times' and an Emmy nominee for the blockbuster 'Roots,' dies at 84",
        'snippet':
            "LOS ANGELES (AP) — John Amos, who starred as the family patriarch on the hit 1970s sitcom “Good Times” and earned an Emmy nomination for his role in the ...",
        'publisher': "The Associated Press",
        'timestamp': "1727823420000",
        'newsUrl':
            "https://apnews.com/article/john-amos-dead-65a1d2dc84175bb5d4c579901af7164f",
        'images': {
          'thumbnail':
              "https://news.google.com/api/attachments/CC8iI0NnNTFRMUV5UjJKQllWTkRXak5CVFJDUEF4alhCQ2dLTWdB=-w280-h168-p-df-rw",
          'thumbnailProxied':
              "https://i.zedtranslate.com/newsimage/CC8iI0NnNTFRMUV5UjJKQllWTkRXak5CVFJDUEF4alhCQ2dLTWdB"
        }
      }
    ]
  }
];
