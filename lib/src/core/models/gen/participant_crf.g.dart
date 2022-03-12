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
      uploads: (fields[5] as List).cast<GalleryItem>(),
      id: fields[6] as String,
      appName: fields[7] as String,
      created: fields[8] as String,
      consentVersion: fields[9] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ParticipantCrf obj) {
    writer
      ..writeByte(9)
      ..writeByte(1)
      ..write(obj.pid)
      ..writeByte(2)
      ..write(obj.visit)
      ..writeByte(3)
      ..write(obj.timepoint)
      ..writeByte(4)
      ..write(obj.document)
      ..writeByte(5)
      ..write(obj.uploads)
      ..writeByte(6)
      ..write(obj.id)
      ..writeByte(7)
      ..write(obj.appName)
      ..writeByte(8)
      ..write(obj.created)
      ..writeByte(9)
      ..write(obj.consentVersion);
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
      uploads: json['uploads'] as List<GalleryItem>,
      id: const Uuid().v4().toString(),
      appName: json['appName'] as String,
      created: DateTime.now().toString(),
      consentVersion: json['consentVersion'] as String,
    );

Map<String, dynamic> _$ParticipantCrfToJson(ParticipantCrf instance) =>
    <String, dynamic>{
      'pid': instance.pid,
      'visit': instance.visit,
      'timepoint': instance.timepoint,
      'document': instance.document.toJson(),
      'uploads': instance.uploads.map((e) => e.toJson()).toList(),
      'id': instance.id,
      'appName': instance.appName,
      'created': instance.created,
      'consentVersion': instance.consentVersion,
    };
