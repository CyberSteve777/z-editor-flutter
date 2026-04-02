import 'dart:typed_data';

import 'package:z_editor/util/3rdParty/sen_buffer.dart';
import 'package:z_editor/util/3rdParty/sen_compiled_text.dart';
import 'package:z_editor/util/pvz2c_crypto.dart';

/// Hujson: ASCII base64 wrapping [CompiledText] (PopCap zlib + AES-CBC + `0x10 0x00` prefix).
class HuJsonCodec {
  static final CompiledText _compiled = CompiledText();

  static Uint8List decode(Uint8List data) {
    final out = _compiled.decode(
      SenBuffer.fromBytes(data),
      RijndaelC.defaultValue(),
      false,
    );
    return out.toBytes();
  }

  static Uint8List encode(Uint8List data) {
    final out = _compiled.encode(
      SenBuffer.fromBytes(data),
      RijndaelC.defaultValue(),
      false,
    );
    return out.toBytes();
  }
}
