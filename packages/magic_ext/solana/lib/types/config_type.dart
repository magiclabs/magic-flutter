import 'package:json_annotation/json_annotation.dart';

part 'config_type.g.dart';

@JsonSerializable(explicitToJson: true)
class SerializeConfig {
  bool? requireAllSignatures;
  bool? verifySignatures;

  SerializeConfig({this.requireAllSignatures, this.verifySignatures});

  factory SerializeConfig.fromJson(Map<String, dynamic> json) =>
  _$SerializeConfigFromJson(json);

  Map<String, dynamic> toJson() => _$SerializeConfigToJson(this);
}
