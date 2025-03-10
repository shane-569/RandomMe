import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:random_user/core/errors/exceptions.dart';
import 'package:random_user/features/random_me/domain/entities/user.dart';
import 'package:random_user/features/random_me/domain/usecases/get_users_usecase.dart';
import 'package:random_user/features/random_me/presentation/bloc/user_cubit.dart';

import 'user_cubit_test.mocks.dart'; // Auto-generated by build_runner

@GenerateMocks([GetUsersUseCase])
void main() {
  late MockGetUsersUseCase mockGetUsersUseCase;

  setUp(() {
    mockGetUsersUseCase = MockGetUsersUseCase();
  });

  final tUsers = [
    User(
      gender: 'male',
      name: UserName(title: 'Mr', first: 'John', last: 'Doe'),
      email: 'john.doe@example.com',
      phone: '123-456-7890',
      picture: UserPicture(large: '', medium: '', thumbnail: ''),
    ),
    User(
      gender: 'female',
      name: UserName(title: 'Ms', first: 'Jane', last: 'Doe'),
      email: 'jane.doe@example.com',
      phone: '098-765-4321',
      picture: UserPicture(large: '', medium: '', thumbnail: ''),
    ),
  ];

  group('UserCubit', () {
    test('initial state is UserInitial', () {
      final cubit = UserCubit(getUsersUseCase: mockGetUsersUseCase);
      expect(cubit.state, UserInitial());
      cubit.close();
    });

    blocTest<UserCubit, UserState>(
      'emits [UserLoading, UserLoaded] when loadUsers succeeds',
      build: () {
        when(mockGetUsersUseCase()).thenAnswer((_) async => tUsers);
        return UserCubit(getUsersUseCase: mockGetUsersUseCase);
      },
      act: (cubit) => cubit.loadUsers(),
      expect: () => [
        UserLoading(),
        UserLoaded(tUsers),
      ],
    );

    blocTest<UserCubit, UserState>(
      'emits [UserLoading, UserError] when loadUsers fails with ServerException',
      build: () {
        when(mockGetUsersUseCase())
            .thenThrow(ServerException(message: 'Server error'));
        return UserCubit(getUsersUseCase: mockGetUsersUseCase);
      },
      act: (cubit) => cubit.loadUsers(),
      expect: () => [
        UserLoading(),
        UserError('ServerException: Server error'), // ✅ FIXED
      ],
    );
  });
}
