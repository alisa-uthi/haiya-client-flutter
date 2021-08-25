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
}
