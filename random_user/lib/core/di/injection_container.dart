import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../features/random_me/data/datasource/remote_data_source.dart';
import '../../features/random_me/data/repository/user_repository_impl.dart';
import '../../features/random_me/domain/repository/user_repository.dart';
import '../../features/random_me/domain/usecases/get_users_usecase.dart';
import '../../features/random_me/presentation/bloc/user_cubit.dart';
import '../client/dio_client.dart'; // Import UserCubit

final sl = GetIt.instance; // sl is service locator

Future<void> init() async {
  // Bloc / Cubit
  sl.registerFactory(
    () => UserCubit(getUsersUseCase: sl()), // Register UserCubit
  );

  // Use cases
  sl.registerLazySingleton(
    () => GetUsersUseCase(userRepository: sl()),
  );

  // Repository
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(remoteDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImpl(dioClient: sl()),
  );

  // Core - Client
  sl.registerLazySingleton(
    () => DioClient(baseUrl: 'https://randomuser.me/api', dio: sl()),
  );
  sl.registerLazySingleton(() => Dio());
}
