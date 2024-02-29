import "package:json_annotation/json_annotation.dart";

part 'translation_data_model.g.dart';

@JsonSerializable()
class TranslationDataModel {
  @JsonKey(name: "data")
  List<Data>? data;

  TranslationDataModel({
    this.data,
  });

  factory TranslationDataModel.fromJson(Map<String, dynamic> json) =>
      _$TranslationDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$TranslationDataModelToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "value")
  String? value;
  @JsonKey(name: "createdAt")
  DateTime? createdAt;
  @JsonKey(name: "updatedAt")
  DateTime? updatedAt;

  Data({
    this.id,
    this.value,
    this.createdAt,
    this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
