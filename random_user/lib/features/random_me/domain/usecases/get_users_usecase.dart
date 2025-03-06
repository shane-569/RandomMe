import '../entities/user.dart';
import '../repository/user_repository.dart';

class GetUsersUseCase {
  final UserRepository userRepository;

  GetUsersUseCase({required this.userRepository});

  Future<List<User>> call() async {
    return await userRepository.getUsers();
  }
}
