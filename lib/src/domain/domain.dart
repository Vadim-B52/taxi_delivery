import 'package:flutter/foundation.dart';

class Minitask {
  final String id;
  final MinitaskType type;
  final Address address;
  final String description;
  final List<Package> packages;
  final DateTime deadline;

  Minitask({
    @required this.id,
    @required this.type,
    @required this.address,
    @required this.description,
    @required this.packages,
    @required this.deadline,
  });
}

enum MinitaskType {
  pickup,
  delivery,
}

class Address {
  final String shortText;
  final Coordinate coordinate;

  Address({@required this.shortText, @required this.coordinate});
}

class Coordinate {
  final double latitude;
  final double longitude;

  Coordinate({@required this.latitude, @required this.longitude});
}

class Package {
  final String id;
  final PackageStatus status;
  final Customer customer;

  Package({@required this.id, @required this.status, @required this.customer});
}

enum PackageStatus {
  pending,
  picked,
  delivered,
  declinedByCustomer,
  declinedByCourier,
}

class Customer {
  final String name;
  final String surname;
  final String phone;

  // TODO: copied from internet
  String get initials {
    final fullName = this.fullName;
    if (fullName.isEmpty) return " ";

    List<String> nameArray =
    fullName.replaceAll(new RegExp(r"\s+\b|\b\s"), " ").split(" ");
    String initials = ((nameArray[0])[0] != null ? (nameArray[0])[0] : " ") +
        (nameArray.length == 1 ? " " : (nameArray[nameArray.length - 1])[0]);

    return initials;
  }

  String get fullName => '$name $surname';

  Customer({@required this.name, @required this.surname, @required this.phone});
}
