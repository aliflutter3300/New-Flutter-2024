import 'package:flutter/material.dart';
import 'package:wallpaper/Screens/Search.dart';


class SearchBar extends StatefulWidget {

  const SearchBar({Key? key}) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  TextEditingController _searchController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey,
        border: Border.all(color: Colors.black38),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Icon(Icons.search),
          ),
          Expanded(
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Search Wallpapers",
                errorBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Search(query: _searchController.text),
                  ),
                );
              },
              child: Icon(
                Icons.arrow_forward,
              ),
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Padding(
            padding: EdgeInsets.only(right: 15),
            child: GestureDetector(
              onTap: () {
                _searchController.clear(); // Clear the search text
              },
              child: Icon(Icons.cancel),
            ),
          ),
        ],
      ),
    );
  }
}
