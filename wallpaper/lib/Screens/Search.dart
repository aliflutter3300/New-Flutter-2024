import 'package:flutter/material.dart';
import 'package:wallpaper/Models/PhotoModel.dart';
import 'package:wallpaper/Screens/FullScreen.dart';
import 'package:wallpaper/Widgets/CustomAppBar.dart';
import 'package:wallpaper/Widgets/SearchBar.dart';

import '../Controller/apiOperation.dart';


class Search extends StatefulWidget {
  final String query;

  Search({Key? key, required this.query}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  late List<PhotosModel> searchResult = [];
  bool isLoading=true;

  GetSearchResults() async {
    searchResult = await ApiOperation.searchWallpapers(widget.query);
    setState(() {
      isLoading=false;
    });
  }

  @override
  void initState() {
    super.initState();
    GetSearchResults();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
        elevation: 0,
        title: CustomAppBar(),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SearchBar(),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: GridView.builder(
                    physics: BouncingScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisExtent: 400,
                      crossAxisCount: 2,
                      crossAxisSpacing: 13,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: searchResult.length,
                    itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FullScreen(
                              imgUrl: searchResult[index].imgSrc,
                            ),
                          ),
                        );
                      },
                      child: Hero(
                        tag: searchResult[index].imgSrc,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black38,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          height: 600,
                          width: 50,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              searchResult[index].imgSrc,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
