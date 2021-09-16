class RPCRequest {
  late num id;
  String jsonrpc = '2.0';
  String method;
  List<dynamic> params;

  RPCRequest({required this.method, required this.params}) {
    id = 1;
  }
}
