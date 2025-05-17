import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';

import '../models/place.dart'; // هذه مهمة!

class ApiService {
  static Dio createDio() {
    final dio = Dio(BaseOptions(
      headers: {'Content-Type': 'application/json'},
    ));

    // لتجاوز شهادة SSL في بيئة التطوير فقط
    (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
      final client = HttpClient();
      client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      return client;
    };

    return dio;
  }

  static final Dio dio = createDio();

  static const String baseUrl = "https://aitraining.jirventures.com/webhook-test/search-by-nearby-google-ma-algorithm"; // عدل حسب الحاجة

  static Future<List<PlaceResult>?> searchLocations(String prompt) async {
    try {
      final response = await dio.post(
        baseUrl,
        data: {'prompt': prompt},
      );

      if (response.statusCode == 200) {
        final responseModel = PlaceSearchResult.fromJson(response.data);
        return responseModel.results;
      } else {
        print("استجابة غير ناجحة من الخادم.");
        return null;
      }
    } catch (e) {
      print("حدث خطأ أثناء الطلب: $e");
      return null;
    }
  }
}
