part of '../../relayer/webview.dart';

enum InboundMessageType {
  MAGIC_OVERLAY_READY,
  MAGIC_SHOW_OVERLAY,
  MAGIC_HIDE_OVERLAY,
  MAGIC_HANDLE_EVENT,
  MAGIC_HANDLE_RESPONSE
}

extension ParseIncomingMsgTypeToString on InboundMessageType {
  String toShortString() {
    return toString().split('.').last;
  }
}
