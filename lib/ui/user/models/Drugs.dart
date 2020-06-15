

class Drugs {
  String name;


  Drugs({
    this.name,
  });

  factory Drugs.fromJson(Map<String, dynamic> parsedJson) {
    return Drugs(
        name: parsedJson['brand_name'] as String,
    );
  }
}


