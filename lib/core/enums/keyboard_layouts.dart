
import 'package:hive/hive.dart';

part 'keyboard_layouts.g.dart';
@HiveType(typeId: 1)
enum KeyboardLayout {
  @HiveField(0)
  qwerty,
  @HiveField(1)
  abc,
  @HiveField(2)
  keypad,
}

enum KeyboardTypes { qwerty, emojis, numbers }
