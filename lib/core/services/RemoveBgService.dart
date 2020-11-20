import 'dart:convert';
import 'dart:ffi';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class RemoveBgService extends ChangeNotifier {

  String apiKey = "h5scqjKqQnyiUXHWndRwWS2g";

  Future<Uint8List> getImage(String assetPath) async {

    ByteData bytes = await rootBundle.load(assetPath);
    var buffer = bytes.buffer;
    var m = base64.encode(Uint8List.view(buffer));
    final body = {"image_file_b64": m, "size": "auto"};
    final headers = {"X-API-Key": this.apiKey};
    final response = await http.post(
      'https://api.remove.bg/v1.0/removebg',
      headers: headers,
      body: body
    );

    if (response.statusCode == 200) {

      return (response.bodyBytes);

    } else {
      throw Exception('Failed to do network requests: Error Code: ${response.statusCode}\nBody: ${response.body}');
    }
  }
}