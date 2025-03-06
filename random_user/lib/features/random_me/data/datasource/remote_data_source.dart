import 'package:dio/dio.dart';

import '../../../../core/client/dio_client.dart';
import '../../../../core/errors/exceptions.dart';
import '../model/user_model.dart';

abstract class RemoteDataSource {
  Future<List<UserModel>> getUsers();
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final DioClient dioClient;

  RemoteDataSourceImpl({required this.dioClient});

  @override
  Future<List<UserModel>> getUsers() async {
    try {
      final response = await dioClient
          .get(''); // API endpoint is base URL in DioClient config
      if (response.statusCode == 200) {
        final results =
            List<Map<String, dynamic>>.from(response.data['results']);
        return results.map((userJson) => UserModel.fromJson(userJson)).toList();
      } else {
        throw ServerException(message: 'Failed to fetch users');
      }
    } on DioException catch (e) {
      throw ServerException(message: e.message);
    }
  }
}
