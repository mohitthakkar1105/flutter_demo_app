import 'dart:io';

import 'package:demo_project_mohit/core/api/api_endpoints.dart';
import 'package:http/http.dart' as http;

import '../core/api/api_client.dart';
import '../core/api/request_method.dart';

class AuthRepository {
  final ApiClient _apiClient = ApiClient.instance;

  Future<http.Response> sendOtp({
    required String phoneNumber,
  }) async {
    return await _apiClient.send(
      method: RequestMethod.post,
      url: ApiEndpoints.sendOtp,
      headers: {
        "Content-Type": "application/json",
      },
      body: {
        "phone": phoneNumber,
      },
    );
  }

  Future<http.Response> getProfile() async {
    return await _apiClient.get(
      url: ApiEndpoints.profile,
      headers: {
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjI3MCIsInBob25lIjoiOTcwNzgwNjc5OCIsInJvbGUiOiJyaWRlciIsImlhdCI6MTc4NzkwNTQ2NywiZXhwIjoxNzg4NTEwMjY3fQ.KZeACUqlCcKOXN9kkVQjdxlu7j2-nLfwbOb1k_4N-EI',
      },
    );
  }

  Future<http.Response> register(
    Map<String, File> files,
  ) async {
    return await _apiClient.multipart(
      method: RequestMethod.post,
      url: ApiEndpoints.register,
      headers: {
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjI3MCIsInBob25lIjoiOTcwNzgwNjc5OCIsInJvbGUiOiJyaWRlciIsImlhdCI6MTc4NzkwNTQ2NywiZXhwIjoxNzg4NTEwMjY3fQ.KZeACUqlCcKOXN9kkVQjdxlu7j2-nLfwbOb1k_4N-EI',
      },
      files: files,
    );
  }
}
