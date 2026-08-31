//
// import 'dart:convert';
// import 'dart:io';
// import 'package:demo_project_mohit/core/api/request_method.dart';
// import 'package:http/http.dart' as http;
// import 'package:http_parser/http_parser.dart';
// import 'package:path/path.dart' as path;
//
//
// class ApiClient {
//   ApiClient._();
//
//   static final ApiClient instance = ApiClient._();
//
//
//   // =======================================================
//   // GET
//   // =======================================================
//
//   Future<http.Response> get({
//     required String url,
//     required Map<String, String> headers,
//     Map<String, dynamic>? params,
//   }) async {
//     final uri = Uri.parse(url).replace(
//       queryParameters: params?.map(
//             (key, value) =>
//             MapEntry(
//               key,
//               value.toString(),
//             ),
//       ),
//     );
//
//
//     return await http.get(
//       uri,
//       headers: headers,
//     );
//   }
//
//
//   // =======================================================
//   // SEND
//   // POST / PUT / PATCH / DELETE
//   // =======================================================
//
//   Future<http.Response> send({
//     required RequestMethod method,
//     required String url,
//     required Map<String, String> headers,
//     Object? body,
//     Map<String, dynamic>? params,
//   }) async {
//     final uri = Uri.parse(url).replace(
//       queryParameters: params?.map(
//             (key, value) =>
//             MapEntry(
//               key,
//               value.toString(),
//             ),
//       ),
//     );
//
//
//     switch (method) {
//       case RequestMethod.post:
//         return await http.post(
//           uri,
//           headers: headers,
//           body: body != null
//               ? jsonEncode(body)
//               : null,
//         );
//
//
//       case RequestMethod.put:
//         return await http.put(
//           uri,
//           headers: headers,
//           body: body != null
//               ? jsonEncode(body)
//               : null,
//         );
//
//
//       case RequestMethod.patch:
//         return await http.patch(
//           uri,
//           headers: headers,
//           body: body != null
//               ? jsonEncode(body)
//               : null,
//         );
//
//
//       case RequestMethod.delete:
//         return await http.delete(
//           uri,
//           headers: headers,
//           body: body != null
//               ? jsonEncode(body)
//               : null,
//         );
//     }
//   }
//
//
//   // =======================================================
//   // MULTIPART
//   // POST / PUT / PATCH
//   // =======================================================
//
//   Future<http.Response> multipart({
//     required RequestMethod method,
//     required String url,
//     required Map<String, String> headers,
//     Map<String, dynamic>? fields,
//     Map<String, File>? files,
//   }) async {
//     final request = http.MultipartRequest(
//       method.name.toUpperCase(),
//       Uri.parse(url),
//     );
//
//
//     request.headers.addAll(headers);
//
//
//     // Fields
//
//     if (fields != null) {
//       fields.forEach((key, value) {
//         request.fields[key] =
//             value.toString();
//       });
//     }
//
//
//     // Files
//
//     if (files != null) {
//       for (final entry in files.entries) {
//         request.files.add(
//           _prepareFile(
//             entry.key,
//             entry.value,
//           ),
//         );
//       }
//     }
//
//
//     final streamedResponse =
//     await request.send();
//
//
//     return await http.Response.fromStream(
//       streamedResponse,
//     );
//   }
//
//
//   // =======================================================
//   // FILE PREPARE
//   // =======================================================
//
//   static http.MultipartFile _prepareFile(String field,
//       File file,) {
//     final extension =
//     path.extension(file.path)
//         .replaceFirst('.', '')
//         .toLowerCase();
//
//
//     MediaType mediaType;
//
//
//     switch (extension) {
//       case "png":
//         mediaType = MediaType(
//           "image",
//           "png",
//         );
//
//         break;
//
//
//       case "jpg":
//       case "jpeg":
//         mediaType = MediaType(
//           "image",
//           "jpeg",
//         );
//
//         break;
//
//
//       case "pdf":
//         mediaType = MediaType(
//           "application",
//           "pdf",
//         );
//
//         break;
//
//
//       default:
//         mediaType = MediaType(
//           "application",
//           "octet-stream",
//         );
//     }
//
//
//     return http.MultipartFile(
//       field,
//       file.openRead(),
//       file.lengthSync(),
//       filename: path.basename(file.path),
//       contentType: mediaType,
//     );
//   }
//
// }


import 'dart:convert';
import 'dart:io';
import 'package:demo_project_mohit/core/api/request_method.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as path;


class ApiClient {
  ApiClient._();

  static final ApiClient instance = ApiClient._();


