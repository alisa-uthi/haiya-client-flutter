class DrugAllergy {
  int? id;
  String? name;
  String? reaction;
  String? severity;

  DrugAllergy({
    this.id,
    this.name,
    this.reaction,
    this.severity,
  });

  @override
  String toString() {
    return "${this.name}, ${this.reaction}, ${this.severity}";
  }

  factory DrugAllergy.fromJson(Map<String, dynamic> json) {
    return DrugAllergy(
      id: json['ID'],
      name: json['Dal_Name'],
      reaction: json['Dal_Reaction'],
      severity: json['Dal_Severity'],
    );
  }
}
