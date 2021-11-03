import '../../provider/types/rpc_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'relayer_response.g.dart';

@JsonSerializable(genericArgumentFactories: true, explicitToJson: true)
class RelayerResponse<T> {
  String msgType;
  MagicRPCResponse<T> response;

  RelayerResponse({required this.msgType, required this.response});

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory RelayerResponse.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$RelayerResponseFromJson<T>(json, fromJsonT);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$RelayerResponseToJson(this, toJsonT);
}
