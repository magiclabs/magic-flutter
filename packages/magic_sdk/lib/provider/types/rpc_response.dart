import 'dart:math';
import 'package:json_annotation/json_annotation.dart';
import 'package:web3dart/json_rpc.dart';

part 'rpc_response.g.dart';

@JsonSerializable(genericArgumentFactories: true, explicitToJson: true)
class MagicRPCResponse<T> extends RPCResponse{
  String jsonrpc;
  RPCError? error;

  MagicRPCResponse({id, result, required this.jsonrpc}): super(id, result);

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
