// GENERATED CODE - DO NOT MODIFY BY HAND

part of './public_key.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PublicKey _$PublicKeyFromJson(Map<String, dynamic> json) => PublicKey(
      pk: json['pk'] as String,
      pkh: json['pkh'] as String,
    );

Map<String, dynamic> _$PublicKeyToJson(PublicKey instance) => <String, dynamic>{
      'pk': instance.pk,
      'pkh': instance.pkh,
    };
