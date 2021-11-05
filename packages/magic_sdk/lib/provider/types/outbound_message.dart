part of '../rpc_provider.dart';

enum OutboundMessageType { MAGIC_HANDLE_REQUEST }

extension ParseOutgoingMsgTypeToString on OutboundMessageType {
  String toShortString() {
    return toString().split('.').last;
  }
}
