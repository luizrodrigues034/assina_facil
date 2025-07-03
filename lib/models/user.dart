import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String? cpf;
  final String? photoURL;
  final DateTime? createdAt;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.cpf,
    this.photoURL,
    this.createdAt,
  });

  String get fullName => '$firstName $lastName';

  String get displayName => fullName;

  String get initials => '${firstName.isNotEmpty ? firstName[0] : ''}${lastName.isNotEmpty ? lastName[0] : ''}'.toUpperCase();

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'cpf': cpf,
      'photoURL': photoURL,
      'createdAt': createdAt?.toIso8601String(),
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      email: json['email'],
      cpf: json['cpf'],
      photoURL: json['photoURL'],
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
    );
  }

  factory UserModel.fromFirebaseUser(User user) {
    final displayName = user.displayName ?? '';
    final nameParts = displayName.split(' ');
    
    return UserModel(
      id: user.uid,
      firstName: nameParts.isNotEmpty ? nameParts.first : '',
      lastName: nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '',
      email: user.email ?? '',
      photoURL: user.photoURL,
      createdAt: user.metadata.creationTime,
    );
  }

  UserModel copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? cpf,
    String? photoURL,
    DateTime? createdAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      cpf: cpf ?? this.cpf,
      photoURL: photoURL ?? this.photoURL,
      createdAt: createdAt ?? this.createdAt,
    );
  }
} 