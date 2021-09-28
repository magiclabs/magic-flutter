enum OutgoingMessageType {
  MAGIC_HANDLE_REQUEST
}

enum IncomingMessageType {
  MAGIC_OVERLAY_READY,
  MAGIC_SHOW_OVERLAY,
  MAGIC_HIDE_OVERLAY,
MAGIC_HANDLE_EVENT,
  MAGIC_HANDLE_RESPONSE
}

extension ParseOutgoingMsgTypeToString on OutgoingMessageType {
  String toShortString() {
    return toString().split('.').last;
  }
}

extension ParseIncomingMsgTypeToString on IncomingMessageType {
  String toShortString() {
    return toString().split('.').last;
  }
}
