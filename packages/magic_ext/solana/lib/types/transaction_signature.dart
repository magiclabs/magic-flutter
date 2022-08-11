import 'dart:convert';
import 'dart:typed_data';

import 'package:json_annotation/json_annotation.dart';
import 'package:magic_sdk/utils/typed_array_for_json.dart';
import 'package:solana/src/encoder/compact_array.dart';
import 'package:solana/encoder.dart';

part 'transaction_signature.g.dart';

/// @field [rawTransaction] rawTransaction in Typed Array
/// @field [signature] signature from
/// @field [messageBytes] compiled Message / instructions
class TransactionSignature {
  Uint8List rawTransaction;
  List<SolanaSignature> signature;
  ByteArray messageBytes;

  TransactionSignature(
      {required this.messageBytes,
      required this.rawTransaction,
      required this.signature});

  String encode() => base64.encode(_data.toList());

  late final ByteArray _data = ByteArray.merge([
    CompactArray.fromIterable(signature.map((e) => ByteArray(e.signature)))
        .toByteArray(),
    messageBytes,
  ]);
}

class SolanaSignature {
  Uint8List signature;
  Map<String, dynamic> publicKey;

  SolanaSignature({required this.signature, required this.publicKey});
}

@JsonSerializable(explicitToJson: true)
class MgboxTransactionSignature {
  MgboxTypedArray rawTransaction;
  List<MgboxTypedSignature> signature;

  MgboxTransactionSignature(
      {required this.rawTransaction, required this.signature});

  factory MgboxTransactionSignature.fromJson(Map<String, dynamic> json) =>
      _$MgboxTransactionSignatureFromJson(json);

  Map<String, dynamic> toJson() => _$MgboxTransactionSignatureToJson(this);
}

@JsonSerializable(explicitToJson: true)
class MgboxTypedSignature {
  MgboxTypedArray signature;
  Map<String, dynamic> publicKey;

  MgboxTypedSignature({required this.signature, required this.publicKey});

  factory MgboxTypedSignature.fromJson(Map<String, dynamic> json) =>
      _$MgboxTypedSignatureFromJson(json);

  Map<String, dynamic> toJson() => _$MgboxTypedSignatureToJson(this);
}
