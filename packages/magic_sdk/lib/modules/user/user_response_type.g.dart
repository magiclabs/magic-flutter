// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_response_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecoveryFactor _$RecoveryFactorFromJson(Map<String, dynamic> json) =>
    RecoveryFactor(
      value: json['value'] as String,
      type: json['type'] as String,
    );

Map<String, dynamic> _$RecoveryFactorToJson(RecoveryFactor instance) =>
    <String, dynamic>{
      'value': instance.value,
      'type': instance.type,
    };

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) => UserInfo(
      issuer: json['issuer'] as String?,
      publicAddress: json['publicAddress'] as String?,
      email: json['email'] as String?,
      isMfaEnabled: json['isMfaEnabled'] as bool,
      recoveryFactors: (json['recoveryFactors'] as List<dynamic>)
          .map((e) => RecoveryFactor.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
      'issuer': instance.issuer,
      'publicAddress': instance.publicAddress,
      'email': instance.email,
      'isMfaEnabled': instance.isMfaEnabled,
      'recoveryFactors':
          instance.recoveryFactors.map((e) => e.toJson()).toList(),
    };
