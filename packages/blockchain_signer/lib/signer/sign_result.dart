import 'package:json_annotation/json_annotation.dart';

part 'sign_result.g.dart';

@JsonSerializable(explicitToJson: true)
class SignResult {
  String bytes;
  String sig;
  String prefixSig;
  String sbytes;

  SignResult({required this.bytes, required this.sig, required this.prefixSig, required this.sbytes});

  factory SignResult.fromJson(Map<String, dynamic> json) =>
      _$SignResultFromJson(json);

  Map<String, dynamic> toJson() => _$SignResultToJson(this);
}
