class PackageTO {
  final String id;
  final String status;

  PackageTO({this.id, this.status});

  factory PackageTO.fromJson(Map<String, dynamic> json) =>
      PackageTO(id: json['id'] as String, status: json['status'] as String);
}
