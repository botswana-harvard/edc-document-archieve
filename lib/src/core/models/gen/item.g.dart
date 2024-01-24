// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ItemAdapter extends TypeAdapter<Item> {
  @override
  final int typeId = 6;

  @override
  Item read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Item(
      pid: fields[1] as String,
      modelName: fields[2] as String,
      status: fields[4] as String,
      created: fields[3] as String,
      document: fields[5] as StudyDocument,
    );
  }

  @override
  void write(BinaryWriter writer, Item obj) {
    writer
      ..writeByte(5)
      ..writeByte(1)
      ..write(obj.pid)
      ..writeByte(2)
      ..write(obj.modelName)
      ..writeByte(3)
      ..write(obj.created)
      ..writeByte(4)
      ..write(obj.status)
      ..writeByte(5)
      ..write(obj.document);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Item _$ItemFromJson(Map<String, dynamic> json) => Item(
      pid: json['pid'] as String,
      modelName: json['modelName'] as String,
      status: json['status'] as String,
      created: json['created'] as String,
      document:
          StudyDocument.fromJson(json['document'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'pid': instance.pid,
      'modelName': instance.modelName,
      'created': instance.created,
      'status': instance.status,
      'document': instance.document.toJson(),
    };
