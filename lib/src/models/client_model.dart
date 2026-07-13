import 'package:uuid/uuid.dart';

class ClientModel {
  final String id;
  final String name;
  final String email;
  final String phone;

  ClientModel({
    String? id,
    required this.name,
    required this.email,
    required this.phone,
  }) : id = id ?? const Uuid().v4();

  ClientModel copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
  }) {
    return ClientModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
    };
  }

  factory ClientModel.fromMap(Map<String, dynamic> map) {
    return ClientModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ClientModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
