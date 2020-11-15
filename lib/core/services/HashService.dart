import 'dart:convert';
import 'package:crypto/crypto.dart';

class HashService {

  static encode(String toEncode) {

    var bytes = utf8.encode(toEncode);
    var digest = sha256.convert(bytes);

    print("Digest as bytes: ${digest.bytes}");
    print("Digest as hex string: $digest");

  }

}