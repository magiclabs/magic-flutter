// ignore_for_file: directives_ordering
// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:build_runner_core/build_runner_core.dart' as _i1;
import 'package:json_serializable/builder.dart' as _i2;
import 'package:source_gen/builder.dart' as _i3;
import 'package:web3dart/src/builder/builders.dart' as _i4;
import 'package:build/build.dart' as _i5;
import 'dart:isolate' as _i6;
import 'package:build_runner/build_runner.dart' as _i7;
import 'dart:io' as _i8;

final _builders = <_i1.BuilderApplication>[
  _i1.apply(r'json_serializable:json_serializable', [_i2.jsonSerializable],
      _i1.toDependentsOf(r'json_serializable'),
      hideOutput: true,
      appliesBuilders: const [r'source_gen:combining_builder']),
  _i1.apply(r'source_gen:combining_builder', [_i3.combiningBuilder],
      _i1.toNoneByDefault(),
      hideOutput: false, appliesBuilders: const [r'source_gen:part_cleanup']),
  _i1.apply(r'web3dart:abi_generator', [_i4.abiGenerator],
      _i1.toDependentsOf(r'web3dart'),
      hideOutput: false,
      appliesBuilders: const [r'web3dart:delete_abi_source']),
  _i1.applyPostProcess(r'source_gen:part_cleanup', _i3.partCleanup),
  _i1.applyPostProcess(r'web3dart:delete_abi_source', _i4.deleteSource,
      defaultReleaseOptions:
          const _i5.BuilderOptions(<String, dynamic>{r'enabled': true}))
];
void main(List<String> args, [_i6.SendPort? sendPort]) async {
  var result = await _i7.run(args, _builders);
  sendPort?.send(result);
  _i8.exitCode = result;
}
