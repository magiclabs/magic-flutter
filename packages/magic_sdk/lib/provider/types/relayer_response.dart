import 'package:magic_sdk/provider/types/rpc_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'relayer_response.g.dart';

@JsonSerializable()
class RelayerResponse {
  String msgType;
  RPCResponse response;

  RelayerResponse({required this.msgType, required this.response});

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory RelayerResponse.fromJson(Map<String, dynamic> json) => _$RelayerResponseFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$RelayerResponseToJson(this);
}
