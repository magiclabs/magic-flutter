import 'dart:math';
import 'package:json_annotation/json_annotation.dart';

part 'rpc_request.g.dart';

@JsonSerializable()
class MagicRPCRequest {
  int id = Random().nextInt(1000);
  String jsonrpc = '2.0';
  String method;
  List<dynamic> params;

  MagicRPCRequest({required this.method, required this.params});

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory MagicRPCRequest.fromJson(Map<String, dynamic> json) =>
      _$MagicRPCRequestFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$MagicRPCRequestToJson(this);
}
