class Rating {
  final int id;
  final String timestamp;
  final int? pharmacyId;
  final int? pharmacyScore;
  final String? pharmacyFeedback;
  final int patientId;
  final String patientName;
  final String patientImage;

  Rating({
    required this.id,
    required this.timestamp,
    this.pharmacyId,
    this.pharmacyScore,
    this.pharmacyFeedback,
    required this.patientId,
    required this.patientImage,
    required this.patientName,
  });

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      id: json['ID'],
      timestamp: json['Rate_Timestamp'],
      pharmacyId: json['Rate_Pharmacy_ID'],
      pharmacyScore: json['Rate_Pharmacy_Score'],
      pharmacyFeedback: json['Rate_Pharmacy_Feedback'],
      patientId: json['Rate_Patient_ID'],
      patientImage: json['patientImage'],
      patientName: json['patientName'],
    );
  }
}
