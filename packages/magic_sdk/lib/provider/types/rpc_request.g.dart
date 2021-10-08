// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rpc_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MagicRPCRequest _$MagicRPCRequestFromJson(Map<String, dynamic> json) =>
    MagicRPCRequest(
      method: json['method'] as String,
      params: json['params'] as List<dynamic>,
    )
      ..id = json['id'] as int
      ..jsonrpc = json['jsonrpc'] as String;

Map<String, dynamic> _$MagicRPCRequestToJson(MagicRPCRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'jsonrpc': instance.jsonrpc,
      'method': instance.method,
      'params': instance.params,
    };
