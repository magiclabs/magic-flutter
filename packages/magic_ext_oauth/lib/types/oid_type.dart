import 'package:json_annotation/json_annotation.dart';

part 'oid_type.g.dart';

@JsonSerializable(explicitToJson: true)
class OpenIDConnectProfile {
  String? name;
  String? familyName;
  String? givenName;
  String? middleName;
  String? nickname;
  String? preferredUsername;
  String? profile;
  String? picture;
  String? website;
  String? gender;
  String? birthdate;
  String? zoneinfo;
  String? locale;
  int? updatedAt;

  // OpenIDConnectEmail
  String? email;
  bool? emailVerified;

  // OpenIDConnectPhone
  String? phoneNumber;
  bool? phoneNumberVerified;

  // OpenIDConnectAddress
  OIDAddress? address;

  OpenIDConnectProfile(
      this.name,
      this.familyName,
      this.nickname,
      this.givenName,
      this.middleName,
      this.preferredUsername,
      this.profile,
      this.picture,
      this.website,
      this.gender,
      this.birthdate,
      this.zoneinfo,
      this.locale,
      this.updatedAt,
      this.email,
      this.emailVerified,
      this.phoneNumber,
      this.phoneNumberVerified,
      this.address);

  factory OpenIDConnectProfile.fromJson(Map<String, dynamic> json) =>
      _$OpenIDConnectProfileFromJson(json);

  Map<String, dynamic> toJson() => _$OpenIDConnectProfileToJson(this);
}

// OIDAddress
@JsonSerializable(explicitToJson: true)
class OIDAddress {
  String? formatted;
  String? streetAddress;
  String? locality;
  String? region;
  String? postalCode;
  String? country;

  OIDAddress(
      this.formatted,
      this.streetAddress,
      this.locality,
      this.region,
      this.postalCode,
      this.country
      );

  factory OIDAddress.fromJson(Map<String, dynamic> json) =>
      _$OIDAddressFromJson(json);

  Map<String, dynamic> toJson() => _$OIDAddressToJson(this);
}
