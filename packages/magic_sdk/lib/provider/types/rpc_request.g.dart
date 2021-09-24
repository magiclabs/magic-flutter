// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rpc_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RPCRequest _$RPCRequestFromJson(Map<String, dynamic> json) => RPCRequest(
      method: json['method'] as String,
      params: json['params'] as List<dynamic>,
    )
      ..id = json['id'] as int
      ..jsonrpc = json['jsonrpc'] as String;

Map<String, dynamic> _$RPCRequestToJson(RPCRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'jsonrpc': instance.jsonrpc,
      'method': instance.method,
      'params': instance.params,
    };
