import 'package:http/http.dart' as http;

class Endpoint {
  final http.Client client = new http.Client();
  final String baseUrl = 'http://10.0.2.2:8080/TaxiDeliveryServer';

  Future<http.Response> get(String s) {
    return client.get(baseUrl + s);
  }
}