import 'dart:io';

class AddsModel {
  int? id;
  String? category;
  List<String>? images;
  List<File>? newImages;

  AddsModel({this.id, this.category, this.images, this.newImages});

  AddsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'];
    images = json['images'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['category'] = category;
    data['images'] = images;
    return data;
  }
}