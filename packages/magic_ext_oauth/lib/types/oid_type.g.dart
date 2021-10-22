// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'oid_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OpenIDConnectProfile _$OpenIDConnectProfileFromJson(
        Map<String, dynamic> json) =>
    OpenIDConnectProfile(
      json['name'] as String?,
      json['familyName'] as String?,
      json['nickname'] as String?,
      json['givenName'] as String?,
      json['middleName'] as String?,
      json['preferredUsername'] as String?,
      json['profile'] as String?,
      json['picture'] as String?,
      json['website'] as String?,
      json['gender'] as String?,
      json['birthdate'] as String?,
      json['zoneinfo'] as String?,
      json['locale'] as String?,
      json['updatedAt'] as int?,
      json['email'] as String?,
      json['emailVerified'] as bool?,
      json['phoneNumber'] as String?,
      json['phoneNumberVerified'] as bool?,
      json['address'] == null
          ? null
          : OIDAddress.fromJson(json['address'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OpenIDConnectProfileToJson(
        OpenIDConnectProfile instance) =>
    <String, dynamic>{
      'name': instance.name,
      'familyName': instance.familyName,
      'givenName': instance.givenName,
      'middleName': instance.middleName,
      'nickname': instance.nickname,
      'preferredUsername': instance.preferredUsername,
      'profile': instance.profile,
      'picture': instance.picture,
      'website': instance.website,
      'gender': instance.gender,
      'birthdate': instance.birthdate,
      'zoneinfo': instance.zoneinfo,
      'locale': instance.locale,
      'updatedAt': instance.updatedAt,
      'email': instance.email,
      'emailVerified': instance.emailVerified,
      'phoneNumber': instance.phoneNumber,
      'phoneNumberVerified': instance.phoneNumberVerified,
      'address': instance.address?.toJson(),
    };

OIDAddress _$OIDAddressFromJson(Map<String, dynamic> json) => OIDAddress(
      json['formatted'] as String?,
      json['streetAddress'] as String?,
      json['locality'] as String?,
      json['region'] as String?,
      json['postalCode'] as String?,
      json['country'] as String?,
    );

Map<String, dynamic> _$OIDAddressToJson(OIDAddress instance) =>
    <String, dynamic>{
      'formatted': instance.formatted,
      'streetAddress': instance.streetAddress,
      'locality': instance.locality,
      'region': instance.region,
      'postalCode': instance.postalCode,
      'country': instance.country,
    };
