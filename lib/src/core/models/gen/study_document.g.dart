// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../study_document.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StudyDocumentAdapter extends TypeAdapter<StudyDocument> {
  @override
  final int typeId = 2;

  @override
  StudyDocument read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StudyDocument(
      name: fields[1] as String,
      type: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, StudyDocument obj) {
    writer
      ..writeByte(2)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.type);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StudyDocumentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StudyDocument _$StudyDocumentFromJson(Map<String, dynamic> json) =>
    StudyDocument(
      name: json['name'] as String,
      type: json['type'] as String,
    );

Map<String, dynamic> _$StudyDocumentToJson(StudyDocument instance) =>
    <String, dynamic>{
      'name': instance.name,
      'type': instance.type,
    };
