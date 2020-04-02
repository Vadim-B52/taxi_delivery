class AddressTO {
  final String shortString;

  AddressTO({this.shortString});

  factory AddressTO.fromJson(Map<String, dynamic> json) =>
      AddressTO(shortString: json['short_string'] as String);
}
