import 'package:random_user/core/errors/exceptions.dart';

import '../../domain/entities/user.dart';
import '../../domain/repository/user_repository.dart';
import '../datasource/remote_data_source.dart'; // Import UserPictureModel (data layer model) // Ensure these are imported if separate

class UserRepositoryImpl implements UserRepository {
  final RemoteDataSource remoteDataSource;

  UserRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<User>> getUsers() async {
    try {
      final userModels = await remoteDataSource.getUsers();
      final users = userModels.map((userModel) {
        // Correctly create domain layer UserName
        final domainUserName = UserName(
          title:
              userModel.name.title, // Assuming UserModel.name is UserNameModel
          first: userModel.name.first,
          last: userModel.name.last,
        );
        // Correctly create domain layer UserPicture
        final domainUserPicture = UserPicture(
          large: userModel
              .picture.large, // Assuming UserModel.picture is UserPictureModel
          medium: userModel.picture.medium,
          thumbnail: userModel.picture.thumbnail,
        );

        return User(
          gender: userModel.gender,
          name: domainUserName, // Use the domain layer UserName we just created
          email: userModel.email,
          phone: userModel.phone,
          picture:
              domainUserPicture, // Use the domain layer UserPicture we just created
        );
      }).toList();
      return users;
    } on ServerException {
      rethrow;
    }
  }
}
