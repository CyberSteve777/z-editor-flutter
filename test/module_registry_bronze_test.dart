import 'package:flutter_test/flutter_test.dart';
import 'package:z_editor/data/registry/module_registry.dart';

void main() {
  group('BronzeProperties module metadata', () {
    test('is registered as single-instance (allowMultiple false)', () {
      final meta = ModuleRegistry.registry['BronzeProperties'];
      expect(meta, isNotNull);
      expect(meta!.allowMultiple, isFalse);
    });

    test('is categorized under Scene (not Special Modes)', () {
      final bronze = ModuleRegistry.registry['BronzeProperties'];
      final renai = ModuleRegistry.registry['RenaiModuleProperties'];
      expect(bronze, isNotNull);
      expect(renai, isNotNull);
      expect(bronze!.category, ModuleCategory.scene);
      expect(bronze.category, renai!.category);
    });
  });
}
