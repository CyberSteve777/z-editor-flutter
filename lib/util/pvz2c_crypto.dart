import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';

abstract final class PvZ2Crypto {
  static const int blockSize = 24;

  // MD5 of the raw ASCII string, then UTF8-encode the hex digest
  static Uint8List get keyBytes {
    const raw = 'com_popcap_pvz2_magento_product_2013_05_05';
    final md5Hash = md5.convert(utf8.encode(raw));
    // encode the hex string as UTF8 bytes (matches C# BinaryHelper.GetBytes with EncodingType.UTF8)
    final hexStr = md5Hash.toString(); // e.g. "65bd1b2305f46eb2806b935aab7630bb"
    return Uint8List.fromList(utf8.encode(hexStr));
  }

  // Skip 4 bytes into key, take remaining bytes zero-padded to blockSize
  static Uint8List get ivBytes {
    final key = keyBytes;
    final iv = Uint8List(blockSize);
    final src = key.sublist(4); // skip first 4 bytes
    for (var i = 0; i < src.length && i < blockSize; i++) {
      iv[i] = src[i];
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