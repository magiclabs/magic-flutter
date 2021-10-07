import 'dart:math';
import 'package:json_annotation/json_annotation.dart';

part 'rpc_response.g.dart';

@JsonSerializable(genericArgumentFactories: true, explicitToJson: true)
class MagicRPCResponse<T> {
  int id;
  String jsonrpc;
  T? result;
  RPCError? error;

  MagicRPCResponse({required this.id, required this.jsonrpc});

  factory MagicRPCResponse.fromJson(Map<String, dynamic> json, T Function(Object? json) fromJsonT) => _$MagicRPCResponseFromJson<T>(json, fromJsonT);

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) => _$MagicRPCResponseToJson(this, toJsonT);
}

@JsonSerializable()
class RPCError {
  int? code;
  String? message;

  RPCError();

  factory RPCError.fromJson(Map<String, dynamic> json) => _$RPCErrorFromJson(json);

  Map<String, dynamic> toJson() => _$RPCErrorToJson(this);
}
