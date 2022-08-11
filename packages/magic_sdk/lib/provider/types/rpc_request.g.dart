// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rpc_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MagicRPCRequest<T> _$MagicRPCRequestFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    MagicRPCRequest<T>(
      method: json['method'] as String,
      params: fromJsonT(json['params']),
    )
      ..id = json['id'] as int
      ..jsonrpc = json['jsonrpc'] as String;

Map<String, dynamic> _$MagicRPCRequestToJson<T>(
  MagicRPCRequest<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'id': instance.id,
      'jsonrpc': instance.jsonrpc,
      'method': instance.method,
      'params': toJsonT(instance.params),
    };
