import 'dart:typed_data';

import 'package:json_annotation/json_annotation.dart';

part 'typed_array_for_json.g.dart';

// This helper class takes a JSON format like below
// {"constructor":"Uint8Array","data":"99,53,247","flag":"MAGIC_PAYLOAD_FLAG_TYPED_ARRAY"}}}
// to make Buffer/ TypedArray compatible between languages
@JsonSerializable(explicitToJson: true)
class MgboxTypedArray {
  String constructor;
  String data; // should be in the form of "1,2,3"
  String flag = "MAGIC_PAYLOAD_FLAG_TYPED_ARRAY";

  MgboxTypedArray({required this.data, required this.constructor});

  Uint8List convertToUint8List() {
    var stringList = data.split(',');
    return Uint8List.fromList(stringList.map(int.parse).toList());
  }

  factory MgboxTypedArray.from(Uint8List data) {
    String dataString = data.join(",");
    return MgboxTypedArray(data: dataString, constructor: "Uint8Array");
  }

  factory MgboxTypedArray.fromJson(Map<String, dynamic> json) =>
      _$MgboxTypedArrayFromJson(json);

  Map<String, dynamic> toJson() => _$MgboxTypedArrayToJson(this);
}
