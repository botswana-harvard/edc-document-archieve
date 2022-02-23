// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../user_account.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAccountAdapter extends TypeAdapter<UserAccount> {
  @override
  final int typeId = 1;

  @override
  UserAccount read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserAccount(
      id: fields[0] as String,
      email: fields[1] as String,
      password: fields[2] as String,
      token: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, UserAccount obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.password)
      ..writeByte(3)
      ..write(obj.token);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAccountAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserAccount _$UserAccountFromJson(Map<String, dynamic> json) => UserAccount(
      id: json['id'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      token: json['token'] as String?,
    );

Map<String, dynamic> _$UserAccountToJson(UserAccount instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'password': instance.password,
      'token': instance.token,
    };
