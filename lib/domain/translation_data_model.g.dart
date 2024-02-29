// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'translation_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TranslationDataModel _$TranslationDataModelFromJson(
        Map<String, dynamic> json) =>
    TranslationDataModel(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Data.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TranslationDataModelToJson(
        TranslationDataModel instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      id: json['id'] as int?,
      value: json['value'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'id': instance.id,
      'value': instance.value,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
