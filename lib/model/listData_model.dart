// ignore_for_file: file_names

const String tableLists = "Lists";

class ListField {
  static final List<String> values = [
    id,
    name,
    email,
    mobileNumber,
    description,
    createdTime,
  ];
  static const String id = "id";
  static const String name = "name";
  static const String email = "email";
  static const String mobileNumber = "mobileNumber";
  static const String description = "description";
  static const String createdTime = "createdTime";
}

class ListData {
  final int? id;
  final String name;
  final String email;
  final String mobileNumber;
  final String description;
  final DateTime createdTime;

  ListData({
    this.id,
    this.name = "",
    this.email = "",
    this.mobileNumber = "",
    this.description = "",
    required this.createdTime,
  });

  ListData copy({
    int? id,
    String? name,
    String? email,
    String? mobileNumber,
    String? description,
    DateTime? createdTime,
  }) =>
      ListData(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        mobileNumber: mobileNumber ?? this.mobileNumber,
        description: description ?? this.description,
        createdTime: createdTime ?? this.createdTime,
      );

  factory ListData.fromJson(Map<String, dynamic> json) => ListData(
        id: json[ListField.id],
        name: json[ListField.name],
        email: json[ListField.email],
        mobileNumber: json[ListField.mobileNumber],
        description: json[ListField.description],
        createdTime: DateTime.parse(json[ListField.createdTime]),
      );

  Map<String, Object?> toJson() => {
        ListField.id: id,
        ListField.name: name,
        ListField.email: email,
        ListField.mobileNumber: mobileNumber,
        ListField.description: description,
        ListField.createdTime: createdTime.toIso8601String(),
      };
}
