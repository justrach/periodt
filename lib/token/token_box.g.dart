// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_box.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TokenBoxAdapter extends TypeAdapter<TokenBox> {
  @override
  final int typeId = 0;

  @override
  TokenBox read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TokenBox()..token = fields[0] as String;
  }

  @override
  void write(BinaryWriter writer, TokenBox obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.token);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TokenBoxAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
