import 'customer_to.dart';

class PackageTO {
  final String id;
  final String status;
  final CustomerTO customer;

  PackageTO({this.id, this.status, this.customer});

  factory PackageTO.fromJson(Map<String, dynamic> json) => PackageTO(
        id: json['id'] as String,
        status: json['status'] as String,
        customer: CustomerTO.fromJson(json['customer']),
      );
}
