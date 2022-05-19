// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignResult _$SignResultFromJson(Map<String, dynamic> json) => SignResult(
      bytes: json['bytes'] as String,
      sig: json['sig'] as String,
      prefixSig: json['prefixSig'] as String,
      sbytes: json['sbytes'] as String,
    );

Map<String, dynamic> _$SignResultToJson(SignResult instance) =>
    <String, dynamic>{
      'bytes': instance.bytes,
      'sig': instance.sig,
      'prefixSig': instance.prefixSig,
      'sbytes': instance.sbytes,
    };
