import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';

import '../repository/auth_repository.dart';

class LoginProvider extends ChangeNotifier {
  final AuthRepository _authRepository = AuthRepository();

  Future<void> loginOtp(String phoneNumber) async {
    try {
      final response = await _authRepository.sendOtp(phoneNumber: phoneNumber);
      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        print("200 aaya $data");
      } else {
        print("kuch or aaya $data");
      }
    } catch (e) {
      print("Api error : $e");
    }
  }

  Future<void> getProfile() async {
    try {
      final response = await _authRepository.getProfile();
      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        print("200 aaya hai $data");
      } else {
        print("200 nahi aaya hai $data");
      }
    } catch (e) {
      print("ye exception aaya hai bhai -->$e");
    }
  }

  Future<void> register(Map<String, File> files) async {
    try {
      final response = await _authRepository.register(files);
      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        print("200 aaya hai ");
      } else {
        print("200 nahi aaya hai ");
      }
    } catch (e) {
      print("exception aaya hai $e");
    }
  }
}
