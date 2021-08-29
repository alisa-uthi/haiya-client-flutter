class CongenitalDisease {
  int? id;
  String? name;
  String? reaction;
  String? severity;

  CongenitalDisease({
    this.id,
    this.name,
    this.reaction,
    this.severity,
  });

  @override
  String toString() {
    return "${this.name}, ${this.reaction}, ${this.severity}";
  }

  factory CongenitalDisease.fromJson(Map<String, dynamic> json) {
    return CongenitalDisease(
      id: json['ID'],
      name: json['Cdi_Name'],
      reaction: json['Cdi_Reaction'],
      severity: json['Cdi_Severity'],
    );
  }
}
