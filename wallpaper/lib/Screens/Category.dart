import 'package:flutter/material.dart';
import 'package:wallpaper/Models/PhotoModel.dart';

import 'package:wallpaper/Screens/FullScreen.dart';
import 'package:wallpaper/Widgets/CustomAppBar.dart';

class Category extends StatefulWidget {
  String catName;
  String catImgUrl;

  Category({Key? key,required this.catName,required this.catImgUrl}) : super(key: key);

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  late List<PhotosModel> categoryResults;


  @override
  void initState() {
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: CustomAppBar(),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [

              Stack(
                children: [
                  Image.network(
                      width: MediaQuery.of(context).size.width,
                      height: 150,
                      fit: BoxFit.cover,
                      widget.catImgUrl),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 150,
                    color: Colors.black38,
                  ),
                  Positioned(
                    left: 130,
                    top: 40,
                    child: Column(children: [
                      Text("Category",style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.w200)),
                      Text("Mountain",style: TextStyle(fontSize: 30,color: Colors.white,fontWeight: FontWeight.w600),)
                    ],),
                  )
                ],
              ),
              SizedBox(height: 20,),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: GridView.builder(
                    physics: BouncingScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisExtent: 400,
                        crossAxisCount: 2,
                        crossAxisSpacing: 13,
                        mainAxisSpacing: 10

                    ),
                    itemCount: 16,
                    itemBuilder: (context, index) => GridTile(
                      child: InkWell(
                        onTap: (){ Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FullScreen(
                              imgUrl: categoryResults[index].imgSrc,
                            ),
                          ),
                        );},
                        child: Hero(
                          tag: categoryResults[index].imgSrc,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.black38,
                                borderRadius: BorderRadius.circular(20)
                            ),
                            height: 1500,
                            width: 50,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                  fit: BoxFit.cover,
                                  categoryResults[index].imgSrc),
                            ), ),
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
