// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'relayer_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RelayerRequest<T> _$RelayerRequestFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    RelayerRequest<T>(
      msgType: json['msgType'] as String,
      payload: MagicRPCRequest<T>.fromJson(
          json['payload'] as Map<String, dynamic>, (value) => fromJsonT(value)),
      rt: json['rt'] as String?,
      jwt: json['jwt'] as String?,
    );

Map<String, dynamic> _$RelayerRequestToJson<T>(
  RelayerRequest<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'msgType': instance.msgType,
      'payload': instance.payload.toJson(
        (value) => toJsonT(value),
      ),
      'rt': instance.rt,
      'jwt': instance.jwt,
    };
