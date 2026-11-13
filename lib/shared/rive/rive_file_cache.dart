import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:medcare_breathing/shared/rive/rive_contract.dart';
import 'package:rive/rive.dart' as rive;

@lazySingleton
class RiveFileCache {
  Future<rive.File?>? _file;

  Future<rive.File?> get file => _file ??= _load();

  Future<rive.File?> _load() async {
    try {
      return await rive.File.asset(
        RiveContract.asset,
        riveFactory: rive.Factory.rive,
      );
    } on Object catch (error) {
      debugPrint('Rive file unavailable: $error');
      return null;
    }
  }
}
