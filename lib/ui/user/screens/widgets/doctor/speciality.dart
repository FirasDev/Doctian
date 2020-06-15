class Speciality{
  final String name;

  Speciality({this.name});

  factory Speciality.fromJson(Map<String, dynamic> json) {
    return new Speciality(
      name: json['en'] as String,
    );
  }
}