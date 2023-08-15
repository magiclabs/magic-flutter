import 'package:magic_sdk/provider/types/rpc_request.dart';
import 'package:json_annotation/json_annotation.dart';

part 'relayer_request.g.dart';

@JsonSerializable(genericArgumentFactories: true, explicitToJson: true)
class RelayerRequest<T> {
  String msgType;
  MagicRPCRequest<T> payload;
  String? rt; 
  String? jwt;

  RelayerRequest({required this.msgType, required this.payload, this.rt, this.jwt});

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory RelayerRequest.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$RelayerRequestFromJson<T>(json, fromJsonT);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$RelayerRequestToJson(this, toJsonT);
}
