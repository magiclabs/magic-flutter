import 'package:json_annotation/json_annotation.dart';

part 'user_response_type.g.dart';

@JsonSerializable(explicitToJson: true)
class UserMetadata {
  String? issuer;
  String? email;
  String? publicAddress;

  UserMetadata(
      {required this.issuer, required this.email, required this.publicAddress});

  factory UserMetadata.fromJson(Map<String, dynamic> json) =>
      _$UserMetadataFromJson(json);

  Map<String, dynamic> toJson() => _$UserMetadataToJson(this);
}
