import 'dart:typed_data';

import 'package:archive/archive.dart';

import 'sen_buffer.dart';

/// PopCap-style zlib wrapper: `0xDEADFED4` magic + uncompressed length (+ optional 64-bit padding) + zlib payload.
class PopCapZlib {
  static final Uint8List magic = Uint8List.fromList(
    [0xD4, 0xFE, 0xAD, 0xDE],
  );

  static final Uint8List blank = Uint8List.fromList([0x00, 0x00, 0x00, 0x00]);

  static const ZLibEncoder _zlibEnc = ZLibEncoder();

  static SenBuffer compress(
    SenBuffer data,
    bool use64BitVariant,
  ) {
    final result = SenBuffer();
    result.writeBytes(magic);
    if (use64BitVariant) {
      result.writeBytes(blank);
    }
    result.writeUInt32LE(data.length);
    if (use64BitVariant) {
      result.writeBytes(blank);
    }
    result.writeBytes(
      Uint8List.fromList(
        _zlibEnc.encodeBytes(data.toBytes(), level: 9),
      ),
    );
    return result;
  }

  static SenBuffer uncompress(
    SenBuffer data,
    bool use64BitVariant,
  ) {
    final magicWord = data.readUInt32LE();
    if (magicWord != 0xDEADFED4) {
      throw Exception(
        'Mismatch PopCap Zlib magic, should begin with 0xDEADFED4, received 0x${magicWord.toRadixString(16).toUpperCase()}',
      );
    }
    if (use64BitVariant) {
      data.readUInt32LE();
    }
    data.readUInt32LE();
    if (use64BitVariant) {
      data.readUInt32LE();
      data.readUInt32LE();
    }
    final remaining = data.length - data.readOffset;
    final compressed = data.readBytes(remaining);
    final inflated = const ZLibDecoder().decodeBytes(compressed);
    return SenBuffer.fromBytes(inflated);
  }
}
