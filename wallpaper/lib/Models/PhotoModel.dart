import 'dart:core';

class PhotosModel{
  String imgSrc;
  String photoName;

  PhotosModel({required this.imgSrc,required this.photoName});

  static fromApi2App(Map<String, dynamic> photoMap){
    return PhotosModel(imgSrc: (photoMap["src"])["portrait"], photoName: photoMap["photographer"]);
  }
}