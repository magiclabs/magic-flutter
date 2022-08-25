# magic-flutter

> Magic empowers developers to protect their users via an innovative, passwordless authentication flow without the UX compromises that burden traditional OAuth implementations.

## Get started

Install Flutter & Dart https://flutter.dev/docs/get-started/install

## Start the project

```bash
$ cd project_root/magic_demo
$ flutter run
```

Dependency installation is automatically done in the `flutter run` command

For detail integration please check our [official doc](https://magic.link/docs/auth/api-reference/client-side-sdks/flutter)
or README in each package directory 

| Package Name                                                    | Changelog                                             | Description                                                           |
|-----------------------------------------------------------------|-------------------------------------------------------|-----------------------------------------------------------------------|
| [`magic_sdk`](https://pub.dev/packages/magic_sdk)               | [CHANGELOG](./packages/magic_sdk/CHANGELOG.md)        | Flutter entry-point for Magic SDK.                                    |
| [`magic_ext_oauth`](https://pub.dev/packages/magic_ext_oauth)   | [CHANGELOG](./packages/magic_ext/oauth/CHANGELOG.md)  | An Extension to access OAuth providers                                |
| [`magic_ext_tezos`](https://pub.dev/packages/magic_ext_tezos)   | [CHANGELOG](./packages/magic_ext/tezos/CHANGELOG.md)  | Tezos blockchain extension that integrates with Tezart                |
| [`magic_ext_solana`](https://pub.dev/packages/magic_ext_solana) | [CHANGELOG](./packages/magic_ext/solana/CHANGELOG.md) | Solana blockchain extension that integrates with crypto-please/solana |

### Blockchain access

Make sure you have the third-party blockchain dependencies installed
* Tezos via Tezart
* Solana via Crypto-please/solana

You may remove these dependencies if you don't need to access these chains

## Development Caveats

Files ending with `*.g.dart` are auto generated type files that are used to serialize / deserialize a class.
To generate a new sets of files to reflect your changes please run the command below at `your/path/to/magic_sdk`

```bash
$ dart run build_runner build --delete-conflicting-outputs
```

