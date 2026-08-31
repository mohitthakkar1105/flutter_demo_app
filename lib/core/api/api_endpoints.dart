// core/api/api_endpoints.dart

class ApiEndpoints {

  ApiEndpoints._();


  static const String baseUrl =
      "https://api.cabbandhu.com/rider/cab";



  // ===============================
  // AUTH
  // ===============================

  static const String sendOtp =
      "$baseUrl/user/send-otp";


  static const String profile =
      "$baseUrl/user/getMyProfile";

  static const String register =
      "$baseUrl/user/registration";

  // ===============================
  // PROFILE
  // ===============================



  static const String updateProfile =
      "$baseUrl/profile/update";



  // ===============================
  // DOCUMENT UPLOAD
  // ===============================

  static const String uploadDocument =
      "$baseUrl/document/upload";


}