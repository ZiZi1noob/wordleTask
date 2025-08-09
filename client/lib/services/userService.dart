import 'package:wordle/services/base/apiConstants.dart' show ApiConstants;
import 'package:wordle/models/apiResponseModel.dart' show ApiResModel;
import 'package:wordle/models/userModel.dart' show UserModel;
import 'base/apiClient.dart';

class UserService {
  final ApiClient _apiClient = ApiClient();

  Future<ApiResModel<UserModel>> getUserInfo(String name) async {
    try {
      final uri = '/api/v1/user/get-info/$name';

      final response = await _apiClient.get(
        uri,
        headers: ApiConstants.formHeaders,
      );

      final apiResponse = ApiResModel<UserModel>.fromJson(
        response.data,
        (data) => UserModel.fromJson(data),
      );

      if (apiResponse.isSuccess && apiResponse.data != null) {
        return apiResponse;
      } else {
        throw Exception(apiResponse.message ?? 'Failed to get user info');
      }
    } catch (e, stackTrace) {
      print('Error fetching user info: $e');
      print('Stack trace: $stackTrace');
      rethrow;
    }
  }
}
