import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/util/colors.dart';
import '../../../../core/util/strings.dart';
import '../bloc/user_cubit.dart';
import '../widgets/user_card.dart';

class UserListScreen extends StatelessWidget {
  const UserListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          sl<UserCubit>()..loadUsers(), // Use UserCubit and call loadUsers()
      child: Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.userListScreenTitle),
          backgroundColor: AppColors.primaryColor,
        ),
        body: BlocBuilder<UserCubit, UserState>(
          // Use BlocBuilder with UserCubit
          builder: (context, state) {
            if (state is UserLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is UserLoaded) {
              return ListView.builder(
                itemCount: state.users.length,
                itemBuilder: (context, index) {
                  return UserCard(user: state.users[index]);
                },
              );
            } else if (state is UserError) {
              return Center(
                  child: Text(
                      '${AppStrings.errorMessageGeneric} ${state.message}'));
            } else {
              return const Center(child: Text('Initial State'));
            }
          },
        ),
      ),
    );
  }
}
