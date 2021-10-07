// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rpc_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MagicRPCResponse<T> _$MagicRPCResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    MagicRPCResponse<T>(
      id: json['id'] as int,
      jsonrpc: json['jsonrpc'] as String,
    )
      ..result = _$nullableGenericFromJson(json['result'], fromJsonT)
      ..error = json['error'] == null
          ? null
          : RPCError.fromJson(json['error'] as Map<String, dynamic>);

Map<String, dynamic> _$MagicRPCResponseToJson<T>(
  MagicRPCResponse<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'id': instance.id,
      'jsonrpc': instance.jsonrpc,
      'result': _$nullableGenericToJson(instance.result, toJsonT),
      'error': instance.error?.toJson(),
    };

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) =>
    input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) =>
    input == null ? null : toJson(input);

RPCError _$RPCErrorFromJson(Map<String, dynamic> json) => RPCError()
  ..code = json['code'] as int?
  ..message = json['message'] as String?;

Map<String, dynamic> _$RPCErrorToJson(RPCError instance) => <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
    };
