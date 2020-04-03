class CustomerTO {
  final String name;
  final String surname;
  final String phone;

  CustomerTO({this.name, this.surname, this.phone});

  factory CustomerTO.fromJson(Map<String, dynamic> json) =>
      CustomerTO(
        name: json['name'] as String,
        surname: json['surname'] as String,
        phone: json['phone'] as String,
      );
}