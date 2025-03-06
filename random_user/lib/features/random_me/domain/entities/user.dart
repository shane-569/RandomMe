import 'package:equatable/equatable.dart';

class User extends Equatable {
  // Extend Equatable directly
  final String gender;
  final UserName name;
  final String email;
  final String phone;
  final UserPicture picture;

  User({
    required this.gender,
    required this.name,
    required this.email,
    required this.phone,
    required this.picture,
  });

  @override
  List<Object?> get props =>
      [gender, name, email, phone, picture]; // Override props
}

class UserName extends Equatable {
  // Extend Equatable directly
  final String title;
  final String first;
  final String last;

  UserName({required this.title, required this.first, required this.last});

  @override
  List<Object?> get props => [title, first, last]; // Override props

  factory UserName.fromJson(Map<String, dynamic> json) {
    return UserName(
      title: json['title'],
      first: json['first'],
      last: json['last'],
    );
  }
}

class UserPicture extends Equatable {
  // Extend Equatable directly
  final String large;
  final String medium;
  final String thumbnail;

  UserPicture(
      {required this.large, required this.medium, required this.thumbnail});

  @override
  List<Object?> get props => [large, medium, thumbnail]; // Override props

  factory UserPicture.fromJson(Map<String, dynamic> json) {
    return UserPicture(
      large: json['large'],
      medium: json['medium'],
      thumbnail: json['thumbnail'],
    );
  }
}
