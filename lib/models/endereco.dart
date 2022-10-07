class Endereco {
  final String zipCode;
  final String state;
  final String city;
  final String district;
  final String street;

  Endereco(this.zipCode, this.state, this.city, this.district, this.street);

  Endereco.fromJson(Map<String, dynamic> json)
      : zipCode = json['zipCode'],
        state = json['state'],
        city = json['city'],
        district = json['district'],
        street = json['street'];

  Map<String, dynamic> toJson() => {
        'zipCode': zipCode,
        'state': state,
        'city': city,
        'district': district,
        'street': street
      };
}
