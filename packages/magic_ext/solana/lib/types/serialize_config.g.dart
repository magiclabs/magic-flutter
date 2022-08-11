// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'serialize_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SerializeConfig _$SerializeConfigFromJson(Map<String, dynamic> json) =>
    SerializeConfig(
      requireAllSignatures: json['requireAllSignatures'] as bool? ?? true,
      verifySignatures: json['verifySignatures'] as bool? ?? true,
    );

Map<String, dynamic> _$SerializeConfigToJson(SerializeConfig instance) =>
    <String, dynamic>{
      'requireAllSignatures': instance.requireAllSignatures,
      'verifySignatures': instance.verifySignatures,
    };
