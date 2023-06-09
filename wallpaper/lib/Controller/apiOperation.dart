import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:wallpaper/Models/CategoryModel.dart';
import 'package:wallpaper/Models/PhotoModel.dart';



class ApiOperation {
  static List<PhotosModel> trendingWallpapers = [];
  static List<PhotosModel> searchWallpapersList = [];
  static List<CategoryModel> cateogryModelList = [];



  static Future<List<PhotosModel>> getTrendingWallpapers() async {
    await http
        .get(
      Uri.parse("https://api.pexels.com/v1/curated?per_page=20"), // Update per_page to desired number of wallpapers
      headers: {
        "Authorization": "Yye69cs4ducbirMZpFSeYLCJmWCEVSeZR8WuVroTB6JgSBSFOzU3Hfyi"
      },
    )
        .then((value) {
      Map<String, dynamic> jsonData = jsonDecode(value.body);
      List photos = jsonData["photos"];
      photos.forEach((element) {
        Map<String, dynamic> src = element["src"];
        trendingWallpapers.add(PhotosModel.fromApi2App(element));
      });
    });
    return trendingWallpapers;
  }





 static Future<List<PhotosModel>> searchWallpapers(String query) async{
    await http
        .get(
      Uri.parse("https://api.pexels.com/v1/search?query=$query&per_page=30&page=1"), // Update per_page to desired number of wallpapers
      headers: {
        "Authorization": "Yye69cs4ducbirMZpFSeYLCJmWCEVSeZR8WuVroTB6JgSBSFOzU3Hfyi"
      },
    )
        .then((value) {
      Map<String, dynamic> jsonData = jsonDecode(value.body);
      List photos = jsonData["photos"];
      searchWallpapersList.clear();
      photos.forEach((element) {

        searchWallpapersList.add(PhotosModel.fromApi2App(element));
      });
    });
    return searchWallpapersList;
  }
  static List<CategoryModel> getCategoriesList() {
    List cateogryName = [
      "Cars",
      "Nature",
      "Bikes",
      "Street",
      "City",
      "Flowers"

    ];
    cateogryModelList.clear();
    cateogryName.forEach((catName) async {
      final _random = new Random();

      PhotosModel photoModel =
      (await searchWallpapers(catName))[0 + _random.nextInt(11 - 0)];
      print("IMG SRC IS HERE");
      print(photoModel.imgSrc);
      cateogryModelList
          .add(CategoryModel(catImgUrl: photoModel.imgSrc, catName: catName));
    });

    return cateogryModelList;
  }


}



