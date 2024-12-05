class Tips {
  final String hairType;
  final String characteristicHair;
  final String description;
  final String photo;

  Tips({
    required this.hairType,
    required this.characteristicHair,
    required this.description,
    required this.photo,
  });

  factory Tips.fromJson(Map<String, dynamic> json) {
    return Tips(
      hairType: json['hair_type'],
      characteristicHair: json['characteristic_hair'],
      description: json['description'],
      photo: json['photo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'hair_type': hairType,
      'characteristic_hair': characteristicHair,
      'description': description,
      'photo': photo,
    };
  }
}
