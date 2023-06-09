import 'package:flutter/material.dart';
import 'package:wallpaper/Controller/apiOperation.dart';
import 'package:wallpaper/Models/CategoryModel.dart';
import 'package:wallpaper/Models/PhotoModel.dart';
import 'package:wallpaper/Screens/FullScreen.dart';
import 'package:wallpaper/Widgets/CatBlock.dart';
import 'package:wallpaper/Widgets/CustomAppBar.dart';
import 'package:wallpaper/Widgets/SearchBar.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late List<PhotosModel> trendingWallpapersList = [];
  late List<CategoryModel> CatModList;
  bool isLoading = true;

  GetCatDetails() async {
    CatModList = await ApiOperation.getCategoriesList();
    print("GETTTING CAT MOD LIST");
    print(CatModList);
    setState(() {
      CatModList = CatModList;
    });
  }

  Future<void> getTrendingWallpapers() async {
    trendingWallpapersList = await ApiOperation.getTrendingWallpapers();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    GetCatDetails();
    getTrendingWallpapers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.tealAccent,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.tealAccent,
        elevation: 0,
        title: CustomAppBar(),
      ),
      body: isLoading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SearchBar(),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: CatModList.length,
                    itemBuilder: (context, index) => CatBlock(
                      categoryImgSrc: CatModList[index].catImgUrl,
                      categoryName: CatModList[index].catName,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: SizedBox(
                    height: 700,
                    child: GridView.builder(
                      physics: BouncingScrollPhysics(),
                      gridDelegate:
                      SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisExtent: 350,
                        crossAxisCount: 2,
                        crossAxisSpacing: 13,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: trendingWallpapersList.length,
                      itemBuilder: (context, index) => GridTile(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FullScreen(
                                  imgUrl: trendingWallpapersList[index]
                                      .imgSrc,
                                ),
                              ),
                            );
                          },
                          child: Hero(
                            tag: trendingWallpapersList[index].imgSrc,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black38,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(
                                  trendingWallpapersList[index].imgSrc,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
