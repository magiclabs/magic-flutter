// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'typed_array_for_json.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MgboxTypedArray _$MgboxTypedArrayFromJson(Map<String, dynamic> json) =>
    MgboxTypedArray(
      data: json['data'] as String,
      constructor: json['constructor'] as String,
    )..flag = json['flag'] as String;

Map<String, dynamic> _$MgboxTypedArrayToJson(MgboxTypedArray instance) =>
    <String, dynamic>{
      'constructor': instance.constructor,
      'data': instance.data,
      'flag': instance.flag,
    };
