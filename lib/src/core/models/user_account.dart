import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user_account.g.dart';

@JsonSerializable(explicitToJson: true)
@HiveType(typeId: 1)
class UserAccount extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String email;

  @HiveField(2)
  late String password;

  @HiveField(3)
  late String? token;

  UserAccount({
    required this.id,
    required this.email,
    required this.password,
    this.token,
  });

  factory UserAccount.fromJson(Map<String, dynamic> data) =>
      _$UserAccountFromJson(data);

  Map<String, dynamic> toJson() => _$UserAccountToJson(this);
}
