import 'dart:math';
import 'package:json_annotation/json_annotation.dart';

part 'rpc_request.g.dart';

@JsonSerializable(genericArgumentFactories: true, explicitToJson: true)
class MagicRPCRequest<T> {
  int id = Random().nextInt(10000);
  String jsonrpc = '2.0';
  String method;
  T params;

  MagicRPCRequest({required this.method, required this.params});

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory MagicRPCRequest.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$MagicRPCRequestFromJson<T>(json, fromJsonT);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) =>
      _$MagicRPCRequestToJson(this, toJsonT);
}
