class AddressTO {
  final String shortString;
  final List<double> ll;

  AddressTO({this.shortString, this.ll});

  factory AddressTO.fromJson(Map<String, dynamic> json) =>
      AddressTO(
          shortString: json['short_string'] as String,
          ll: json['ll'].cast<double>().toList(),
      );
}
