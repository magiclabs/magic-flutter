import 'package:json_annotation/json_annotation.dart';

part 'user_response_type.g.dart';

@JsonSerializable(explicitToJson: true)
class RecoveryFactor {
  String value;
  String type;

  RecoveryFactor({required this.value, required this.type});

  factory RecoveryFactor.fromJson(Map<String, dynamic> json) =>
      _$RecoveryFactorFromJson(json);

  Map<String, dynamic> toJson() => _$RecoveryFactorToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UserInfo {
  String? issuer;
  String? publicAddress;
  String? email;
  bool isMfaEnabled;
  List<RecoveryFactor> recoveryFactors;

  UserInfo({
    required this.issuer,
    required this.publicAddress,
    required this.email,
    required this.isMfaEnabled,
    required this.recoveryFactors,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);

  Map<String, dynamic> toJson() => _$UserInfoToJson(this);
}