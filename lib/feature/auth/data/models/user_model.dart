import 'package:chat_app/feature/auth/domain/entities/user_entity.dart';

class UserModel  extends UserEntity{
  UserModel({required super.id, required super.name, required super.email , super.token});


  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['user']['id'],
      name: json['user']['username'],
      email: json['user']['email'],
      token: json['user']['token'],
    );
  }
}