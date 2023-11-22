# 🔒 Magic Open Id Connect for Flutter

[![<MagicLabs>](https://circleci.com/gh/magiclabs/magic-flutter.svg?style=shield)](https://circleci.com/gh/magiclabs/magic-flutter)

> Magic Open Id Connect SDK extension for Flutter.

<p align="center">
  <a href="https://github.com/magiclabs/magic-flutter/blob/master/packages/magic_ext_oidc/LICENSE">License</a> ·
  <a href="https://github.com/magiclabs/magic-flutter/blob/master/packages/magic_ext_oidc/CHANGELOG.md">Changelog</a> ·
  <a href="https://github.com/magiclabs/magic-flutter/blob/master/CONTRIBUTING.md">Contributing Guide</a>
</p>

## 🔗 Installation

Integrating your Flutter app with Magic will require our Flutter package and the OIDC extension:

```bash
# Via pub.dev:
flutter pub add magic_sdk
flutter pub add magic_ext_oidc
```

## ⚡️ Quick Start

Sign up or log in to the [developer dashboard](https://dashboard.magic.link) to receive API keys that will allow your Flutter application to interact with Magic's APIs.

Request access to this feature sending the API key you want enabled to our customer support.

In your Flutter app, typically in the login screen:


```
import 'package:magic_sdk/magic_sdk.dart';
import 'package:magic_ext_oidc/magic_ext_oidc.dart';

void main() {
  Magic.instance = Magic("YOUR_PUBLISHABLE_KEY");

  // Use the OIDC extension to perform login
  var didToken = await magic.openid.loginWithOIDC(OpenIdConfiguration(
    jwt: yourOpenIdJwt, // Aquired from your OpenID provider
    providerId: yourMagicProviderId, // Aquired from Magic, please contact support for this id
  ));
  
  // Use the DID token for further authentication or requests
  print('DID Token: $didToken');
}
```
