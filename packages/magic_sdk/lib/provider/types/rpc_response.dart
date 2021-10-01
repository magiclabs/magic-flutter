import 'dart:math';
import 'package:json_annotation/json_annotation.dart';

part 'rpc_response.g.dart';

@JsonSerializable(genericArgumentFactories: true, explicitToJson: true)
class RPCResponse<T> {
  int id;
  String jsonrpc;
  T? result;
  RPCError? error;

  RPCResponse({required this.id, required this.jsonrpc});

  factory RPCResponse.fromJson(Map<String, dynamic> json, T Function(Object? json) fromJsonT) => _$RPCResponseFromJson<T>(json, fromJsonT);

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) => _$RPCResponseToJson(this, toJsonT);
}

@JsonSerializable()
class RPCError {
  int? code;
  String? message;

  RPCError();

  factory RPCError.fromJson(Map<String, dynamic> json) => _$RPCErrorFromJson(json);

  Map<String, dynamic> toJson() => _$RPCErrorToJson(this);
}
