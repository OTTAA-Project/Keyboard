import 'package:hive/hive.dart';
import 'package:keyboard/core/enums/keyboard_layouts.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel extends HiveObject{
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String email;

  @HiveField(3)
  final String photoUrl;

  @HiveField(4)
  final String language;

  @HiveField(5)
  final KeyboardLayout keyboardLayout;

  @HiveField(6)
  final double fontSize;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.photoUrl,
    required this.language,
    required this.keyboardLayout,
    required this.fontSize,
  });

  factory UserModel.fromMap(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      photoUrl: json['photoUrl'],
      language: json['language'],
      keyboardLayout: KeyboardLayout.values.firstWhere((e) => e.name == json['keyboardLayout']),
      fontSize: double.tryParse(json['fontSize']) ?? 0.5,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
      'language': language,
      'keyboardLayout': keyboardLayout.name,
      'fontSize': fontSize.toString(),
    };
  }


  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? photoUrl,
    String? language,
    KeyboardLayout? keyboardLayout,
    double? fontSize,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      language: language ?? this.language,
      keyboardLayout: keyboardLayout ?? this.keyboardLayout,
      fontSize: fontSize ?? this.fontSize,
    );
  }
}
