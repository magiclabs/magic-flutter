// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rpc_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RPCResponse _$RPCResponseFromJson(Map<String, dynamic> json) => RPCResponse()
  ..id = json['id'] as int?
  ..jsonrpc = json['jsonrpc'] as String?
  ..result = json['result'] as String?
  ..error = json['error'] == null
      ? null
      : RPCError.fromJson(json['error'] as Map<String, dynamic>);

Map<String, dynamic> _$RPCResponseToJson(RPCResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'jsonrpc': instance.jsonrpc,
      'result': instance.result,
      'error': instance.error,
    };

RPCError _$RPCErrorFromJson(Map<String, dynamic> json) => RPCError()
  ..code = json['code'] as int?
  ..message = json['message'] as String?;

Map<String, dynamic> _$RPCErrorToJson(RPCError instance) => <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
    };
