# magic-flutter

## Get started

Install Flutter & Dart https://flutter.dev/docs/get-started/install

## Development Caveats

Files ending with `*.g.dart` are auto generated type files that are used to serialize / deserialize a class.
To generate a new sets of files to reflect your changes please run the command below at `your/path/to/packages/magic_sdk`

```bash
$ flutter pub run build_runner build --delete-conflicting-outputs
```

## Releasing notes

o test how dart pub publish will work, you can perform a dry run:

```bash
$ dart pub publish --dry-run
```

When you’re ready to publish your package, remove the --dry-run argument:

```bash
$ dart pub publish
```
