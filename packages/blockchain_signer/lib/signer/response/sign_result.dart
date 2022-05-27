import 'package:json_annotation/json_annotation.dart';

part './sign_result.g.dart';

@JsonSerializable(explicitToJson: true)
class SignResult {
  // https://github.com/ecadlabs/taquito/blob/e5c9dcc54b5a806dbe7c0d0a2e8232a8bcde2074/packages/taquito-utils/src/taquito-utils.ts#L56
  // signature is hex 64

  /// b58c encoded signature from bytes hash
  String sig; // b58cencode(signature, prefix.sig),
  String prefixSig; // b58cencode(signature, pref[this.curve].sig),
  String bytes; // Original bytes
  String sbytes; // bytes + hex signature

  SignResult({required this.bytes, required this.sig, required this.prefixSig, required this.sbytes});

  factory SignResult.fromJson(Map<String, dynamic> json) =>
      _$SignResultFromJson(json);

  Map<String, dynamic> toJson() => _$SignResultToJson(this);
}
