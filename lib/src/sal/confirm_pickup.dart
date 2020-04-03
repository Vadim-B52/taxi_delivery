import 'dart:async';

import '../api/endpoint.dart';

Future<bool> confirmPickup(Endpoint endpoint, String packageId) async {
  final response = await endpoint.get('/confirmpickup?id=$packageId');
  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}