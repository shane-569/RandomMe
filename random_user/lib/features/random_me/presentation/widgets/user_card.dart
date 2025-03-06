import 'package:flutter/material.dart';

import '../../domain/entities/user.dart';

class UserCard extends StatelessWidget {
  final User user;
  const UserCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(user.picture.large),
              ),
            ),
            const SizedBox(height: 10),
            Text(
                'Name: ${user.name.title} ${user.name.first} ${user.name.last}',
                style: const TextStyle(fontWeight: FontWeight.bold)),
            Text('Gender: ${user.gender}'),
            Text('Email: ${user.email}'),
            Text('Phone: ${user.phone}'),
          ],
        ),
      ),
    );
  }
}
