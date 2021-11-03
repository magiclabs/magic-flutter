import 'package:magic_sdk/provider/types/rpc_request.dart';
import 'package:json_annotation/json_annotation.dart';

part 'relayer_request.g.dart';

@JsonSerializable(explicitToJson: true)
class RelayerRequest {
  String msgType;
  MagicRPCRequest payload;

  RelayerRequest({required this.msgType, required this.payload});

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory RelayerRequest.fromJson(Map<String, dynamic> json) =>
      _$RelayerRequestFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$RelayerRequestToJson(this);
}
