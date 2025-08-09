import 'package:wordle/services/base/apiConstants.dart' show ApiConstants;
import 'package:wordle/models/apiResponseModel.dart' show ApiResModel;
import 'base/apiClient.dart';

class UserService {
  final ApiClient _apiClient = ApiClient();

  Future<Map<String, dynamic>> getUserInfo(String name) async {
    try {
      String uri = '/api/v1/user/get-info/$name';

      final response = await _apiClient.get(
        uri,
        headers: ApiConstants.formHeaders,
      );

      final apiResponse = ApiResModel<Map<String, dynamic>>.fromJson(
        response.data,
        (data) => data as Map<String, dynamic>,
      );

      if (apiResponse.isSuccess && apiResponse.data != null) {
        return apiResponse.data!;
      } else {
        throw apiResponse.message ?? 'Failed to get user info';
      }
    } catch (e) {
      print('Error fetching user info: $e');
      rethrow;
    }
  }
}
