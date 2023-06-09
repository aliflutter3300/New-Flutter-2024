import 'package:flutter/material.dart';

class CatBlock extends StatelessWidget {
  final String categoryName;
  final String categoryImgSrc;

  const CatBlock({
    Key? key,
    required this.categoryImgSrc,
    required this.categoryName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryScreen(
              catImgUrl: categoryImgSrc,
              catName: categoryName,
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                categoryImgSrc,
                height: 50,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              height: 50,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.black38,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            Positioned(
              left: 30,
              top: 15,
              child: Text(
                categoryName,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryScreen extends StatelessWidget {
  final String catImgUrl;
  final String catName;

  const CategoryScreen({
    Key? key,
    required this.catImgUrl,
    required this.catName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(catName),
      ),
      body: Center(
        child: Image.network(catImgUrl),
      ),
    );
  }
}
