class Address {
  int id;
  String name;
  String location;
  String? additionalInfo;
  double? latitude;
  double? longitude;
  String isDeliveryAddress;

  Address({
    required this.id,
    required this.name,
    required this.location,
    this.additionalInfo,
    this.latitude,
    this.longitude,
    required this.isDeliveryAddress,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['ID'],
      name: json['Addr_Name'],
      location: json['Addr_Location'],
      additionalInfo: json['Addr_AdditionalInfo'],
      latitude: double.parse(json['Addr_Latitude']),
      longitude: double.parse(json['Addr_Longitude']),
      isDeliveryAddress: json['IsDeliveryAddress'],
    );
  }
}

List<Address> userAddress = [];
