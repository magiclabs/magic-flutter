import 'package:json_annotation/json_annotation.dart';

part './public_key.g.dart';

@JsonSerializable(explicitToJson: true)
class PublicKey {
  String pk;
  String pkh;

  PublicKey({required this.pk, required this.pkh});

  factory PublicKey.fromJson(Map<String, dynamic> json) =>
      _$PublicKeyFromJson(json);

  Map<String, dynamic> toJson() => _$PublicKeyToJson(this);
}
