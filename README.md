# magic-flutter

> Magic empowers developers to protect their users via an innovative, passwordless authentication flow without the UX compromises that burden traditional OAuth implementations.

## Get started

Install Flutter & Dart https://flutter.dev/docs/get-started/install

## Start the project

Make sure you have the third-party blockchain dependencies installed
* Tezos via Tezart
* Solana via Crypto-please/solana

```bash
$ cd project_root/magic_demo
$ flutter run
```

Dependency installation is done in the `flutter run` process

## Development Caveats

Files ending with `*.g.dart` are auto generated type files that are used to serialize / deserialize a class.
To generate a new sets of files to reflect your changes please run the command below at `your/path/to/packages/magic_sdk`

```bash
$ dart run build_runner build --delete-conflicting-outputs
```

