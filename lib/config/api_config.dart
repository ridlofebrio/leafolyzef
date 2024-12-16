import 'dart:io';

class ApiConfig {
  static String baseUrl = Platform.isAndroid
      ? 'https://160.19.167.23' // Android
      : 'https://160.19.167.23'; // iOS

  static const String apiVersion = 'v1';
  static const Duration timeout = Duration(seconds: 30);

  // Headers
  static const Map<String, String> headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
  };

  // Endpoints base path
  static const String apiPath = '/api';

  // Full base URL
  static String get fullBaseUrl => '$baseUrl$apiPath/';
}
