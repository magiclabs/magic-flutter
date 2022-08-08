import 'package:json_annotation/json_annotation.dart';

part 'config_type.g.dart';

@JsonSerializable(explicitToJson: true)
class SerializeConfig {
  final bool requireAllSignatures;
  final bool verifySignatures;

  const SerializeConfig(
      {this.requireAllSignatures = true, this.verifySignatures = true});

  factory SerializeConfig.fromJson(Map<String, dynamic> json) =>
      _$SerializeConfigFromJson(json);

  Map<String, dynamic> toJson() => _$SerializeConfigToJson(this);
}
