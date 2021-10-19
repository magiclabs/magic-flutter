// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'relayer_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RelayerRequest _$RelayerRequestFromJson(Map<String, dynamic> json) =>
    RelayerRequest(
      msgType: json['msgType'] as String,
      payload:
          MagicRPCRequest.fromJson(json['payload'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RelayerRequestToJson(RelayerRequest instance) =>
    <String, dynamic>{
      'msgType': instance.msgType,
      'payload': instance.payload.toJson(),
    };
