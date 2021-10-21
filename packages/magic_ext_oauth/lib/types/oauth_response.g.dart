// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'oauth_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OAuthResponse _$OAuthResponseFromJson(Map<String, dynamic> json) =>
    OAuthResponse(
      json['oauth'] == null
          ? null
          : OAuthPartialResult.fromJson(json['oauth'] as Map<String, dynamic>),
      json['magic'] == null
          ? null
          : MagicPartialResult.fromJson(json['magic'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OAuthResponseToJson(OAuthResponse instance) =>
    <String, dynamic>{
      'oauth': instance.oauth?.toJson(),
      'magic': instance.magic?.toJson(),
    };

OAuthPartialResult _$OAuthPartialResultFromJson(Map<String, dynamic> json) =>
    OAuthPartialResult(
      json['provider'] as String,
      (json['scope'] as List<dynamic>).map((e) => e as String).toList(),
      json['accessToken'] as String,
      json['userHandle'] as String,
      OpenIDConnectProfile.fromJson(json['userInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OAuthPartialResultToJson(OAuthPartialResult instance) =>
    <String, dynamic>{
      'provider': instance.provider,
      'scope': instance.scope,
      'accessToken': instance.accessToken,
      'userHandle': instance.userHandle,
      'userInfo': instance.userInfo.toJson(),
    };

MagicPartialResult _$MagicPartialResultFromJson(Map<String, dynamic> json) =>
    MagicPartialResult(
      json['idToken'] as String,
      UserMetadata.fromJson(json['userMetadata'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MagicPartialResultToJson(MagicPartialResult instance) =>
    <String, dynamic>{
      'idToken': instance.idToken,
      'userMetadata': instance.userMetadata.toJson(),
    };
