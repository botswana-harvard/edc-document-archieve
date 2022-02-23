// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../participant_crf.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ParticipantCrfAdapter extends TypeAdapter<ParticipantCrf> {
  @override
  final int typeId = 3;

  @override
  ParticipantCrf read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ParticipantCrf(
      pid: fields[1] as String,
      visit: fields[2] as String,
      timepoint: fields[3] as String,
      document: fields[4] as StudyDocument,
      uploads: (fields[5] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, ParticipantCrf obj) {
    writer
      ..writeByte(5)
      ..writeByte(1)
      ..write(obj.pid)
      ..writeByte(2)
      ..write(obj.visit)
      ..writeByte(3)
      ..write(obj.timepoint)
      ..writeByte(4)
      ..write(obj.document)
      ..writeByte(5)
      ..write(obj.uploads);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ParticipantCrfAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParticipantCrf _$ParticipantCrfFromJson(Map<String, dynamic> json) =>
    ParticipantCrf(
      pid: json['pid'] as String,
      visit: json['visit'] as String,
      timepoint: json['timepoint'] as String,
      document:
          StudyDocument.fromJson(json['document'] as Map<String, dynamic>),
      uploads:
          (json['uploads'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$ParticipantCrfToJson(ParticipantCrf instance) =>
    <String, dynamic>{
      'pid': instance.pid,
      'visit': instance.visit,
      'timepoint': instance.timepoint,
      'document': instance.document.toJson(),
      'uploads': instance.uploads,
    };
