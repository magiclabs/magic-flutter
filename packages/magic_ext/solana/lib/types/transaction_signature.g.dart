// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_signature.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MgboxTransactionSignature _$MgboxTransactionSignatureFromJson(
        Map<String, dynamic> json) =>
    MgboxTransactionSignature(
      rawTransaction: MgboxTypedArray.fromJson(
          json['rawTransaction'] as Map<String, dynamic>),
      signature: (json['signature'] as List<dynamic>)
          .map((e) => MgboxTypedSignature.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MgboxTransactionSignatureToJson(
        MgboxTransactionSignature instance) =>
    <String, dynamic>{
      'rawTransaction': instance.rawTransaction.toJson(),
      'signature': instance.signature.map((e) => e.toJson()).toList(),
    };

MgboxTypedSignature _$MgboxTypedSignatureFromJson(Map<String, dynamic> json) =>
    MgboxTypedSignature(
      signature:
          MgboxTypedArray.fromJson(json['signature'] as Map<String, dynamic>),
      publicKey: json['publicKey'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$MgboxTypedSignatureToJson(
        MgboxTypedSignature instance) =>
    <String, dynamic>{
      'signature': instance.signature.toJson(),
      'publicKey': instance.publicKey,
    };
