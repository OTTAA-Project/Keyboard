// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'keyboard_layouts.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class KeyboardLayoutAdapter extends TypeAdapter<KeyboardLayout> {
  @override
  final int typeId = 1;

  @override
  KeyboardLayout read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return KeyboardLayout.qwerty;
      case 1:
        return KeyboardLayout.abc;
      case 2:
        return KeyboardLayout.keypad;
      default:
        return KeyboardLayout.qwerty;
    }
  }

  @override
  void write(BinaryWriter writer, KeyboardLayout obj) {
    switch (obj) {
      case KeyboardLayout.qwerty:
        writer.writeByte(0);
        break;
      case KeyboardLayout.abc:
        writer.writeByte(1);
        break;
      case KeyboardLayout.keypad:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is KeyboardLayoutAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
