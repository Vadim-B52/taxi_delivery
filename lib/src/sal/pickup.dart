import 'dart:async';

import '../api/endpoint.dart';

Future<bool> pickup(Endpoint endpoint, String packageId) async {
  final response = await endpoint.get('/pickup?id=$packageId');
  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}