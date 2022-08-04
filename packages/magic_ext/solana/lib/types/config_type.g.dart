// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SerializeConfig _$SerializeConfigFromJson(Map<String, dynamic> json) =>
    SerializeConfig(
      requireAllSignatures: json['requireAllSignatures'] as bool?,
      verifySignatures: json['verifySignatures'] as bool?,
    );

Map<String, dynamic> _$SerializeConfigToJson(SerializeConfig instance) =>
    <String, dynamic>{
      'requireAllSignatures': instance.requireAllSignatures,
      'verifySignatures': instance.verifySignatures,
    };
