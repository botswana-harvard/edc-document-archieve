// // GENERATED CODE - DO NOT MODIFY BY HAND

// part of '../study_document.dart';

// // **************************************************************************
// // TypeAdapterGenerator
// // **************************************************************************

// class StudyDocumentAdapter extends TypeAdapter<StudyDocument> {
//   @override
//   final int typeId = 2;

//   @override
//   StudyDocument read(BinaryReader reader) {
//     final numOfFields = reader.readByte();
//     final fields = <int, dynamic>{
//       for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
//     };
//     return StudyDocument(
//       name: fields[1] as String,
//       type: fields[2] as String,
//       id: fields[3] as String,
//       pidType: fields[4] as String,
//       appName: fields[5] as String,
//     );
//   }

//   @override
//   void write(BinaryWriter writer, StudyDocument obj) {
//     writer
//       ..writeByte(4)
//       ..writeByte(1)
//       ..write(obj.name)
//       ..writeByte(2)
//       ..write(obj.type)
//       ..writeByte(3)
//       ..write(obj.id)
//       ..writeByte(4)
//       ..write(obj.pidType)
//       ..writeByte(5)
//       ..write(obj.appName);
//   }

//   @override
//   int get hashCode => typeId.hashCode;

//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       other is StudyDocumentAdapter &&
//           runtimeType == other.runtimeType &&
//           typeId == other.typeId;
// }

// // **************************************************************************
// // JsonSerializableGenerator
// // **************************************************************************

// StudyDocument _$StudyDocumentFromJson(Map<String, dynamic> json) =>
//     StudyDocument(
//       name: json['name'] as String,
//       type: json['type'] as String,
//       id: const Uuid().v4().toString(),
//       pidType: json['pidType'] as String,
//       appName: json['appName'] as String,
//     );

// Map<String, dynamic> _$StudyDocumentToJson(StudyDocument instance) =>
//     <String, dynamic>{
//       'name': instance.name,
//       'type': instance.type,
//       'id': instance.id,
//       'pidType': instance.pidType,
//       'appName': instance.appName,
//     };
