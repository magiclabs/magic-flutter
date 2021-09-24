import 'dart:math';
import 'package:json_annotation/json_annotation.dart';

part 'rpc_response.g.dart';

@JsonSerializable()
class RPCResponse {
  int? id;
  String? jsonrpc;
  String? result;
  RPCError? error;

  RPCResponse();

  factory RPCResponse.fromJson(Map<String, dynamic> json) => _$RPCResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RPCResponseToJson(this);
}

@JsonSerializable()
class RPCError {
  int? code;
  String? message;

  RPCError();

  factory RPCError.fromJson(Map<String, dynamic> json) => _$RPCErrorFromJson(json);

  Map<String, dynamic> toJson() => _$RPCErrorToJson(this);
}
