import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/user.dart';
import '../../domain/usecases/get_users_usecase.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final GetUsersUseCase getUsersUseCase;

  UserCubit({required this.getUsersUseCase}) : super(UserInitial());

  Future<void> loadUsers() async {
    emit(UserLoading()); // Emit loading state immediately
    try {
      final users = await getUsersUseCase();
      emit(UserLoaded(users)); // Emit loaded state on success
    } catch (e, stack) {
      emit(UserError(e.toString()));
      print('Caught Exception: $e');
      print('Stacktrace: $stack');
      emit(UserError(e.toString())); // Emit error state on failure
    }
  }
}
