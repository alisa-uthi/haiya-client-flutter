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

  set _name(String value) {
    this.name = value;
  }

  set _reaction(String value) {
    this.reaction = value;
  }

  set _severity(String value) {
    this.severity = value;
  }

  @override
  String toString() {
    return "${this.name}, ${this.reaction}, ${this.severity}";
  }
}
