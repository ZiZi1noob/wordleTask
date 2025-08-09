import 'dart:convert';
// ------------------------------------------------------------------------------------- //

// class ApiResModel<T> {
//   final String code;
//   final String message;
//   final T? data;
//   final bool success;

//   ApiResModel({
//     required this.code,
//     required this.message,
//     this.data,
//     required this.success,
//   });

//   factory ApiResModel.fromJson(
//     Map<String, dynamic> json,
//     T Function(dynamic)? fromJsonT,
//   ) {
//     return ApiResModel<T>(
//       code: json['code'].toString(),
//       message: json['message'] ?? '',
//       data:
//           json['data'] != null && fromJsonT != null
//               ? fromJsonT(json['data'])
//               : json['data'],
//       success: json['success'] ?? false,
//     );
//   }

//   bool get isSuccess => code == "200" && success == true;
// }

class ApiResModel<T> {
  final String code;
  final String message;
  final T? data;
  final bool success;

  ApiResModel({
    required this.code,
    required this.message,
    this.data,
    required this.success,
  });

  factory ApiResModel.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic) fromJsonT,
  ) {
    try {
      return ApiResModel<T>(
        code: json['code']?.toString() ?? '0', // Handle null code
        message: json['message']?.toString() ?? '',
        data: json['data'] != null ? fromJsonT(json['data']) : null,
        success: json['success'] ?? false,
      );
    } catch (e) {
      print('Error parsing ApiResModel: $e');
      rethrow;
    }
  }

  bool get isSuccess => (code == "200" || success == true);
}
