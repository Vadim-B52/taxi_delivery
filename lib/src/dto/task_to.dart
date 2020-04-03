import 'address_to.dart';
import 'package_to.dart';

class TaskTO {
  final String id;
  final String type;
  final AddressTO address;
  final String description;
  final List<PackageTO> packages;
  final DateTime deadline;

  TaskTO(
      {this.id,
      this.type,
      this.address,
      this.description,
      this.packages,
      this.deadline});

  factory TaskTO.fromJson(Map<String, dynamic> json) => TaskTO(
        id: json['id'] as String,
        type: json['type'] as String,
        address: AddressTO.fromJson(json['address'] as Map<String, dynamic>),
        description: json['description'] as String,
        packages: json['packages']
            .cast<Map<String, dynamic>>()
            .map<PackageTO>((json) => PackageTO.fromJson(json))
            .toList(),
        deadline: DateTime.parse(json['deadline'] as String),
      );
}
