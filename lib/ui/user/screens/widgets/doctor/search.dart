import 'package:flutter/material.dart';

class Post {
  final String title;
  final String description;

  Post(this.title, this.description);
}

class Searching extends StatelessWidget {
  const Searching({Key key}) : super(key: key);

Future<List<Post>> search(String search) async {
  await Future.delayed(Duration(seconds: 2));
  return List.generate(search.length, (int index) {
    return Post(
      "Title : $search $index",
      "Description :$search $index",
    );
  });
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Text("test"),
        ),
        // child: SearchBar<Post>(
        //   searchBarPadding: EdgeInsets.symmetric(horizontal: 10),
        //   headerPadding: EdgeInsets.symmetric(horizontal: 10),
        //   listPadding: EdgeInsets.symmetric(horizontal: 10),
        //   onSearch: search,
        //   indexedScaledTileBuilder: (int index) => ScaledTile.count(1, index.isEven ? 2 : 1),
        //   mainAxisSpacing: 10,
        //   crossAxisSpacing: 10,
        //   crossAxisCount: 2,
        //   onItemFound: (Post post, int index) {
        //     return Container(
        //       color: Colors.lightBlue,
        //       child: ListTile(
        //         title: Text(post.title),
        //         isThreeLine: true,
        //         onTap: () {
        //         },
        //       ),
        //     );
        //   },
        // ),
      ),
    );
  }
}