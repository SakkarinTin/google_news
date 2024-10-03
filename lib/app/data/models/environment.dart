import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String get fileName {
    return 'assets/.env';
  }

  static int get requestTimeoutApi {
    return int.parse((dotenv.env['REQUEST_TIMEOUT_API'] ?? 120).toString());
  }

  static String get baseUrl {
    return dotenv.env['BASE_URL'] ?? '';
  }

  static String get latestUrl {
    return dotenv.env['LATEST_URL'] ?? '';
  }

  static String get entertainmentUrl {
    return dotenv.env['ENTERTAINMENT_URL'] ?? '';
  }

  static String get worldUrl {
    return dotenv.env['WORLD_URL'] ?? '';
  }

  static String get businessUrl {
    return dotenv.env['BUSINESS_URL'] ?? '';
  }

  static String get healthUrl {
    return dotenv.env['HEALTH_URL'] ?? '';
  }

  static String get sportUrl {
    return dotenv.env['SPORT_URL'] ?? '';
  }

  static String get scienceUrl {
    return dotenv.env['SCIENCE_URL'] ?? '';
  }

  static String get technologyUrl {
    return dotenv.env['TECHNOLOGY_URL'] ?? '';
  }

  static String get headerHost {
    return dotenv.env['HEADER_HOST'] ?? '';
  }

  static String get headerKey {
    return dotenv.env['HEADER_KEY'] ?? '';
  }
}
