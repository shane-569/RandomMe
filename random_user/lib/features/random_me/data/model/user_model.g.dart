// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      gender: json['gender'] as String,
      name: UserName.fromJson(json['name'] as Map<String, dynamic>),
      email: json['email'] as String,
      phone: json['phone'] as String,
      picture: UserPicture.fromJson(json['picture'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'gender': instance.gender,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'picture': instance.picture,
    };

UserName _$UserNameFromJson(Map<String, dynamic> json) => UserName(
      title: json['title'] as String,
      first: json['first'] as String,
      last: json['last'] as String,
    );

Map<String, dynamic> _$UserNameToJson(UserName instance) => <String, dynamic>{
      'title': instance.title,
      'first': instance.first,
      'last': instance.last,
    };

UserPicture _$UserPictureFromJson(Map<String, dynamic> json) => UserPicture(
      large: json['large'] as String,
      medium: json['medium'] as String,
      thumbnail: json['thumbnail'] as String,
    );

Map<String, dynamic> _$UserPictureToJson(UserPicture instance) =>
    <String, dynamic>{
      'large': instance.large,
      'medium': instance.medium,
      'thumbnail': instance.thumbnail,
    };