  // =======================================================
  // GET
  // =======================================================

  Future<http.Response> get({
    required String url,
    required Map<String, String> headers,
    Map<String, dynamic>? params,
  }) async {
    final uri = Uri.parse(url).replace(
      queryParameters: params?.map(
            (key, value) =>
            MapEntry(
              key,
              value.toString(),
            ),
      ),
    );

    debugPrint('API GET → $uri', wrapWidth: 10000);
    debugPrint('API GET Headers → $headers', wrapWidth: 10000);

    final response = await http.get(
      uri,
      headers: headers,
    );

    debugPrint('API GET Response [${response.statusCode}] → ${response.body}', wrapWidth: 10000);

    return response;
  }


  // =======================================================
  // SEND
  // POST / PUT / PATCH / DELETE
  // =======================================================

  Future<http.Response> send({
    required RequestMethod method,
    required String url,
    required Map<String, String> headers,
    Object? body,
    Map<String, dynamic>? params,
  }) async {
    final uri = Uri.parse(url).replace(
      queryParameters: params?.map(
            (key, value) =>
            MapEntry(
              key,
              value.toString(),
            ),
      ),
    );

    debugPrint('API ${method.name.toUpperCase()} → $uri', wrapWidth: 10000);
    debugPrint('API ${method.name.toUpperCase()} Headers → $headers', wrapWidth: 10000);
    debugPrint('API ${method.name.toUpperCase()} Body → $body', wrapWidth: 10000);

    http.Response response;

    switch (method) {
      case RequestMethod.post:
        response = await http.post(
          uri,
          headers: headers,
          body: body != null
              ? jsonEncode(body)
              : null,
        );
        break;


      case RequestMethod.put:
        response = await http.put(
          uri,
          headers: headers,
          body: body != null
              ? jsonEncode(body)
              : null,
        );
        break;


      case RequestMethod.patch:
        response = await http.patch(
          uri,
          headers: headers,
          body: body != null
              ? jsonEncode(body)
              : null,
        );
        break;


      case RequestMethod.delete:
        response = await http.delete(
          uri,
          headers: headers,
          body: body != null
              ? jsonEncode(body)
              : null,
        );
        break;
    }

    debugPrint('API ${method.name.toUpperCase()} Response [${response.statusCode}] → ${response.body}', wrapWidth: 10000);

    return response;
  }


  // =======================================================
  // MULTIPART
  // POST / PUT / PATCH
  // =======================================================

  Future<http.Response> multipart({
    required RequestMethod method,
    required String url,
    required Map<String, String> headers,
    Map<String, dynamic>? fields,
    Map<String, File>? files,
  }) async {
    final request = http.MultipartRequest(
      method.name.toUpperCase(),
      Uri.parse(url),
    );


    request.headers.addAll(headers);


    // Fields

    if (fields != null) {
      fields.forEach((key, value) {
        request.fields[key] =
            value.toString();
      });
    }


    // Files

    if (files != null) {
      for (final entry in files.entries) {
        request.files.add(
          _prepareFile(
            entry.key,
            entry.value,
          ),
        );
      }
    }

    debugPrint('API MULTIPART ${method.name.toUpperCase()} → $url', wrapWidth: 10000);
    debugPrint('API HEADERS $headers → $headers', wrapWidth: 10000);
    debugPrint('API MULTIPART Fields → $fields', wrapWidth: 10000);
    debugPrint('API MULTIPART Files → $files', wrapWidth: 10000);

    final streamedResponse =
    await request.send();

    final response = await http.Response.fromStream(
      streamedResponse,
    );

    debugPrint('API MULTIPART Response [${response.statusCode}] → ${response.body}', wrapWidth: 10000);

    return response;
  }


  // =======================================================
  // FILE PREPARE
  // =======================================================

  static http.MultipartFile _prepareFile(String field,
      File file,) {
    final extension =
    path.extension(file.path)
        .replaceFirst('.', '')
        .toLowerCase();


    MediaType mediaType;


    switch (extension) {
      case "png":
        mediaType = MediaType(
          "image",
          "png",
        );

        break;


      case "jpg":
      case "jpeg":
        mediaType = MediaType(
          "image",
          "jpeg",
        );

        break;


      case "pdf":
        mediaType = MediaType(
          "application",
          "pdf",
        );

        break;


      default:
        mediaType = MediaType(
          "application",
          "octet-stream",
        );
    }


    return http.MultipartFile(
      field,
      file.openRead(),
      file.lengthSync(),
      filename: path.basename(file.path),
      contentType: mediaType,
    );
  }

}