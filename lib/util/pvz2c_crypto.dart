import 'dart:typed_data';

import 'package:convert/convert.dart' as convert;

/// AES-128 key material and IV for hot-update encrypted assets (hujson / encrypted RTON).
///
/// Key: 32 hex chars → 16 bytes. IV: hex-decode [keyHex.substring(4, 28)] (12 bytes), zero-padded to 16 bytes (block size).
abstract final class PvZ2Crypto {
  static const String keyHex = '65bd1b2305f46eb2806b935aab7630bb';

  static const int blockSize = 24;

  static Uint8List get keyBytes =>
      Uint8List.fromList(convert.hex.decode(keyHex));

  static Uint8List get ivBytes {
    final slice = keyHex.substring(4, keyHex.length);
    final decoded = convert.hex.decode(slice);
    final iv = Uint8List(blockSize);
    for (var i = 0; i < decoded.length && i < blockSize; i++) {
      iv[i] = decoded[i];
    }
    return iv;
  }
}

class RijndaelC {
  final Uint8List keyBytes;
  final Uint8List ivBytes;

  RijndaelC(this.keyBytes, this.ivBytes);

  factory RijndaelC.defaultValue() => RijndaelC(
    PvZ2Crypto.keyBytes,
    PvZ2Crypto.ivBytes,
  );
}
