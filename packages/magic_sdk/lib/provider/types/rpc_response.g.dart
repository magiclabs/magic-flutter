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
      id: json['id'],
      result: json['result'],
      jsonrpc: json['jsonrpc'] as String,
    )..error = json['error'] == null
        ? null
        : RPCError.fromJson(json['error'] as Map<String, dynamic>);

Map<String, dynamic> _$MagicRPCResponseToJson<T>(
  MagicRPCResponse<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'id': instance.id,
      'result': instance.result,
      'jsonrpc': instance.jsonrpc,
      'error': instance.error?.toJson(),
    };

RPCError _$RPCErrorFromJson(Map<String, dynamic> json) => RPCError()
  ..code = json['code'] as int?
  ..message = json['message'] as String?;

Map<String, dynamic> _$RPCErrorToJson(RPCError instance) => <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
    };
