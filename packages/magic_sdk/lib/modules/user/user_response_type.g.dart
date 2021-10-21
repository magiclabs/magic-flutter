// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_response_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserMetadata _$UserMetadataFromJson(Map<String, dynamic> json) => UserMetadata(
      issuer: json['issuer'] as String?,
      email: json['email'] as String?,
      publicAddress: json['publicAddress'] as String?,
    );

Map<String, dynamic> _$UserMetadataToJson(UserMetadata instance) =>
    <String, dynamic>{
      'issuer': instance.issuer,
      'email': instance.email,
      'publicAddress': instance.publicAddress,
    };
