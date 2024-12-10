class HairStyle {
  final int id;
  final String hairStyle;
  final String faceShape;
  final String characteristics;
  final String faceSuitability;
  final String maintenance;
  final String impression;
  final String photo;

  HairStyle({
    required this.id,
    required this.hairStyle,
    required this.faceShape,
    required this.characteristics,
    required this.faceSuitability,
    required this.maintenance,
    required this.impression,
    required this.photo,
  });

  factory HairStyle.fromJson(Map<String, dynamic> json) {
    return HairStyle(
      id: json['id'] ?? 0,
      hairStyle: json['hair_style'] ?? '',
      faceShape: json['face_shape'] ?? '',
      characteristics: json['characteristics'] ?? '',
      faceSuitability: json['face_suitability'] ?? '',
      maintenance: json['maintenance'] ?? '',
      impression: json['impression'] ?? '',
      photo: json['photo'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'hair_style': hairStyle,
      'face_shape': faceShape,
      'characteristics': characteristics,
      'face_suitability': faceSuitability,
      'maintenance': maintenance,
      'impression': impression,
      'photo': photo,
    };
  }
}
