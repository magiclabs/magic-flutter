import 'package:json_annotation/json_annotation.dart';

part 'user_response.g.dart';

@JsonSerializable(explicitToJson: true)
class UserMetadata {
  String? issuer;
  String? email;
  String? publicAddress;

  UserMetadata({required this.issuer, required this.email, required this.publicAddress});

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory UserMetadata.fromJson(Map<String, dynamic> json) => _$UserMetadataFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$UserMetadataToJson(this);
}
