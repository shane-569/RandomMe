import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart'; // Add part directive for user_model.g.dart

@JsonSerializable() //  <-- ADD THIS ANNOTATION TO UserModel
class UserModel extends Equatable {
  final String gender;
  final UserName name;
  final String email;
  final String phone;
  final UserPicture picture;

  UserModel({
    required this.gender,
    required this.name,
    required this.email,
    required this.phone,
    required this.picture,
  });

  factory UserModel.fromJson(
          Map<String, dynamic> json) => // <-- Add fromJson factory to UserModel
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$UserModelToJson(this); // <-- Add toJson method to UserModel

  @override
  List<Object?> get props => [gender, name, email, phone, picture];
}

@JsonSerializable()
class UserName extends Equatable {
  final String title;
  final String first;
  final String last;

  UserName({required this.title, required this.first, required this.last});

  factory UserName.fromJson(Map<String, dynamic> json) =>
      _$UserNameFromJson(json);
  Map<String, dynamic> toJson() => _$UserNameToJson(this);

  @override
  List<Object?> get props => [title, first, last];
}

@JsonSerializable()
class UserPicture extends Equatable {
  final String large;
  final String medium;
  final String thumbnail;

  UserPicture(
      {required this.large, required this.medium, required this.thumbnail});

  factory UserPicture.fromJson(Map<String, dynamic> json) =>
      _$UserPictureFromJson(json);
  Map<String, dynamic> toJson() => _$UserPictureToJson(this);

  @override
  List<Object?> get props => [large, medium, thumbnail];
}
