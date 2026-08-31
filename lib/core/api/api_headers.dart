// // core/api/api_headers.dart
//
// import '../../utils/session_helper.dart';
//
// class ApiHeaders {
//   ApiHeaders._();
//
//
//   // ===============================
//   // BASIC HEADER
//   // ===============================
//
//   static Map<String, String> basic() {
//     return {
//       "Content-Type": "application/json",
//     };
//   }
//
//
//
//   // ===============================
//   // ACCESS TOKEN
//   // ===============================
//
//   static Future<Map<String, String>> accessToken() async {
//
//     final token = await SessionHelper.accessToken;
//
//     return {
//       "Content-Type": "application/json",
//       "Authorization": "Bearer $token",
//     };
//   }
//
//
//
//
//   // ===============================
//   // REFRESH TOKEN
//   // ===============================
//
//   static Future<Map<String, String>> refreshToken() async {
//
//     final token = await SessionHelper.refreshToken;
//
//     return {
//       "Content-Type": "application/json",
//       "Authorization": "Bearer $token",
//     };
//   }
//
//
//
//
//   // ===============================
//   // MULTIPART WITHOUT TOKEN
//   // ===============================
//
//   static Map<String, String> multipart() {
//
//     return {};
//
//   }
//
//
//
//
//   // ===============================
//   // MULTIPART WITH TOKEN
//   // ===============================
//
//   static Future<Map<String, String>> multipartAccessToken() async {
//
//     final token = await SessionHelper.accessToken;
//
//     return {
//       "Authorization": "Bearer $token",
//     };
//   }
//
// }