# magic-flutter

## Get started

Install Flutter & Dart https://flutter.dev/docs/get-started/install

## Start the project
Dependency installation is included in the `flutter run` process

```bash
$ cd project_root/magic_demo
$ flutter run
```

## Development Caveats

Files ending with `*.g.dart` are auto generated type files that are used to serialize / deserialize a class.
To generate a new sets of files to reflect your changes please run the command below at `your/path/to/packages/magic_sdk`

```bash
$ flutter pub run build_runner build --delete-conflicting-outputs
```

## Releasing notes

Before creating a PR, please go to the `/packages` folder and run the pre-publishing check 

```bash
$ sh ./pre-publish.sh
```

It will do score check and auto formatting with dart standard. Make sure the score is at least 110/120 and then you may commit the change and send the PR.

---
To test how dart pub publish will work, you can perform a dry run:

```bash
$ dart pub publish --dry-run
```

When you’re ready to publish your package, remove the --dry-run argument:

```bash
$ dart pub publish
```
