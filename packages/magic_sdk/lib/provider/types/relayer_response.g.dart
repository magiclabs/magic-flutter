// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'relayer_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RelayerResponse _$RelayerResponseFromJson(Map<String, dynamic> json) =>
    RelayerResponse(
      msgType: json['msgType'] as String,
      response: RPCResponse.fromJson(json['response'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RelayerResponseToJson(RelayerResponse instance) =>
    <String, dynamic>{
      'msgType': instance.msgType,
      'response': instance.response,
    };
