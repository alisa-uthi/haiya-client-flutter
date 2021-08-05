class Address {
  final int id;
  final String addrId;
  final String? addrRoom;
  final int? addrFloor;
  final String addrNo;
  final int? addrMoo;
  final String? addrSoi;
  final String addrRoad;
  final String addrSubDistrict;
  final String addrDistrict;
  final String addrProvince;
  final int addrPostalCode;
  final double addrLongitude;
  final double addrLatitude;

  Address({
    required this.id,
    required this.addrId,
    this.addrRoom,
    this.addrFloor,
    required this.addrNo,
    this.addrMoo,
    this.addrSoi,
    required this.addrRoad,
    required this.addrSubDistrict,
    required this.addrDistrict,
    required this.addrProvince,
    required this.addrPostalCode,
    required this.addrLatitude,
    required this.addrLongitude,
  });

  @override
  String toString() {
    String room = this.addrRoom == null ? '' : 'Room ${this.addrRoom}, ';
    String floor = this.addrFloor == null ? '' : 'Floor ${this.addrFloor}, ';
    String moo = this.addrMoo == null ? '' : 'Moo ${this.addrMoo}, ';
    String soi = this.addrSoi == null ? '' : 'Soi ${this.addrSoi}, ';
    return '$room$floor${this.addrNo}, $moo$soi${this.addrRoad}, ${this.addrSubDistrict}, ${this.addrDistrict}, ${this.addrProvince}, ${this.addrPostalCode}';
  }
}
