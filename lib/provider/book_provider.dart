import 'dart:convert';
import 'package:flutter/foundation.dart';
import '../core/api/api_client.dart';

class BookProvider extends ChangeNotifier {
  bool isLoading = false;
  List<dynamic> books = [];
  String? error;

  Future<void> getBooks() async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      final response = await ApiClient.instance.get(
        url: 'http://192.168.29.197:8000/books',
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        books = jsonDecode(response.body);
      } else {
        error = 'API Error: ${response.statusCode}';
      }
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}