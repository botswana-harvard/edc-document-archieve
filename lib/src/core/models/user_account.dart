import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
part 'gen/user_account.g.dart';

@JsonSerializable(explicitToJson: true)
@HiveType(typeId: 1)
class UserAccount extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String username;

  @HiveField(2)
  final String password;

  @HiveField(3)
  final String token;

  UserAccount({
    required this.id,
    required this.username,
    required this.password,
    required this.token,
  });

  factory UserAccount.fromJson(Map<String, dynamic> data) =>
      _$UserAccountFromJson(data);

  Map<String, dynamic> toJson() => _$UserAccountToJson(this);
}
