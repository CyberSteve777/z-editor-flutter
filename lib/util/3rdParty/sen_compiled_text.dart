// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:typed_data';

import 'package:rijndael/rijndael.dart';
import 'package:z_editor/util/pvz2c_crypto.dart';

import 'sen_buffer.dart';
import 'sen_popcap_zlib.dart';

/// Hot-update style asset: base64( `[0x10, 0x00]` + AES-CBC(PopCap-zlib(payload)) ).
class CompiledText {
  RijndaelCbc _cipher(RijndaelC cfg) => RijndaelCbc(
        cfg.keyBytes,
        cfg.ivBytes,
        ZeroPadding(PvZ2Crypto.blockSize),
        blockSize: PvZ2Crypto.blockSize,
      );

  SenBuffer decode(
    SenBuffer raw,
    RijndaelC rijndael,
    bool use64BitVariant,
  ) {
    final decoded = base64Decode(ascii.decode(raw.toBytes()));
    final buf = SenBuffer.fromBytes(Uint8List.fromList(decoded));
    final cipherBytes = buf.getBytes(buf.length - 2, 2);
    final plain = _cipher(rijndael).decrypt(cipherBytes);
    return PopCapZlib.uncompress(
      SenBuffer.fromBytes(plain),
      use64BitVariant,
    );
  }

  SenBuffer encode(
    SenBuffer raw,
    RijndaelC rijndael,
    bool use64BitVariant,
  ) {
    final compressed = PopCapZlib.compress(raw, use64BitVariant);
    final enc = _cipher(rijndael).encrypt(compressed.toBytes());
    final prefixed = Uint8List(2 + enc.length)
      ..[0] = 0x10
      ..[1] = 0x00
      ..setRange(2, 2 + enc.length, enc);
    return SenBuffer.fromBytes(ascii.encode(base64Encode(prefixed)));
  }

  static void encode_fs(
    String inFile,
    String outFile,
    RijndaelC rijndael,
    bool use64BitVariant,
  ) {
    final compiledText = CompiledText();
    final data = compiledText.encode(
      SenBuffer.OpenFile(inFile),
      rijndael,
      use64BitVariant,
    );
    data.outFile(outFile);
  }

  static void decode_fs(
    String inFile,
    String outFile,
    RijndaelC rijndael,
    bool use64BitVariant,
  ) {
    final compiledText = CompiledText();
    final data = compiledText.decode(
      SenBuffer.OpenFile(inFile),
      rijndael,
      use64BitVariant,
    );
    data.outFile(outFile);
  }
}
