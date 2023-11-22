import 'package:json_annotation/json_annotation.dart';
import 'package:magic_sdk/modules/user/user_response_type.dart';

import 'oid_type.dart';

part 'oauth_response.g.dart';

@JsonSerializable(explicitToJson: true)
class MagicPartialResult {
  String? idToken;
  UserInfo? userInfo;

  MagicPartialResult(this.idToken, this.userInfo);

  factory MagicPartialResult.fromJson(Map<String, dynamic> json) =>
      _$MagicPartialResultFromJson(json);

  Map<String, dynamic> toJson() => _$MagicPartialResultToJson(this);
}

@JsonSerializable(explicitToJson: true)
class OAuthPartialResult {
  String? provider;
  List<String>? scope;
  String? accessToken;
  String? userHandle;
  OpenIDConnectProfile? userInfo;

  OAuthPartialResult(this.provider, this.scope, this.accessToken,
      this.userHandle, this.userInfo);

  factory OAuthPartialResult.fromJson(Map<String, dynamic> json) =>
      _$OAuthPartialResultFromJson(json);

  Map<String, dynamic> toJson() => _$OAuthPartialResultToJson(this);
}

@JsonSerializable(explicitToJson: true)
class OAuthResponse {
  OAuthPartialResult? oauth;
  MagicPartialResult? magic;

  OAuthResponse(this.oauth, this.magic);

  factory OAuthResponse.fromJson(Map<String, dynamic> json) =>
      _$OAuthResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OAuthResponseToJson(this);
}
