// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'relayer_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RelayerResponse<T> _$RelayerResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    RelayerResponse<T>(
      msgType: json['msgType'] as String,
      response: MagicRPCResponse<T>.fromJson(
          json['response'] as Map<String, dynamic>,
          (value) => fromJsonT(value)),
      rt: json['rt'] as String?,
    );

Map<String, dynamic> _$RelayerResponseToJson<T>(
  RelayerResponse<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'msgType': instance.msgType,
      'response': instance.response.toJson(
        (value) => toJsonT(value),
      ),
      'rt': instance.rt,
    };
