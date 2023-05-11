import 'package:flutter_test/flutter_test.dart';
import 'package:magic_ext_oidc/magic_ext_oidc.dart';
import 'package:magic_ext_oidc/open_id_configuration.dart';
import 'package:magic_sdk/magic_sdk.dart';

void main() {
  setUpAll(() => () {
        Magic.instance = Magic("pk_live_63A5A557D1D4882D");
      });

  test('adds one to input values', () async {
    TestWidgetsFlutterBinding.ensureInitialized();
    Magic.instance = Magic("pk_live_63A5A557D1D4882D");
    Magic magic = Magic.instance;
    String providerId = '-A2JxDIS1zwr5ceLy5HKwxiNL7uWFQPBsKmmkyfmB3s=';
    String jwt =
        'eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6InBNQzNLcTlscFAzNDAwal9JR2llUyJ9.eyJlbWFpbCI6ImpsLnZlZ2Eucm9tZXJvQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJpc3MiOiJodHRwczovL2xvZ2luLWRldi5tYXR0ZWwuY29tLyIsImF1ZCI6Im5zTDlEVDNUemRaOERGZG5ySXBIT2lXNXMyVXRPV2dWIiwiaWF0IjoxNjgzODIxNzc2LCJleHAiOjE2ODM4NTc3NzYsInN1YiI6ImF1dGgwfDEyZjU1Y2YxLTg1ODctNDI3MC1hNmM4LTcyYjg5ZDQ3MDk5YiIsInNpZCI6Ikp3WG1wbzBGZTBRUXhtaVJtbHNtOFc4TlhrazRsTDZNIn0.lJOUCskYX_DJtxtMLViUyAUqFf07oXdbLxcYBVF68Lmxyro1IkiQyoxadeolnBy5ZS_Z9O8aiIdliuCzd0wvhrBQ5kp4_FoWwRGR4lerv0Xoh9mDI7q0-Dm5STQM74P-JdZgdnGfCAkeZtGVz-abiDe6SrvTf8nUjSdKYxccFQivrowxQQoZ2Tp-RhfkOmn1etbhireHE_9aN1bMAzGIy_WJno-uI7c6iurqnotiLhBNizLGZxqt9ngKRAsGG4JQqURTObQ71YWsc7PWYEnQwzzeQIMv6-H2h5h4U7pEPD6c0-uHEnON8S8mbV45tfmTcihRQn9ymFx_CuYVEAfX8w';
    OpenIdConfiguration configuration =
        OpenIdConfiguration(jwt: jwt, providerId: providerId);
    final result = await magic.oidc.loginWithOIDC(configuration);
    print('Login result $result');
  });
}
